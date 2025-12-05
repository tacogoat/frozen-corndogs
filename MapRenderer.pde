class MapRenderer {
  boolean drawFullPortals;
  
  MapRenderer() {
    this.drawFullPortals = true;
  }
  
  void drawMap() {
    if (state == AppState.MAP || state == AppState.SIDEBAR) {
      if (focusedItem < 0) focusedItem = 0;
      if (focusedItem >= m.portals.length) focusedItem = m.portals.length - 1;
    }
    
    PVector mapCenter = this.map2screen(new PVector(0, 0));
    stroke(55);
    strokeWeight(1);
    line(mapCenter.x, mapCenter.y, mapCenter.x, 0);
    line(mapCenter.x, mapCenter.y, mapCenter.x, height);
    line(mapCenter.x, mapCenter.y, 0, mapCenter.y);
    line(mapCenter.x, mapCenter.y, width, mapCenter.y);
    for (int i = 0; i < m.portals.length; i++) {
      Portal p = m.portals[i];
      color portalColor = color(255, 0, 255);
      if (i == focusedItem) portalColor = color(255, 0, 0);
      PVector screenCoords = this.map2screen(new PVector(p.x, p.z));
      int xs = (int) screenCoords.x;
      int zs = (int) screenCoords.y;
      drawPortal(p.x, p.z, xs, zs, p.facingNS, portalColor);
      if (this.drawFullPortals) drawPortalText(p.x, p.y, p.z, xs, zs, p.label);
    }
  }
  
  void drawPortal(int x, int z, int xs, int zs, boolean facingNS, color portalColor) {
    if (this.drawFullPortals) {
      stroke(portalColor);
      strokeWeight(3);
      fill(0);
      if (facingNS) {
        if (x > 0) {
          rect(xs - 17, zs - 6, 44, 11);
        } else {
          rect(xs - 28, zs - 6, 44, 11);
        }
      } else {
        if (z > 0) {
          rect(xs - 6, zs - 17, 11, 44);
        } else {
          rect(xs - 6, zs - 28, 11, 44);
        }
      }
    } else {
      noStroke();
      fill(portalColor);
      if (facingNS) {
        if (x > 0) {
          circle(xs + 6, zs, 6);
        } else {
          circle(xs - 6, zs, 6);
        }
      } else {
        if (z > 0) {
          circle(xs, zs + 6, 6);
        } else {
          circle(xs, zs - 6, 6);
        }
      }
    }
  }
  
  void drawPortalText(int x, int y, int z, int xs, int zs, String label) {
    textSize(14);
    fill(255);
    text(label + "\n" + x + " " + y + " " + z, xs - 24, zs + 48);
  }
  
  PVector map2screen(PVector mapCoords) {
    PVector screenCoords = mapCoords.copy();
    screenCoords.sub(m.position);
    screenCoords.mult(m.scale);
    screenCoords.add(new PVector(width/2, height/2));
    return screenCoords;
  }
}
