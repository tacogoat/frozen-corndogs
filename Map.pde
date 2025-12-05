class Map {
  float scale;
  PVector position; // position is the coord displayed at the center of the screen (x, z)
  Portal[] portals;
  
  Map() {
    this.scale = 1.0;
    this.position = new PVector(0, 0);
    this.portals = new Portal[0];
  }
  
  void move(PVector diff) {
    this.position.sub(diff.div(this.scale));
  }
  
  void changeScale(float diff) {
    this.scale += diff;
    if (this.scale < 0) this.scale = 0;
  }
  
  void center() {
    this.scale = 1.0;
    this.position = new PVector(0, 0);
  }
}
