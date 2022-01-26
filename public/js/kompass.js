
document.getElementById("checkupSelect").addEventListener("change", () => {
  let counterInput = document.getElementById("hiddenCounterInput");
  let select = document.getElementById("checkupSelect");
  let table = document.getElementById("insertFormTable");
  let tr = document.createElement("tr");
  tr.classList.add("insertFormTableTr")

  let checkupNameTd = document.createElement("td");
  checkupNameTd.innerHTML = select.options[select.selectedIndex].text;

  let checkupNameHiddenInput = document.createElement("input");
  checkupNameHiddenInput.type = "hidden";
  checkupNameHiddenInput.classList.add("checkupId");
  //checkupNameHiddenInput.name = "checkupId" + counterInput.value;
  checkupNameHiddenInput.value = select.options[select.selectedIndex].value;

  let checkupNameHiddenTd = document.createElement("td");
  checkupNameHiddenTd.appendChild(checkupNameHiddenInput);

  let checkupDateTd = document.createElement("td");
  let checkupDateInput = document.createElement("input")
  checkupDateInput.type = "date";
  checkupDateInput.classList.add("checkupDate");
  //checkupDateInput.name = "checkupDate" + counterInput.value;
  checkupDateTd.appendChild(checkupDateInput);

  let notesTd = document.createElement("td");
  let notesInput = document.createElement("input");
  notesInput.classList.add("checkupNotes");
  //notesInput.name = "notes" + counterInput.value;
  notesTd.appendChild(notesInput);

  let removeInput = document.createElement("input");
  removeInput.type = "button";
  removeInput.value = "❌";
  removeInput.onclick = function () {
    this.closest(".insertFormTableTr").remove(this);
    counterInput.value--;
    visibilitySubmitButton(table);
    adjustNameCounter(table);
  };

  tr.appendChild(checkupNameTd);
  tr.appendChild(checkupDateTd);
  tr.appendChild(notesTd);
  tr.appendChild(checkupNameHiddenTd);
  tr.appendChild(removeInput);
  table.appendChild(tr);

  counterInput.value++;

  visibilitySubmitButton(table);
  adjustNameCounter(table);
  console.log(counterInput.value)

  //addeventlistener to tr buttons
})

function visibilitySubmitButton(table) {
  if (table.childElementCount >= 2) {
    document.getElementById("insertFormSubmitButton").style.display = "block";
    table.style.display = "block";
  }
  else {
    document.getElementById("insertFormSubmitButton").style.display = "none";
    table.style.display = "none";
  }
}

function adjustNameCounter(table) {
  checkupIds = document.getElementsByClassName("checkupId");
  checkupDates = document.getElementsByClassName("checkupDate");
  checkupNotes = document.getElementsByClassName("checkupNotes");
  for (let i = 1; i < table.childElementCount; i++) {
    checkupIds[i - 1].name = "checkupId" + (i - 1);
    checkupDates[i - 1].name = "checkupDate" + (i - 1);
    checkupNotes[i - 1].name = "notes" + (i - 1);
  }
}