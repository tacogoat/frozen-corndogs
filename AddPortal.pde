class AddPortal {
  int x;
  int y;
  int z;
  boolean facingNS;
  String label;
  String[] fields;
  String userInput;
  UITools u;
  
  AddPortal() {
    this.x = 0;
    this.y = 0;
    this.z = 0;
    this.facingNS = true;
    this.label = "label";
    this.fields = new String[] {"x: " + this.x, "y: " + this.y, "z: " + this.z, "Facing: N/S", "Label: " + this.label, "Save"};
    this.userInput = "";
    this.u = new UITools(width/2 - 160, height/2 - 120, 10);
  }
  
  void drawMenu() {
    fill(22);
    stroke(color(255, 255, 0));
    strokeWeight(4);
    rect(width/2 - 160, height/2 - 120, 320, 240);
    
    if (focusedItem < 0) focusedItem = 0;
    if (focusedItem >= this.fields.length) focusedItem = this.fields.length - 1;
    
    u.drawText("Add Portal:", 30, 255, 0, 0);
    
    color focusedColor = color(255, 0, 0);
    color editingColor = color(0, 255, 0);
    
    for (int i = 0; i < this.fields.length; i++) {
      color textColor = 255;
      if (i == focusedItem) {
        textColor = focusedColor;
        if (editing) textColor = editingColor;
      }
      u.drawText(this.fields[i], 26, textColor, 0, 35 + 30*i);
    }
  }
  
  void editValue() {
    if (focusedItem == 3) {
      editing = false;
        if (this.facingNS) {
          this.facingNS = false;
          this.fields[3] = "Facing: E/W";
        } else {
          this.facingNS = true;
          this.fields[3] = "Facing: N/S";
        }
    } else if (focusedItem == 5) {
      editing = false;
      m.portals = (Portal[]) append(m.portals, new Portal(this.x, this.y, this.z, this.facingNS, this.label));
      state = AppState.SIDEBAR;
      focusedItem = 0;
    } else {
      if ((key == ENTER || key == RETURN) && !userInput.equals("")) {
        switch (focusedItem) {
          case 0:
            try {
              this.x = Integer.parseInt(userInput);
              this.fields[0] = "x: " + this.x;
              focusedItem++;
            } catch (NumberFormatException e) {
              this.fields[0] = "x: ";
            }
            break;
          case 1:
            try {
              this.y = Integer.parseInt(userInput);
              this.fields[1] = "y: " + this.y;
              focusedItem++;
            } catch (NumberFormatException e) {
              this.fields[1] = "y: ";
            }
            break;
          case 2:
            try {
              this.z = Integer.parseInt(userInput);
              this.fields[2] = "z: " + this.z;
              editing = false;
              focusedItem++;
            } catch (NumberFormatException e) {
              this.fields[2] = "z: ";
            }
            break;
          case 4:
            this.label = this.userInput;
            editing = false;
            focusedItem++;
        }
        this.userInput = "";
      } else if (!(key == ENTER || key == RETURN)) {
        if (key == BACKSPACE) {
          if (this.userInput.length() != 0) this.userInput = this.userInput.substring(0, this.userInput.length() - 1);
        } else {
          this.userInput += key;
        }
        switch (focusedItem) {
          case 0:
            this.fields[0] = "x: " + this.userInput;
            break;
          case 1:
            this.fields[1] = "y: " + this.userInput;
            break;
          case 2:
            this.fields[2] = "z: " + this.userInput;
            break;
          case 4:
            this.fields[4] = "Label: " + this.userInput;
        }
      } else {
          switch (focusedItem) {
          case 0:
            this.fields[0] = "x: ";
            break;
          case 1:
            this.fields[1] = "y: ";
            break;
          case 2:
            this.fields[2] = "z: ";
            break;
          case 4:
            this.fields[4] = "Label: ";
        }
      }
    }
  }
}
