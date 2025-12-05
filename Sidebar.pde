class Sidebar {
  UITools u;
  
  Sidebar() {
    u = new UITools(0, 0, 10);
  }
  
  void drawMenu() {
    fill(22);
    noStroke();
    rect(0, 0, 240, height);
    stroke(color(0, 255, 255));
    strokeWeight(4);
    line(240, 0, 240, height);
    
    u.drawText("1: save to file\n2: load from file\n3: toggle portal shape\n0: zoom to center\na: add portal", 20, 255, 0, 0);
    
    for (int i = 0; i < m.portals.length; i++) {
      Portal p = m.portals[i];
      color textColor = 255;
      if (i == focusedItem && state == AppState.SIDEBAR) textColor = color(255, 0, 0);
      u.drawText(p.label, 20, textColor, 0, 140 + 25*i);
    }
  }
}
