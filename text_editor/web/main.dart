import 'dart:html';
import 'dart:js';
import 'dart:convert' show json;

TextAreaElement? theEditor;

void main() {
  // modification du titre de notreediteur
  Element? apptitle = querySelector("#toolbar");
  apptitle!.text = "TextEditor";

  // ajout d'un boutton permettant de vider notre editteur
  ButtonInputElement btnClear = querySelector("#btnClearText") as ButtonInputElement;
  btnClear.onClick.listen(clearEditor);

  theEditor = querySelector("#editor") as TextAreaElement?;
  theEditor!
    ..onKeyUp.listen(handleKeyPress)
    ..text = loadDocument();

}

void clearEditor(MouseEvent event) {
  var result = context.callMethod('confirm',
      ['Are you sure you want to clear the text?']);
  if (result == true) {
    theEditor!.text = "";
    saveDocument();
  }
}

void handleKeyPress(KeyboardEvent event) {
  saveDocument();
}



String loadDocument() {
  String readings = "";
  String? jsonString = window.localStorage["MyTextEditor"];
  if (jsonString != null && jsonString.isNotEmpty) {
    readings = json.decode(jsonString);
  }
  return readings;
}

void saveDocument() {
  window.localStorage["MyTextEditor"] = json.encode(theEditor!.value);
}