import 'dart:html';
import 'dart:convert' show json;

TextAreaElement? theEditor;

void main() {
  theEditor = querySelector("#editor") as TextAreaElement?;
  theEditor!
    ..onKeyUp.listen(handleKeyPress)
    ..text = loadDocument();

  DivElement aptitle = (querySelector("#toolbar")?.text = "TextEditor") as DivElement;

  ButtonInputElement btnClear = querySelector("#btnClearText") as ButtonInputElement;
  btnClear.onClick.listen(clearEditor);
}

void clearEditor(MouseEvent event) {
  theEditor!.text = "";
  saveDocument();
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