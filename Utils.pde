void createStage() {
  stages.add(new Stage(stages.size(), base.getPoints(), base.getContour()));
}
void deleteStage() {
  selStage = 0;
  if (stages.size()>1) {
    stages.remove(stages.size()-1);
    hBase = max(hBase-1, 0);
  }
}
