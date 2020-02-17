import java.awt.Point;
int rotationX;
int rotationY;
int state;
ArrayList<Point> points= new ArrayList<Point>();
ArrayList<PVector> points3D = new ArrayList<PVector>();
PShape obj;
int angleJump;
int minY;
int maxY;


void setup() {
  size(1500, 1000, P3D);
  state = 0;
  angleJump = 5;
}


void getMinAndMax() {
  int actMin = height;
  int actMax = 0;
  for (Point point : points) {
    if (point.y < actMin) {
      actMin = point.y;
    }
    if (point.y > actMax) {
      actMax = point.y;
    }
  }
  minY = actMin;
  maxY = actMax;
}
void draw() {
  background(0);
  if (state == 0) draw2D();
  else if (state == 1) draw3D();
}

void emptyCanvas() {
  background(0);
  fill(200);
  rect((width/2) - 2, 0, 3, height);
}

void draw2D() {
  emptyCanvas();
  drawPoints();
  drawLines();
  drawTutorial();
}

void draw3D() {
  obj.setFill(color(0, 255, 216));
  obj.setStroke(color(255, 88, 0));
  if (rotationX != 0) obj.rotateX((float) rotationX*radians(2));
  if (rotationY != 0) obj.rotateY((float) rotationY*radians(2));
  translate(mouseX, mouseY);
  shape(obj);
}

PVector rotatePoint(PVector point) {
  double cos = Math.cos(Math.toRadians(angleJump));
  double sin = Math.sin(Math.toRadians(angleJump));
  double x = point.x * cos  - point.z* sin;
  double z = point.x * sin + point.z * cos;
  return new PVector((float)x, point.y, (float)z);
}



void drawPoints() {
  fill(200, 0, 0);
  for (Point point : points) {
    ellipse((float)point.getX()+width/2, (float)point.getY(), 4, 4);
  }
}

void drawLines() {
  stroke(100);
  if (points.size() <= 1) return;
  for (int i = 0; i <= points.size() - 2; i++) {
    line((float)points.get(i).getX()+width/2, (float)points.get(i).getY(), 
      (float)points.get(i+1).getX()+width/2, (float)points.get(i+1).getY());
  }
}

void drawTutorial() {
  textAlign(CENTER);
  textSize(70);
  fill(255, 88, 0);
  text("Generador 3D", width/4, 150);
  textSize(50);
  text("Visión 2D", width/4, 250);
  textSize(26);
  text("Haz click izquierdo en la parte derecha de la pantalla", width/4, 300);
  text("para generar los vertices de la figura", width/4, 328);
  text("Haz click derecho para borrar el último punto dibujado", width/4, 370);
  textSize(30);
  text("Pulsa enter para generar la figura 3D", width/4, 420);

  textSize(50);
  text("Visión 3D", width/4, 500);
  textSize(26);
  text("Usa las flechas de control y el ratón para ", width/4, 550);
  text("trasladar y rotar la figura respectivamente", width/4, 578);

  text("Pulsa D para volver a la vista 3D inicial", width/4, 620);
  text("o A para volver a la visión 2D", width/4, 648);
  textSize(30);
  text("Pulsa R en cualquier momento para", width/4, height - 200);
  text("reiniciar el dibujo", width/4, height - 160);
}








void generate3DVer() {
  startingShape();
  obj = createShape();
  generate3D();
}

void generate3D() {
  for  (int actAng = 0; actAng <= 360; actAng = actAng+angleJump) {
    obj.beginShape(TRIANGLE_STRIP);
    ArrayList<PVector> nextShape = startNextShape();
    addVerts(nextShape, actAng);
    points3D = nextShape;
    obj.endShape();
  }
}

void startingShape() {
  points3D.clear();
  for (Point point : points) {
    points3D.add(new PVector((int)point.getX(), (int)point.getY() - maxY +((maxY - minY)/2), 0));
    System.out.println((int)point.getY() );
  }
}

ArrayList<PVector>  startNextShape() {
  ArrayList<PVector> nextShape = new ArrayList<PVector>();
  for (int i = 0; i < points.size(); i++) {
    nextShape.add(rotatePoint(points3D.get(i)));
  }
  return nextShape;
}


/**
Si bien es verdad que el método al tener que volver hacia atrás, las demás combinaciones
usadas provocaban ligeros fallos en la creación de la figura 3D (como zonas que no debían 
estar representadas) y se disponía de poco tiempo, por lo que se ha optado por una mejor 
visión 3D antes que un menor tiempo de creación.
**/
public void addVerts(ArrayList<PVector> nextShape, int actAng) {
  //if(actAng % (angleJump*2)  == 0){
  //obj.vertex(points3D.get(0).x, points3D.get(0).y, points3D.get(0).z);
  for (int i = 0; i < nextShape.size() - 1; i++) {
    obj.vertex(points3D.get(i).x, points3D.get(i).y, points3D.get(i).z);
    obj.vertex(nextShape.get(i + 1).x, nextShape.get(i + 1).y, nextShape.get(i + 1).z);
  }
  //obj.vertex(points3D.get(points.size() - 1).x, points3D.get(points.size() - 1).y, points3D.get(points.size() - 1).z);

  //}else{

  obj.vertex(points3D.get(points.size() - 1).x, points3D.get(points.size() - 1).y, points3D.get(points.size() - 1).z);
  for (int i = points.size() - 1; i > 0; i--) {
    obj.vertex(nextShape.get(i).x, nextShape.get(i).y, nextShape.get(i).z);
    obj.vertex(points3D.get(i -1).x, points3D.get(i - 1).y, points3D.get(i - 1).z);
  }

  obj.vertex(nextShape.get(0).x, nextShape.get(0).y, nextShape.get(0).z);
  //}
}



void restart() {
  minY = height;
  maxY = 0; 
  points.clear();
}




void mouseClicked() {
  if (state == 0) {
    if (mouseButton == LEFT && mouseX >= width/2) {
      points.add(new Point(mouseX-width/2, mouseY));
      getMinAndMax();
    } else if (mouseButton == RIGHT && !points.isEmpty()) { 
      points.remove(points.size()-1);
      getMinAndMax();
    }
  }
}

void keyPressed() {
  if (keyCode == ENTER && points.size() >= 1) {
    generate3DVer();
    state = 1;
  }
  if (key == 'R' || key == 'r') {
    state = 0;
    restart();
  }
  if (key == 'A' || key == 'a') {
    state = 0;
  }
  if (key == 'D' || key == 'd') {
    generate3DVer();
  }
  translate(0, 0);
  if (keyCode == UP && state == 1) rotationX = 1;
  else if (keyCode == DOWN && state == 1) rotationX = -1;

  if (keyCode == LEFT && state == 1)rotationY = -1;
  else if (keyCode == RIGHT && state == 1)rotationY = 1;
}

void keyReleased() {
  if (keyCode == UP && state == 1) rotationX = 0;
  else if (keyCode == DOWN && state == 1) rotationX = 0;

  if (keyCode == LEFT && state == 1)rotationY = 0;
  if (keyCode == RIGHT && state == 1)rotationY = 0;
}
