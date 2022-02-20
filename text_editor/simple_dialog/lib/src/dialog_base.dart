part of simple_dialog;

/// Simple general purpose div based Dialog box.
class Dialog {
  String titleText = "";
  String bodyText = "";
  String result = "";

  int width = 0;
  int height = 0;

  bool okButton = false;
  bool cancelButton = false;

  bool _visible = false;
  bool get visible => _visible;

  Function? resultHandler;

  DivElement dialogBox = DivElement();
  DivElement contentDiv = DivElement();

  ButtonElement? okButtonUi;

  // Ctor with two option trailing parameters.
  Dialog(this.titleText, this.bodyText, this.width, this.height,
      [this.okButton = true, this.cancelButton = true]) {
    HtmlElement title;
    if (titleText.isNotEmpty) {
      title = DivElement();
      title
        ..text = titleText
        ..classes.toggle("dialogboxtitle")
        ..style.width = "${width}px";
    } else {
      title = SpanElement();
    }

    contentDiv
      ..text = bodyText
      ..style.padding = "5px"
      ..style.width = "${width}px";

    var buttons = DivElement();
    buttons..append(BRElement())..append(BRElement());
    buttons
      ..style.textAlign = "center"
      ..style.width = "${width}px";

    if (okButton) {
      okButtonUi = makeButton("OK", setOKStatus);
      buttons.append(okButtonUi!);
    }

    if (cancelButton) {
      var gap = SpanElement();
      gap.appendHtml("&nbsp;&nbsp;&nbsp;");
      buttons.append(gap);
      buttons.append(makeButton("CANCEL", hide));
    }

    dialogBox
      ..style.width = "${width}px"
      ..style.height = "${height}px"
      ..classes.toggle("dialogbox")
      ..append(title)
      ..append(contentDiv)
      ..append(buttons);

    // Add the dialog to the DOM.
    document.body?.append(dialogBox);
  }

  // Put the dialog on screen.
  String show([Function? handler]) {
    resultHandler = handler;
    _visible = true;
    dialogBox.style.visibility = "visible";
    return result;
  }

  // Remove the dialog from the screen.
  void hide(MouseEvent? me) {
    dialogBox.style.visibility = "hidden";
  }

  // Create a button with the supplied text and connect to handler.
  ButtonElement makeButton(String text, [clickhandler]) {
    var b = ButtonElement();
    b
      ..text = text
      ..style.width = "100px"
      ..style.padding = "5px";
    if (clickhandler != null){
      b.onClick.listen(clickhandler);

    }
    return b;
  }

  // Return ok status and call result handler if set.
  void setOKStatus(MouseEvent? me) {
    result = "ok";
    hide(null);
    if (resultHandler != null) resultHandler!(result);
  }
}