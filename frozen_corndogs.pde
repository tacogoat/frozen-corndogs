float scrollSens;

Map m;
MapRenderer mRender;
MapManager mManage;

Sidebar sMenu;
AddPortal aMenu;
CloseApp cMenu;
RemovePortal rMenu;

File currentMapfile;
File currentSavefile;

AppState state;

int focusedItem;
boolean editing;

void setup() {
  fullScreen();
  
  scrollSens = 0.1;
  
  m = new Map();
  mRender = new MapRenderer();
  mManage = new MapManager();
  
  sMenu = new Sidebar();
  cMenu = new CloseApp();
  
  state = AppState.MAP;
  
  focusedItem = 0;
  editing = false;
}

void draw() {
  background(0);
  
  switch (state) {
    case MAP:
      mRender.drawMap();
      break;
    case SIDEBAR:
      mRender.drawMap();
      sMenu.drawMenu();
      break;
    case ADD_PORTAL:
      mRender.drawMap();
      sMenu.drawMenu();
      aMenu.drawMenu();
      break;
    case REMOVE_PORTAL:
      mRender.drawMap();
      sMenu.drawMenu();
      rMenu.drawMenu();
      break;
    case CLOSE_APP:
      mRender.drawMap();
      sMenu.drawMenu();
      cMenu.drawMenu();
  }
}

void mouseWheel(MouseEvent event) {
  float scrollCount = event.getCount();
  
  switch (state) {
      case MAP:
        m.changeScale(scrollCount * scrollSens);
        break;
      case SIDEBAR:
        break;
      case ADD_PORTAL:
      case REMOVE_PORTAL:
      case CLOSE_APP:
  }
}

void mouseDragged() {
  PVector mouseMoved = new PVector(mouseX - pmouseX, mouseY - pmouseY);
  
  switch (state) {
    case MAP:
      m.move(mouseMoved);
      break;
    case SIDEBAR:
      break;
    case ADD_PORTAL:
    case REMOVE_PORTAL:
    case CLOSE_APP:
  }
}

void keyPressed() {
  if (!editing) {
    if (keyCode == DOWN || key == 'j') focusedItem++;
    if (keyCode == UP || key == 'k') focusedItem--;
  }
  
  switch (state) {
    case MAP:
      if (key == '0') m.center();
      if (key == '3') {
        if (mRender.drawFullPortals) {
          mRender.drawFullPortals = false;
        } else {
          mRender.drawFullPortals = true;
        }
      }
      if (key == TAB) {
        state = AppState.SIDEBAR;
      }
      if (keyCodeIsEsc()) {
        state = AppState.CLOSE_APP;
        focusedItem = 0;
      }
      break;
    case SIDEBAR:
      if (key == TAB) state = AppState.MAP;
      if (key == '0') m.center();
      if (key == '1') mManage.savePortalsDialogue();
      if (key == '2') mManage.loadPortalsDialogue();
      if (key == 'a') {
        editing = true;
        aMenu = new AddPortal();
        state = AppState.ADD_PORTAL;
        focusedItem = 0;
      }
      if (keyCodeIsEsc()) {
        state = AppState.CLOSE_APP;
        focusedItem = 0;
      }
      if ((key == ENTER || key == RETURN) && m.portals.length > 0) {
        rMenu = new RemovePortal(focusedItem);
        state = AppState.REMOVE_PORTAL;
        focusedItem = 0;
      }
      if (key == '3') {
        if (mRender.drawFullPortals) {
          mRender.drawFullPortals = false;
        } else {
          mRender.drawFullPortals = true;
        }
      }
      break;
    case ADD_PORTAL:
      if (key == ENTER || key == RETURN) {
        editing = true;
      }
      if (editing && key != CODED) aMenu.editValue();
      if ((key == BACKSPACE && !editing) || keyCodeIsEsc()) {
        editing = false;
        state = AppState.SIDEBAR;
        focusedItem = 0;
      }
      break;
    case REMOVE_PORTAL:
      if (key == BACKSPACE || keyCodeIsEsc()) {
        state = AppState.SIDEBAR;
        focusedItem = 0;
      }
      if (key == ENTER || key == RETURN) rMenu.handleInput();
      break;
    case CLOSE_APP:
      if (key == BACKSPACE || keyCodeIsEsc()) {
        state = AppState.SIDEBAR;
        focusedItem = 0;
      }
      if (key == ENTER || key == RETURN) cMenu.handleInput();
  }
}

void inputFileSelected(File selection) {
  if (selection == null) {
    println("No file was selected");
  } else {
    currentMapfile = selection;
    mManage.loadPortals();
  }
}

boolean keyCodeIsEsc() {
  if (keyCode == ESC) {
    key = 0;
    return true;
  } else {
    return false;
  }
}

void outputFileSelected(File selection) {
  if (selection == null) {
    println("No file was selectied");
  } else {
    currentSavefile = selection;
    mManage.savePortals();
  }
}

Portal[] remove(Portal[] arr, int i) {
  return (Portal[]) concat(subset(arr, 0, i), subset(arr, i + 1, arr.length - 1));
}
