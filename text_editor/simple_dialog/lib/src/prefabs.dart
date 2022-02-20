part of simple_dialog;

/// Equivalent of JS confirm - Ok Cancel buttons.
void confirm(
    String dlgTitle, String prompt, int width, int height, Function action) {
  Dialog dlg = Dialog(dlgTitle, prompt, width, height);
  dlg.show(action);
}

/// Equivalent of JS alert - Ok button.
void alert(String dlgTitle, String prompt, int width, int height) {
  Dialog dlg = Dialog(dlgTitle, prompt, width, height, true, false);
  dlg.show();
}

/// About box - text content with hyperlink.
class AboutDialog extends Dialog {
  String linkUrl;
  String linkText;

  AboutDialog(String titleText, String bodyText, this.linkUrl, this.linkText,
      int width, int height)
      : super(titleText, bodyText, width, height, true, false) {

    // Customise the content for an about box.
    var link = AnchorElement();
    link.href = linkUrl;
    link.text = linkText;
    contentDiv
      ..nodes.insert(0, BRElement())
      ..nodes.insert(0, BRElement())
      ..append(BRElement())
      ..append(BRElement())
      ..append(link)
      ..style.textAlign = "center";
  }


}