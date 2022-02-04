import 'dart:html';
import 'dart:convert' show json;

TextAreaElement? theEditor;

void main() {
  final theEditor = querySelector("#editor");
  theEditor!
    ..onKeyUp.listen(handleKeyPress)
    ..text = loadDocument();
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
  window.localStorage["MyTextEditor"] = json.encode(theEditor!  .value);
}
