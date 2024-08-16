class Base {
  PShape sh;
  PVector[] pv = new PVector[nPts];
  PVector[] cv = new PVector[nPts];
  PVector[] st = new PVector[nPts];
  boolean sens;
  Base(PShape sh) {
    this.sh = sh;
    for (int i=0; i<nPts; i++) {
      pv[i] = new PVector(sh.getVertex(i).x, sh.getVertex(i).y, 0);
      cv[i] = new PVector();
      st[i] = new PVector();
    }
   }
  void display() {
    noFill();
    stroke(222, 16, 220);
    fill(244, 253, 2);
    beginShape();
    for (int i=0; i<nPts+1; i++) vertex(pv[i%nPts].x, pv[i%nPts].y, hBase*high);
    endShape();
  }
  PVector[] getPoints() {
    return pv;
  }
  PVector[] getContour() {
    return cv;
  }
  void deepness() {
    for (int i=0; i<nPts; i++) {
      PVector middle = PVector.add(pv[i], pv[(i+1)%nPts]).div(2);
      cv[i] = middle.sub(pv[i]).normalize().mult(thick).rotate(TAU-HALF_PI).add(pv[i]);
    }
    for (int i=0; i<stages.size(); i++) stages.get(i).adaptContour(cv);
  }
  Polygon2D getBaseOut() {
    Polygon2D out = new Polygon2D();
    for (int i=0; i<cv.length; i++) out.add(cv[i].x, cv[i].y);
    return out;
  }
  Polygon2D getBaseIn() {
    Polygon2D out = new Polygon2D();
    for (int i=0; i<pv.length; i++) out.add(pv[i].x, pv[i].y);
    return out;
  }
}
