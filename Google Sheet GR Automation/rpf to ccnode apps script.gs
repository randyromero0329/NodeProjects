/* Assign the values of the header in the mail */
const v1Headers = ["GR001", "GR002", "GR003", "GR018", "GR033", "GR043", "GR052", "GR152", "FR30", "RM033", "RM041", "FR017", "GR013", "GR049", "GR092", "GR124", "GR069", "FR013", "GR036", "GR055", "FR032"];

const v3Headers = v1Headers;
const dGateHeaders = ["GR001", "GR003", "GR027", "GR40", "GR056", "RM005", "GR019"];
const v1FirstCol = 'B';
const v1LastCol = 'V';
const v3FirstCol = 'Y';
const v3LastCol = 'AS';
const dGateFirstCol = 'AV';
const dGateLastCol = 'BB';


/* Creation of Menu Bar */
function onOpen(e) {
  var ui = SpreadsheetApp.getUi();
  ui.createMenu('Email Manager')
    .addSubMenu(ui.createMenu('Gmail')
      .addItem('Get Email Data', 'getGmailEmails')
      .addItem('Update Label Name', 'updateGmailLabelName'))
    .addSubMenu(ui.createMenu('Sheet')
      .addItem('Update Sheet Name', 'updateSheetName'))
    .addSubMenu(ui.createMenu('Auto Run Triggers')
      .addItem('Create Minutes Trigger', 'createTimeTrigger')
      .addItem('Disable All', 'deleteAllTriggers'))
    .addToUi();
}

/* pop-up for Gmail Label Name */
function updateGmailLabelName() {
  let propName = 'Gmail Label Name';
  promptPropUpdate(propName);
}

/* pop-up for update sheet name */
function updateSheetName() {
  let propName = 'Data Sheet';
  promptPropUpdate(propName);
}

/* pop-up and input some data */
function promptPropUpdate(propName) {
  var ui = SpreadsheetApp.getUi();
  var input = ui.prompt(propName + ' Update', 'Please key in the desired ' + propName, Browser.Buttons.OK_CANCEL);

  if (input.getSelectedButton() == ui.Button.CANCEL) {
    return;
  }
  let inputText = input.getResponseText();
  PropertiesService.getDocumentProperties().setProperty(propName, inputText);
  if (inputText.trim() != '') {
    Browser.msgBox('The ' + propName + ' has been updated to: ' + inputText);
  } else {
    ui.alert('Please key in a valid ' + propName);
  }
}

/* Checking the mails in GMAIL to be extracted or transfer */
function getGmailEmails() {
  var labelName = PropertiesService.getDocumentProperties().getProperty('Gmail Label Name');
  var label;
  var threads;

  if (labelName != null || labelName != "") {
    try {
      label = GmailApp.getUserLabelByName(labelName);
      threads = label.getThreads();
    } catch (e) {
      Browser.msgBox("Your Gmail account does not have a label with name: " + labelName);
      return;
    }
  } else {
    Browser.msgBox("You need to enter your email label name from the program menu.");
    return;
  }
  if (!threads || threads.length == 0) {
    Browser.msgBox("No single email is assigned the keyed in label with name: " + labelName);
    return;
  }
  for (var i = threads.length - 1; i >= 0; i--) {
    var messages = threads[i].getMessages();
    for (var j = 0; j < messages.length; j++) {
      var message = messages[j];
      if (message.isUnread()) {
        extractDetails(message);
        GmailApp.markMessageRead(message);
      }
    }
    threads[i].removeLabel(label);

  }

}

function testFunc() {

  let todayDateTime = new Date();

}
/* Getting the data from MAIL to GR SHEET */
function extractDetails(message) {

  let ss = SpreadsheetApp.getActiveSpreadsheet();
  let sheet = ss.getSheetByName(PropertiesService.getDocumentProperties().getProperty('Data Sheet'));

/* Assigning values to have it in days and hour */
  let timeZone = SpreadsheetApp.getActive().getSpreadsheetTimeZone();
  let emailDate = message.getDate();
  const day = Number(Utilities.formatDate(emailDate, timeZone, 'dd'));  // //'MMMM dd, yyyy HH:mm:ss Z'
  const hour = Number(Utilities.formatDate(emailDate, timeZone, 'HH'));

  let regExpParams;
  var body = message.getPlainBody();
  console.log(body);
  let headersList = [];
  let valuesList = [];
  let headersBody, valuesBody, sheetHeaders, firstCol, lastCol;
  let subject = message.getSubject();
  /* V1 GR Report */
  if (subject.includes('V1 GR')) {
    sheetHeaders = v1Headers;
    firstCol = v1FirstCol;
    lastCol = v1LastCol;
    regExpParams = ['.*?(?=--)', 's'];
    headersBody = getRegExpResult(body, regExpParams).replace(/\-/g, '').replace(/\s\s+/g, ' ').trim();
    headersList = headersBody.split(' ');

    regExpParams = ['(?<=-).*(?=\\()', 's'];
    valuesBody = getRegExpResult(body, regExpParams).replace(/\-/g, '').replace(/\s\s+/g, ' ').trim();
    valuesList = valuesBody.split(' ');
  } else {
    /* V3 GR Report */
    let delimeter = '';
    if (subject.includes('V3 GR')) {
      sheetHeaders = v3Headers;
      firstCol = v3FirstCol;
      lastCol = v3LastCol;
      delimeter = '|';
    } 
    /* DGATE GR Report */
    else if (subject.includes('DGATE GR')) {
      sheetHeaders = dGateHeaders;
      firstCol = dGateFirstCol;
      lastCol = dGateLastCol;
      delimeter = ' ';
    }

    /* Pairing the V3 format to make it readable from MAIL to GR */
    regExpParams = ['(?<=--).*(?=\\()', 's'];
    let v3Body = getRegExpResult(body, regExpParams).trim();
    let v3Pairs = v3Body.split('\n');
    for (let i = 1; i < v3Pairs.length; i++) {
      let headerAndVal = v3Pairs[i].replace(/\s\s+/g, ' ');
      headersList.push(headerAndVal.split(delimeter)[0].trim());
      valuesList.push(headerAndVal.split(delimeter)[1].trim());
    }
  }

    /* getting the header to the exact location in the GR  */
  let finalList = [];
  for (let i = 0; i < sheetHeaders.length; i++) {
    const valIdx = headersList.indexOf(sheetHeaders[i]);
    if (valIdx >= 0) {
      finalList.push(valuesList[valIdx]);
    } else {
      finalList.push("0");
    }
  }
  /* Getting the data base on the ROW that will be updated */
  let dataTable = [];
  dataTable.push(finalList);
  let rowToUpdate = (day - 1) * 28 + 3 + hour;
  try {
    sheet.getRange(firstCol + rowToUpdate + ':' + lastCol + rowToUpdate).setValues(dataTable);

  } catch (e) {
    Logger.log("Error message: " + e.message);
  }

}

function getRegExpResult(sourceText, params) {
  var result = "";
  try {
    var regExp = new RegExp(params[0], params[1]);
    result = sourceText.match(regExp).toString().trim();
  } catch (e) {

  }
  return result;
}

/* Creation of time trigger */
function createTimeTrigger() {
  var ui = SpreadsheetApp.getUi();
  intervalText = 'Every how many minutes do you need your data extracted? [From 1, 5, 10, 15 or 30 minutes]';
  var input = ui.prompt('Trigger Interval', intervalText, Browser.Buttons.OK_CANCEL);

  if (input.getSelectedButton() != ui.Button.OK) {
    return;
  }
  let response = input.getResponseText();
  
  if (isNaN(response) || Number(response) < 1 || Number(response) > 30) {
    Browser.msgBox('Key in a number between  1, 5, 10, 15 or 30 minutes');
    return;
  };

  deleteAllTriggers();
  ScriptApp.newTrigger("getGmailEmails")
    .timeBased()
    .everyMinutes(response)
    .create();

}


/* deletion of the trigger */
function deleteAllTriggers() {
  var triggers = ScriptApp.getProjectTriggers();
  for (var i = 0; i < triggers.length; i++) {
    ScriptApp.deleteTrigger(triggers[i]);
  }
}