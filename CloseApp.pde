class CloseApp {
  String[] options;
  UITools u;
  
  CloseApp() {
    this.options = new String[] {"Yes", "No"};
    this.u = new UITools(width/2 - 120, height/2 - 80, 10);
  }
  
  void drawMenu() {
    fill(22);
    stroke(color(255, 0, 0));
    strokeWeight(4);
    rect(width/2 - 120, height/2 - 80, 240, 160);
    
    if (focusedItem < 0) focusedItem = 0;
    if (focusedItem >= this.options.length) focusedItem = this.options.length - 1;
    
    u.drawText("Quit? (save first)", 30, 255, 0, 0);
    
    color focusedColor = color(255, 0, 0);
    
    for (int i = 0; i < this.options.length; i++) {
      color textColor = 255;
      if (i == focusedItem) textColor = focusedColor;
      u.drawText(this.options[i], 26, textColor, 0, 35 + 30*i);
    }
  }
  
  void handleInput() {
    if (focusedItem == 0) {
      exit();
    } else {
      state = AppState.SIDEBAR;
      focusedItem = 0;
    }
  }
}
