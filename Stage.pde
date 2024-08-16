class Stage {
  int id;
  float factor = 1;
  PVector[] vtr = new PVector[nPts];
  PVector[] ctr = new PVector[nPts];
  Stage(int id, PVector[] pv, PVector[] cv) {
    this.id = id;
    for (int i=0; i<nPts; i++) {
      vtr[i] = new PVector(pv[i].x, pv[i].y, id*high);
      ctr[i] = new PVector(cv[i].x, cv[i].y, id*high);
    }
  }
  void adaptContour(PVector[] cv) {
    for (int i=0; i<ctr.length; i++) ctr[i] = new PVector(cv[i].x, cv[i].y, id*high);
  }
  void display(){
  if(hBase<id) drawIner();
  drawBase();
  drawContour();
  drawTop();
  }
  void drawIner() {
    for (int i=0; i<nPts; i++) {
        PVector vup = stages.get(id-1).getV(i);
        PVector vdn = stages.get(id-1).getV((i+1)%nPts);
        beginShape();
        vertex(getVX(i), getVY(i), getVZ(i));
        vertex(getVX((i+1)%nPts), getVY((i+1)%nPts), getVZ((i+1)%nPts));
        vertex(vdn.x, vdn.y, vdn.z);
        vertex(vup.x, vup.y, vup.z);
        endShape();
    }
  }
  void drawContour() {
    for (int i=0; i<nPts; i++) {
      PVector cdn = stages.get(id-1).getC(i);
      PVector cup = stages.get(id-1).getC((i+1)%nPts);
      beginShape();
      vertex(getCX(i), getCY(i), getCZ(i));
      vertex(getCX((i+1)%nPts), getCY((i+1)%nPts), getCZ((i+1)%nPts));
      vertex(cdn.x, cdn.y, cdn.z);
      endShape(CLOSE);
      beginShape();
      vertex(getCX((i+1)%nPts), getCY((i+1)%nPts), getCZ((i+1)%nPts));
      vertex(cdn.x, cdn.y, cdn.z);
      vertex(cup.x, cup.y, cup.z);
      endShape(CLOSE);
    }
  }
  void drawTop() {
    if (id==stages.size()-1) {
      for (int i=0; i<nPts; i++) {
        beginShape();
        vertex(getVX(i), getVY(i), getVZ(i));
        vertex(getCX(i), getCY(i), getCZ(i));
        vertex(getCX((i+1)%nPts), getCY((i+1)%nPts), getCZ((i+1)%nPts));
        vertex(getVX((i+1)%nPts), getVY((i+1)%nPts), getVZ((i+1)%nPts));
        endShape(CLOSE);
      }
    }
  }
  void drawBase() {
    beginShape();
    for (int i=0; i<nPts; i++) vertex(getCX(i), getCY(i), 0);
    endShape(CLOSE);
  }
  float getVX(int v) {
    return vtr[v].x;
  }
  float getVY(int v) {
    return vtr[v].y;
  }
  float getVZ(int v) {
    return vtr[v].z;
  }
  float getCX(int i) {
    return ctr[i].x;
  }
  float getCY(int i) {
    return ctr[i].y;
  }
  float getCZ(int i) {
    return ctr[i].z;
  }
  PVector getV(int i) {
    return vtr[i];
  }
  PVector getC(int i) {
    return ctr[i];
  }
}
