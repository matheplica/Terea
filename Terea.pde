//matheplice.github.io - 14/08/2024
import toxi.processing.*;
import toxi.geom.*;
import toxi.geom.mesh.*;
Base base;
PShape model;
float mmx = 0.4, mmy = 0.2;
int selStage, diameter = 160, high = 12, memThick, thick = 12, hBase, nPts;
ToxiclibsSupport gfx;
ArrayList<Stage> stages = new ArrayList<Stage>();
void setup() {
  size(640, 480, P3D);
  gfx = new ToxiclibsSupport(this);
  model = loadShape("input.svg").getChild(1).getChild(0);
  nPts = model.getVertexCount()-1;
  base = new Base(model);
  createStage();
  hint(ENABLE_KEY_REPEAT);
}
void draw() {
  base.deepness();
  if (mousePressed) {
    mmy = mouseY*0.01;
    mmx = mouseX*0.01;
  }
  background(208);
  pushMatrix();
  translate(width>>1, height>>1);
  scale(2, 2);
  rotateZ(mmy);
  rotateY(mmx);
  base.display();
  stroke(79);
  fill(169, 245, 254);
  for (int i=1; i<stages.size(); i++) stages.get(i).display();
  popMatrix();
  fill(46, 10, 99);
  textSize(20);
  text("e/r : change thickness", 16, 28);
  text("d/f : up or down base", 16, 56);
  text("c/v : more/less stage", 16, 84);
  text("s : save as output.stl", 16, 112);
  text("mouse click to move", 16, 140);
}
void keyPressed() {
  if (key=='e') thick = max(1, thick-1);
  else if (key=='r') thick++;
  else if (key=='d') hBase = max(hBase-1, 0);
  else if (key=='f') hBase = min(hBase+1, stages.size()-1);
  else if (key=='c') deleteStage();
  else if (key=='v') createStage();
  else if (key=='s') if (stages.size()>1) saveStl();
}
