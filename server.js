
/* ********* SETUP *********************************************************************************************************************************** */
const 
mysql = require('mysql'),
express = require('express'),
{ dirname } = require('path'),
path = require("path"),
app = express(),
expHbs = require('express-handlebars'),
http = require('http'),
bcrypt = require('bcrypt'),
passport = require('passport'),
localStrat = require('passport-local').Strategy,
methodOverride = require('method-override'),
flash = require("express-flash"),
session = require("express-session"),
server = http.createServer(app),
hbs = expHbs.create({
	extname: "hbs",
	layoutsDir: `${__dirname}/views/layouts`,
	partialsDir: __dirname + "/views/partials"
});

function initPassport(passport) {
  const authUser = async (username, password, done) => {
    let sql = `SELECT userId, username, password FROM User WHERE username = ?;` // ? = username
    sqlCon.query(sql, [username], async (errUsername, sqlResUsername) => {
      if (errUsername) {
        console.log("ERROR: Error fulfilling SQL-query!\n" + errUsername);
      } else {
        const user = sqlResUsername[0];
        if (user === undefined) {
          return done(null, false, { message: "No user matching this username" })
        }
        try {
          if (await bcrypt.compare(password, user.password)) {
            return done(null, user)
          } else {
            return done(null, false, { message: "Password incorrect" })
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
    let sql = `SELECT userId, username, password FROM User WHERE userId = '${id}';`;
    sqlCon.query(sql, async (errId, sqlResId) => {
      if (errId) {
        console.log("ERROR: Error fulfilling SQL-query!\n" + errId);
        return null;
      } else {
        return done(null, sqlResId[0])
      }
    })
  })
}

initPassport(passport);

//setting static folder to "/public"
app.use(express.static(path.join(__dirname, "/public")));
app.use(flash());
//secret should be changed once in a while
app.use(session({
  secret: "Jf&4jtg/Fj585sj(T90jg/jgf7&()DJ6fjf&/jf/hgF(9J",
  resave: false,
  saveUninitialized: false
}));
app.use(passport.initialize());
app.use(passport.session());
app.use(methodOverride("_method"));
app.use(express.urlencoded({extended: false}));
app.engine("handlebars", hbs.engine);
app.set("view engine", "handlebars");

/* *******///SETUP//********************************************************************************************************************************** */

function checkAuth(req,res,next){
  if(req.isAuthenticated()){
    return next()
  }
  res.redirect("/home")
}

function checkNotAuth(req,res,next){
  if(req.isAuthenticated()){
    return res.redirect("/")
  }
  next()
}

app.get("/", (req, res) => {
	res.redirect("/home");
})

app.get("/home", (req,res) => {
    res.render("empty", {layout: "home"});
})

app.post("/login", passport.authenticate("local", {
	successRedirect: "/home", //TODOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
	failureRedirect: "/home",
	failureFlash: true
}));

app.get("/register", checkNotAuth, (req, res) => {
	res.render("empty", { layout: "register" });
})

app.post("/register", checkNotAuth, async (req, res) => {
	try {
		var hashPw = await bcrypt.hash(req.body.password, 10);
		let sql = `INSERT INTO User VALUES (default,?,?);`
		sqlCon.query(sql, [req.body.username, hashPw], async (errRegister, sqlResRegister) => {
			if (errRegister) {
				console.log("ERROR: Error fulfilling SQL-query!\n" + errRegister);
				return null;
			} else {
				console.log("User inserted")
				res.redirect("/login");
			}
		})
	} catch {
		res.redirect("/register");
	}
})


app.delete("/logout", (req,res) => {
  req.session.destroy ( () =>{
    res.clearCookie()
    res.redirect("/login");

  })
  
})

//sql-Verbindung
var sqlCon = mysql.createConnection({
host: "localhost",
user: "root",
password: "mysql!testpw",
database: "evc_db",
dateStrings: "date",
charset : 'utf8mb4',
multipleStatements: true
});

//Stelle sql-Verbindung her
sqlCon.connect((err) => {
    if(err){
      throw err;
      console.log("ERROR: Connection to Database failed!\n");
    }
    else{
      console.log("Connection to Database established!\n");
    }
    });

server.listen(3003, () => {
    console.log('listening on *:3003');
});
