class UITools {
  int anchorX;
  int anchorY;
  int padding;
  int scrollPos;
  
  UITools(int anchorX_, int anchorY_, int padding_) {
    this.anchorX = anchorX_;
    this.anchorY = anchorY_;
    this.padding = padding_;
    this.scrollPos = 0;
  }
  
  void drawText(String text, int size, color textColor, int x, int y) {
    textSize(size);
    fill(textColor);
    text(text, anchorX + padding + x, anchorY + padding + y + size);
  }
}
