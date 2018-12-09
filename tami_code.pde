import geomerative.*;
import processing.pdf.*;
import java.util.Calendar;

RFont font;

String textTyped2 = "S I L E N T";

String textTyped = "L I S T E N";

int shapeSet = 0;
PShape dotShape, crossShape;
float targetX = 0; 
float targetY = 0;
PVector facePos;

void setup() {
  fullScreen();
  setupScreen(); // important for scaling the screen for the correct size
  setupTracking();// important for getting the face tracking information in dinFormat
  //myGraphic = new graphic();
  //setupString1();
    smooth();

  dotShape = loadShape("A_01.svg");
  crossShape = loadShape("A_02.svg");
  dotShape.disableStyle();
  crossShape.disableStyle();

  // allways initialize the library in setup
  RG.init(this);

  // load a truetype font
  font = new RFont("FreeSans.ttf", width/10, RFont.LEFT);
  
  RCommand.setSegmentLength(6);
  RCommand.setSegmentator(RCommand.UNIFORMLENGTH);
};

void draw() {
  
  background(240);
  facePos = faceLocation(); // the facelocation returns the position of the face in the camera view as a pvector
  targetX = facePos.x-.5; 
  targetY = facePos.y-.5;
  targetX *= width;
  targetY *= height;
  //float targetZ = facePos.z*5;

  noStroke();
  shapeMode(CENTER);
  
  
pushMatrix();
  // margin border
  translate(width/4, width/2); 

    strokeWeight(19);

  if (textTyped.length() > 0) {
    // get the points on font outline
    RGroup grp;
    grp = font.toGroup(textTyped);
    grp = grp.toPolygonGroup();
    RPoint[] pnts = grp.getPoints();

    // ------ svg modules ------
    // dotShape
    int alpha = floor((facePos.z*2)*255);
    
   if (alpha > 255){
     alpha = 255;
   }
  imageDisplay(alpha,30, pnts,#009D8F, dotShape);
  imageDisplay(floor((facePos.z*2)*255),18, pnts,#CBFFD4, crossShape);
   
  }
  popMatrix();
  
  //second string
  pushMatrix();
  // margin border
  translate(width/2,height/2);
   rotate(-HALF_PI);
  
    strokeWeight(5);
  if (textTyped2.length() > 0) {
    // get the points on font outline
    RGroup grp;
    grp = font.toGroup(textTyped2);
    grp = grp.toPolygonGroup();
    RPoint[] pnts = grp.getPoints();

    // ------ svg modules ------
    // dotShape
  int alpha = 255-floor((facePos.z*2)*255);

   if (alpha > 255){
     alpha = 255;
   }
   
  imageDisplay(alpha,140, pnts,#FA7272, dotShape);
    // crossShape
  imageDisplay((255-floor((facePos.z*2)*255)),19, pnts,#ED1111, crossShape);
  }
  popMatrix();

}
 private void imageDisplay(int alpha,
 float diameter,
 RPoint points[],
 color colorHexCode,
 PShape shape
 )
 {    
    fill(colorHexCode, alpha);
    for (int i=0; i < points.length-1; i++ ) {
      // on every third point
      if (i%3 == 0) {
        // rotate the module facing to the next one (i+1)
        pushMatrix();
        float angle = atan2(points[i].y-points[i+1].y, points[i].x-points[i+1].x);
        translate(points[i].x, points[i].y);
        rotate(angle);
        rotate(radians(targetX));
        shape(shape, 0,0, diameter+(targetY/2.5),diameter+(targetY/2.5));
        popMatrix();
      }
    }
 }
  // uncomment for extra information on face orientation
  //PVector orientation = orient(); // the orientation returns the orientation of the face  as a pvector
  //orientation.mult(100);
  //stroke(255, 0, 0);
  //line(width/2, height/2, width/2+orientation.y, height/2+orientation.x);
