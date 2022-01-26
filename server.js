
/* ********* SETUP *********************************************************************************************************************************** */
const
  mysql = require('mysql'),
  express = require('express'),
  { dirname } = require('path'),
  path = require("path"),
  fs = require('fs'),
  app = express(),
  expHbs = require('express-handlebars'),
  https = require('https'),
  bcrypt = require('bcrypt'),
  passport = require('passport'),
  localStrat = require('passport-local').Strategy,
  methodOverride = require('method-override'),
  flash = require("express-flash"),
  session = require("express-session"),
  sslServer = https.createServer({
    key: fs.readFileSync(path.join(__dirname, 'cert', 'key.pem')),
    cert: fs.readFileSync(path.join(__dirname, 'cert', 'cert.pem'))
  }, app),
  hbs = expHbs.create({
    extname: "hbs",
    layoutsDir: `${__dirname}/views/layouts`,
    partialsDir: __dirname + "/views/partials"
  });

function initPassport(passport) {
  const authUser = async (username, password, done) => {
    let sql = `SELECT * FROM evcUser WHERE username = ?;`
    sqlCon.query(sql, [username], async (sqlErr, sqlRes) => {
      if (sqlErr) {
        console.log("ERROR: Error fulfilling SQL-query!\n" + sqlErr);
      } else {
        const user = sqlRes[0];
        if (user === undefined) {
          return done(null, false, { message: "Es existiert kein Konto mit diesem Nutznamen" })
        }
        try {
          if (await bcrypt.compare(password, user.userPassword)) {
            return done(null, user)
          } else {
            return done(null, false, { message: "Password inkorrekt" })
          }
        } catch (e) {
          return done(e)
        }
      }
    })
  }
  passport.use(new localStrat(authUser));
  passport.serializeUser((user, done) => done(null, user.userId))
  passport.deserializeUser((id, done) => {
    let sql = `SELECT * FROM evcUser WHERE userId = ?;`;
    sqlCon.query(sql, [id], async (sqlErr, sqlRes) => {
      if (sqlErr) {
        console.log("ERROR: Error fulfilling SQL-query!\n" + sqlErr);
        return null;
      } else {
        return done(null, sqlRes[0])
      }
    })
  })
}

initPassport(passport);

//setting static folder to "/public"
app.use(express.static(path.join(__dirname, "/public")));
app.use(flash());
app.use(session({
  secret: "Jf&4jtg/Fj585sj(T90jg/jgf7&()DJ6fjf&/jf/hgF(9J",
  resave: false,
  saveUninitialized: false
}));
app.use(passport.initialize());
app.use(passport.session());
app.use(methodOverride("_method"));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.engine("handlebars", hbs.engine);
app.set("view engine", "handlebars");

/* *******///SETUP//********************************************************************************************************************************** */

function checkAuth(req, res, next) {
  if (req.isAuthenticated()) {
    return next()
  }
  res.redirect("/home")
}

function checkNotAuth(req, res, next) {
  if (req.isAuthenticated()) {
    return res.redirect("/")
  }
  next()
}


app.get("/", (req, res) => {
  res.redirect("/home");
})

app.get("/survey", (req,res) => {
  res.render("empty",{layout: "survey", signedIn: req.isAuthenticated()})
})

app.get("/home", (req, res) => {
  if(req.isAuthenticated()){
    res.render("homeDataSI", { layout: "home", signedIn: req.isAuthenticated(), username: req.user.username });
  } else {
    res.render("homeData", { layout: "home", signedIn: req.isAuthenticated()});
  }
})

app.get("/login", checkNotAuth, (req, res) => {
  res.render("empty", { layout: "login", signedIn: req.isAuthenticated() });
})

app.get("/kompass", (req, res) => {
  const signedIn = req.isAuthenticated();
  let sql = signedIn ?
    `
    SELECT * FROM checkup WHERE 
    (checkupMinAge <= TIMESTAMPDIFF(YEAR, (SELECT userBirthdate FROM evcUser WHERE userId = ${req.user.userId}), CURDATE())
    OR checkupMinAge = null)
    AND  ( checkupMaxAge >= TIMESTAMPDIFF(YEAR, (SELECT userBirthdate FROM evcUser WHERE userId = ${req.user.userId}), CURDATE())
    OR checkupMaxAge = null)
    AND (checkupSex = 'mw' OR checkupSex = (SELECT userSex FROM evcUser WHERE userId = ${req.user.userId}))
    AND checkupType = "checkup"
    ORDER BY checkupMinAge;

    SELECT * FROM checkup
    WHERE checkupMinAge <= TIMESTAMPDIFF(YEAR, (SELECT userBirthdate FROM evcUser WHERE userId = ${req.user.userId}), CURDATE())
    AND checkupMaxAge >= TIMESTAMPDIFF(YEAR, (SELECT userBirthdate FROM evcUser WHERE userId = ${req.user.userId}), CURDATE())
    AND checkupType = "vaccination"
    ORDER BY checkupMinAge;

    SELECT * FROM checkup
    WHERE (checkupSex = 'mw' OR checkupSex = (SELECT userSex FROM evcUser WHERE userId = ${req.user.userId}))
    ORDER BY checkupMinAge ASC, checkupType, checkupName;
    `
    :
    `
    SELECT * FROM checkup
    WHERE checkupMinAge >= 18
    AND checkupType = 'checkup'
    AND checkupSex = 'mw'
    ORDER BY checkupMinAge;

    SELECT * FROM checkup
    WHERE checkupMinAge >= 18
    AND checkupType = 'checkup'
    AND checkupSex = 'w'
    ORDER BY checkupMinAge;

    SELECT * FROM checkup
    WHERE checkupMinAge >= 18
    AND checkupType = 'checkup'
    AND checkupSex = 'm'
    ORDER BY checkupMinAge;

    SELECT * FROM checkup
    WHERE checkupMinAge >= 18
    AND checkupType = 'vaccination'
    ORDER BY checkupMinAge;

    SELECT * FROM checkup
    WHERE checkupMaxAge <= 18
    AND checkupType = "checkup"
    ORDER BY checkupMinAge;

    SELECT * FROM checkup
    WHERE checkupMaxAge <= 18
    AND checkupType = "vaccination"
    ORDER BY checkupMinAge;
    `
  sqlCon.query(sql, (sqlErr, sqlRes) => {
    if (sqlErr) {
      console.log("DB_ERR: Error retrieving checkups! \n" + sqlErr)
      res.redirect("/")
    }
    else {
      if (signedIn) {
        res.render("kompassDataSI", { layout: "kompass", signedIn: signedIn, checkupSI: sqlRes[0], checkupVaccSI: sqlRes[1], checkups: sqlRes[2] });
      }
      else {
        res.render("kompassData", { layout: "kompass", signedIn: signedIn, checkupMW: sqlRes[0], checkupW: sqlRes[1], checkupM: sqlRes[2], checkupVacc: sqlRes[3], checkupK: sqlRes[4], checkupKVacc: sqlRes[5] });
      }
    }
  })
})

app.get("/arztfinder", (req, res) => {
  let sql = `
    SELECT * FROM checkup;
    SELECT DISTINCT * FROM evcDoctor;
    SELECT DISTINCT doctorCityPublic FROM evcDoctor;`;
  sqlCon.query(sql, (sqlErr, sqlRes) => {
    if (sqlErr) {
      console.log("DB_ERR: Error retrieving checkups for doc finder! \n" + sqlErr)
      res.redirect("/home");
    }
    else {
      let checkups = sqlRes[0];
      let doctors = sqlRes[1];
      let cities = sqlRes[2];
      console.log(sqlRes);
      res.render("arztfinderData", { layout: "arztfinder", signedIn: req.isAuthenticated(), checkups: checkups, doctors: doctors, cities: cities });
    }
  })

})

app.post("/arztfinder", (req, res) => {
  console.log(req.body)
  let sql = `
    SELECT * FROM checkup;
    SELECT DISTINCT doctorCityPublic FROM evcDoctor;`;
  let params = [];
  if (req.body.selectUntersuchung === "allDocs") {
    if (req.body.selectCity === "allCities") {
      sql += `SELECT DISTINCT * FROM evcDoctor;`;
    } else {
      sql += `SELECT DISTINCT * FROM evcDoctor
              WHERE doctorCityPublic = ?;`;
      params.push(req.body.selectCity);
    }
  } else if (req.body.selectCity === "allCities") {
    sql += `
    SELECT  d.*, dc.*, c.checkupName   FROM evcDoctor d
    JOIN evcDoctorCheckup dc ON dc.doctorId = d.doctorId
    JOIN checkup c ON c.checkupId = dc.checkupId
    WHERE dc.checkupId = ?`
    params.push(req.body.selectUntersuchung);
  } else {
    sql += `
    SELECT  d.*, dc.*, c.checkupName   FROM evcDoctor d
    JOIN evcDoctorCheckup dc ON dc.doctorId = d.doctorId
    JOIN checkup c ON c.checkupId = dc.checkupId
    WHERE dc.checkupId = ?
    AND d.doctorCityPublic = ?;`
    params.push(req.body.selectUntersuchung);
    params.push(req.body.selectCity);
  }

  sqlCon.query(sql, params, (sqlErr, sqlRes) => {
    if (sqlErr) {
      console.log("DB_ERR: Error retrieving checkups for doc finder! \n" + sqlErr)
      res.redirect("/home");
    }
    else {
      let checkups = sqlRes[0];
      let cities = sqlRes[1];
      let doctors = sqlRes[2];
      let checkupHeading = null;

      try {
        if (req.body.selectUntersuchung === "allDocs") {
          if (req.body.selectCity === "allCities") {
            checkupHeading = "Alle bei eVC registrierten Ärzte:"
          } else {
          checkupHeading = `Alle bei eVC registrierten Ärzte in ${req.body.selectCity}:`
          }
        } else {
          if (req.body.selectCity === "allCities") {
            checkupHeading = `Ärzte, welche die Vorsorge "${sqlRes[2][0].checkupName}" anbieten:`
          } else {
          checkupHeading = `Ärzte, welche die Vorsorge "${sqlRes[2][0].checkupName}" in ${req.body.selectCity} anbieten:`
          }
          
        }
      }
      catch (e) {
        console.log(e)
        checkupHeading = "Diese Vorsorge bietet leider keiner der bei eVC registrierten Ärzte (in der gewählten Stadt) an."
      }
      res.render("arztfinderData", { layout: "arztfinder", signedIn: req.isAuthenticated(), checkups: checkups, doctors: doctors, checkupHeading: checkupHeading, cities: cities });
    }
  })
})

app.get("/bonus", (req, res) => {
  const signedIn = req.isAuthenticated();
  //error handling for when user has no insurance
  let sql = signedIn ?
    `
  SELECT c.checkupName, c.checkupMinAge, c.checkupMaxAge, c.checkupSex, i.insurerName, i.insurerBonusInfo, b.bonus 
  FROM evcInsurerCheckupBonus b
  JOIN evcInsurer i ON i.insurerId = b.insurerId
  JOIN checkup c ON c.checkupId = b.checkupId
  WHERE i.insurerId = ${req.user.insurerId}
  ORDER BY insurerName, checkupMinAge, checkupName;

  SELECT c.checkupName, uc.evcUserCheckupDate AS 'date', uc.evcUserCheckupNotes AS 'notes', b.bonus
  FROM evcUserCheckup uc
  JOIN evcInsurerCheckupBonus b ON b.checkupId = uc.checkupId
  JOIN checkup c ON c.checkupId = b.checkupId
  WHERE userId = ${req.user.userId} AND b.insurerId = ${req.user.insurerId}
  ORDER BY uc.evcUserCheckupDate DESC, bonus DESC;

  SELECT SUM(b.bonus) AS bonusSum
  FROM evcUserCheckup uc
  JOIN evcInsurerCheckupBonus b ON b.checkupId = uc.checkupId
  WHERE userId = ${req.user.userId} AND b.insurerId = ${req.user.insurerId};
  `
  :
  `
  SELECT c.checkupName, c.checkupMinAge, c.checkupMaxAge, c.checkupSex, i.insurerName, i.insurerBonusInfo, b.bonus 
  FROM evcInsurerCheckupBonus b
  JOIN evcInsurer i ON i.insurerId = b.insurerId
  JOIN checkup c ON c.checkupId = b.checkupId
  WHERE i.insurerId = 1
  ORDER BY insurerName, checkupMinAge, checkupName;

  SELECT c.checkupName, c.checkupMinAge, c.checkupMaxAge, c.checkupSex, i.insurerName, i.insurerBonusInfo, b.bonus 
  FROM evcInsurerCheckupBonus b
  JOIN evcInsurer i ON i.insurerId = b.insurerId
  JOIN checkup c ON c.checkupId = b.checkupId
  WHERE i.insurerId = 2
  ORDER BY insurerName, checkupMinAge, checkupName;

  SELECT c.checkupName, c.checkupMinAge, c.checkupMaxAge, c.checkupSex, i.insurerName, i.insurerBonusInfo, b.bonus 
  FROM evcInsurerCheckupBonus b
  JOIN evcInsurer i ON i.insurerId = b.insurerId
  JOIN checkup c ON c.checkupId = b.checkupId
  WHERE i.insurerId = 3
  ORDER BY insurerName, checkupMinAge, checkupName;
  `;
  sqlCon.query(sql, (sqlErr, sqlRes) => {
    if (sqlErr) {
      console.log("DB_ERR: Error retrieving bonus data! \n" + sqlErr)
      res.redirect("/")
    }
    else {
      if (signedIn) {
        let insurerBonus, pastCheckups, bonusSum;
        try {
          insurerBonus = { "insurerName": sqlRes[0][0].insurerName, "insurerBonusInfo": sqlRes[0][0].insurerBonusInfo, "data": sqlRes[0] };
          pastCheckups = sqlRes[1];
          bonusSum = sqlRes[2][0].bonusSum;
        }
        catch (e) {
          console.log(e)
          insurerBonus, pastCheckups, bonusSum = "ERROR";
        }
        res.render("bonusDataSI", { layout: "bonus", signedIn: signedIn, insurerBonus: insurerBonus, pastCheckups: pastCheckups, bonusSum: bonusSum });
      }
      else {
        try {
          bonusData = [
            { "insurerName": sqlRes[0][0].insurerName, "insurerBonusInfo": sqlRes[0][0].insurerBonusInfo, "data": sqlRes[0] },
            { "insurerName": sqlRes[1][0].insurerName, "insurerBonusInfo": sqlRes[1][0].insurerBonusInfo, "data": sqlRes[1] },
            { "insurerName": sqlRes[2][0].insurerName, "insurerBonusInfo": sqlRes[2][0].insurerBonusInfo, "data": sqlRes[2] }];
        }
        catch (e) {
          console.log(e)
          bonusData = "ERROR";
        }
        res.render("bonusData", { layout: "bonus", signedIn: signedIn, bonusData: bonusData });
      }
    }
  })
})

app.post("/login", passport.authenticate("local", {
  successRedirect: "/home", //TODO
  failureRedirect: "/login",
  failureFlash: true
}));

app.get("/register", checkNotAuth, (req, res) => {
  res.render("empty", { layout: "register", signedIn: req.isAuthenticated() });
})

//TODO: hbs render inputs back on failure
app.post("/register", checkNotAuth, async (req, res) => {
  console.log(req.body)
  //check if passwords match
  if (req.body.password !== req.body.password2) { res.render("empty", { layout: "register", errMsg: "Passwörter stimmen nicht überein!" }) }
  try {
    sqlCon.query("SELECT username FROM evcUser WHERE username = ?; SELECT userEmail FROM evcUser WHERE userEmail = ?", [req.body.username, req.body.email], async (sqlErr, sqlRes) => {
      if (sqlErr) {
        console.log("ERROR: Error checking if username is taken!");
        throw sqlErr;
      }
      else {
        //check if username or email is taken
        console.log("sqlres0 ", sqlRes[0])
        console.log("sqlres1 ", sqlRes[1])
        if (sqlRes[0][0] !== undefined) { res.render("empty", { layout: "register", signedIn: req.isAuthenticated(), errMsg: "Benutzername bereits vergeben!" }); }
        if (sqlRes[1][0] !== undefined) { res.render("empty", { layout: "register", signedIn: req.isAuthenticated(), errMsg: "Email bereits vergeben!" }); }
        else {
          var hashPw = await bcrypt.hash(req.body.password, 10);
          let sql = `INSERT INTO evcUser VALUES (default,?,?,?,?,?,?);`
          let insurer = null;
          if (req.body.insurerSelect !== "null") {
            insurer = req.body.insurerSelect;
          }
          //insert user
          sqlCon.query(sql, [insurer, req.body.username, req.body.email, hashPw, req.body.sex, req.body.birthdate], async (sqlErr, sqlRes) => {
            if (sqlErr) {
              console.log("ERROR: Error inserting User!\n" + sqlErr);
              throw sqlErr;
            }
            else {
              console.log("User inserted")
              res.redirect("/login");
            }
          })
        }
      }
    })
  } catch (err) {
    console.log(err);
    res.redirect("/register");
  }
})

app.post("/kompass", (req, res) => {
  console.log(req.body)
  //let count = (Object.keys(req.body).length)/3
  let count = req.body.counter;
  console.log(count)
  var sql = "";
  var params = [];
  for (let i = 0; i < count; i++) {
    params.push(req.user.userId, req.body["checkupId" + i], req.body["checkupDate" + i], req.body["notes" + i]);
    sql += `INSERT INTO evcUserCheckup VALUES (default, ?, ?, ?, ?);\n`
  }
  sqlCon.query(sql, params, (sqlErr, sqlRes) => {
    if (sqlErr) {
      console.log("DB_ERR: Error inserting user checkups! \n" + sqlErr)
      res.redirect("/kompass")
    }
    else {
      console.log("User checkups successfully inserted!")
      res.redirect("/kompass")
    }
  })
})


app.delete("/logout", (req, res) => {
  req.session.destroy(() => {
    res.clearCookie();
    res.redirect("/home");
  })
})

//sql-Verbindung
var sqlCon = mysql.createConnection({
  host: "localhost",
  //host: "sql_container",
  user: "root",
  password: "mysql!testpw",
  database: "evc_db",
  dateStrings: "date",
  charset: 'utf8mb4',
  multipleStatements: true
});

//Stelle sql-Verbindung her
sqlCon.connect((err) => {
  if (err) {
    console.log("ERROR: Connection to Database failed!\n");
    throw err;
  }
  else {
    console.log("Connection to Database established!\n");
  }
});

sslServer.listen(3003, () => {
  console.log('SSL Server listening on *:3003');
});
