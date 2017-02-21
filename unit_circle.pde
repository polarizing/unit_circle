Circle c;

void setup() {
 size(800, 600);
 c = new Circle(300);
}

void draw() {
  background(0);
  c.display();
}

class Circle {
  PVector center;
  int diameter;
  int radius;
  
  Circle(int diam) {
    center = new PVector(width / 2, height / 2);
    diameter = diam;
    radius = diameter / 2;
  }
  
   void display() {
     drawCircle();
     drawXYAxis();
     drawArc();
     drawRightTriangle();
   }
   
   void drawCircle() {
     noFill();
     stroke(255);
     pushMatrix();
     ellipse(center.x, center.y, diameter, diameter);
     popMatrix();
   }
   
   void drawXYAxis() {
    stroke(100, 100);
    line(0, center.y, width, center.y);
    line(center.x, 0, center.x, height);
   }
   
   void drawArc() {
      stroke(160, 160);
      float theta = getThetaRelativeToMouse();
      if (theta < 0) theta += TWO_PI;
      arc(center.x, center.y, 50, 50, -theta, 0);
   }
   
   void drawRightTriangle() {
     float theta = getThetaRelativeToMouse();
     PVector point = cartesianToScreen( polarToCartesian(theta, radius) ); 
     // Draw hypotenuse.
     line(center.x, center.y, point.x, point.y);
     
     // Draw adjacent leg.
     PVector adj_v1 = new PVector(center.x, center.y);
     PVector adj_v2 = new PVector(point.x, center.y);
     drawLeg("adjacent", adj_v1, adj_v2); 
     
     // Draw opposite leg.
     PVector opp_v1 = new PVector(point.x, center.y);
     PVector opp_v2 = new PVector(point.x, point.y);  
     drawLeg("opposite", opp_v1, opp_v2);
   }
   
   void drawLeg(String type, PVector v1, PVector v2) {
     textAlign(CENTER);
     textSize(10.0);
     float dist = (type.equals("adjacent")) ? v2.x - v1.x : v1.y - v2.y;
     dist = map(dist, -radius, radius, -1, 1);
     PVector mid = getMidpoint(v1, v2);
     line(v1.x, v1.y, v2.x, v2.y);
     text(dist, mid.x, mid.y - 1);
   }
   
   PVector getMidpoint(PVector v1, PVector v2) {
     return new PVector ( (v1.x + v2.x) / 2, (v1.y + v2.y) / 2  );
   }
   
   float getThetaRelativeToMouse() {
      PVector translatedMouse = screenToCartesian(new PVector(mouseX, mouseY));
      float theta = atan2(translatedMouse.y, translatedMouse.x);
      return theta;
   }
   
   PVector polarToCartesian(float theta, float radius) {
     return new PVector(cos(theta) * radius, sin(theta) * radius);
   }
   
   PVector cartesianToScreen(PVector coords) {
     return new PVector( coords.x + width / 2, -coords.y + height / 2 );
   }
   
   PVector screenToCartesian(PVector coords) {
     return new PVector( coords.x - width / 2, -coords.y + height / 2 );
   }
}