class MapManager {
  void loadPortalsDialogue() {
    selectInput("Select map file (.json):", "inputFileSelected");
  }
  
  void loadPortals() {
    if (currentMapfile != null) {
      JSONArray mapJSON = loadJSONArray(currentMapfile);
      Portal[] portalArray = new Portal[0];
      for (int i = 0; i < mapJSON.size(); i++) {
        JSONObject p = mapJSON.getJSONObject(i);
        portalArray = (Portal[]) append(portalArray, new Portal(p.getInt("x"), p.getInt("y"), p.getInt("z"), p.getBoolean("facingNS"), p.getString("label")));
      }
      m.portals = portalArray;
    }
  }
  
  void savePortalsDialogue() {
    selectOutput("Save as (.json):", "outputFileSelected");
  }
  
  void savePortals() {
    if (currentSavefile != null) {
      JSONArray saveJSON = new JSONArray();
      for (int i = 0; i < m.portals.length; i++) {
        Portal p = m.portals[i];
        JSONObject pSave = new JSONObject();
        pSave.setInt("x", p.x);
        pSave.setInt("y", p.y);
        pSave.setInt("z", p.z);
        pSave.setBoolean("facingNS", p.facingNS);
        pSave.setString("label", p.label);
        saveJSON.setJSONObject(i, pSave);
      }
      saveJSONArray(saveJSON, currentSavefile.getAbsolutePath());
    }
  }
}
