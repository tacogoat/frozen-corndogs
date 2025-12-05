class Portal {
  int x;
  int y;
  int z;
  boolean facingNS; // true = N/S facing, false = E/W facing
  String label;
  
  Portal(int x_, int y_, int z_, boolean facingNS_, String label_) {
    this.x = x_;
    this.y = y_;
    this.z = z_;
    this.facingNS = facingNS_;
    this.label = label_;
  }
}
