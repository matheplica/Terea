Polygon2D polyIn = new Polygon2D();
void saveStl() {
  TriangleMesh mainMesh = new TriangleMesh();
  TriangleMesh mesh = new TriangleMesh();
  int up = stages.size()-1;
  for (int i=0; i<nPts; i++) {
    Vec3D a = new Vec3D(stages.get(hBase).getVX(i), stages.get(hBase).getVY(i), stages.get(hBase).getVZ(i));
    Vec3D b = new Vec3D(stages.get(up).getVX(i), stages.get(up).getVY(i), stages.get(up).getVZ(i));
    Vec3D c = new Vec3D(stages.get(up).getVX((i+1)%nPts), stages.get(up).getVY((i+1)%nPts), stages.get(up).getVZ((i+1)%nPts));
    Vec3D d = new Vec3D(stages.get(hBase).getVX((i+1)%nPts), stages.get(hBase).getVY((i+1)%nPts), stages.get(hBase).getVZ((i+1)%nPts));
    Vec3D e = new Vec3D(stages.get(up).getCX(i), stages.get(up).getCY(i), stages.get(up).getCZ(i));
    Vec3D f = new Vec3D(stages.get(up).getCX((i+1)%nPts), stages.get(up).getCY((i+1)%nPts), stages.get(up).getCZ((i+1)%nPts));
    Vec3D g = new Vec3D(stages.get(0).getCX(i), stages.get(0).getCY(i), stages.get(0).getCZ(i));
    Vec3D h = new Vec3D(stages.get(0).getCX((i+1)%nPts), stages.get(0).getCY((i+1)%nPts), stages.get(0).getCZ((i+1)%nPts));
    mesh.addFace(a, b, c); //montant intérieur
    mesh.addFace(a, c, d);
    mesh.flipVertexOrder();
    mainMesh.addMesh(mesh);
    mesh.clear();
    mesh.addFace(b, c, f);//bord supérieur
    mesh.addFace(e, b, f);
    mesh.faceOutwards();
    mainMesh.addMesh(mesh);
    mesh.clear();
    mesh.addFace(e, f, g);//montant extérieur
    mesh.addFace(g, f, h);
    mainMesh.addMesh(mesh);
    mesh.clear();
  }
  Polygon2D polyIn = base.getBaseIn();
  polyIn.toMesh(mesh);
  mesh.translate(0, 0, hBase*high);
  mainMesh.addMesh(mesh);
  mesh.clear();
  Polygon2D polyOut = base.getBaseOut();
  polyOut.toMesh(mesh);
  mesh.flipVertexOrder();
  mainMesh.addMesh(mesh);
  mainMesh.scale(0.5);
  mainMesh.saveAsSTL(sketchPath("output.stl"));
}
