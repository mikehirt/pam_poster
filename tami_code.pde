import geomerative.*;
import processing.pdf.*;
import java.util.Calendar;

RFont font;

String textTyped2 = "S I L E N T";

String textTyped = "L I S T E N";

int shapeSet = 0;
PShape module1, module2;
float targetX = 0; 
float targetY = 0;

void setup() {
  fullScreen();
  setupScreen(); // important for scaling the screen for the correct size
  setupTracking();// important for getting the face tracking information in dinFormat
  //myGraphic = new graphic();
  //setupString1();
    smooth();

  module1 = loadShape("A_01.svg");
  module2 = loadShape("A_02.svg");
  module1.disableStyle();
  module2.disableStyle();

  // allways initialize the library in setup
  RG.init(this);

  // load a truetype font
  font = new RFont("FreeSans.ttf", width/10, RFont.LEFT);
  
  RCommand.setSegmentLength(6);
  RCommand.setSegmentator(RCommand.UNIFORMLENGTH);
};

void draw() {
  
  background(240);
  PVector facePos = faceLocation(); // the facelocation returns the position of the face in the camera view as a pvector
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
  //translate(x,y);
 
  
    //for (int i = 1; i <= 20; i++) {
    strokeWeight(19);
//    float scale = width*.65-(i*15);
    //float X = targetX*(i*.04);
   // float Y = targetY*(i*.04);
    
    //pushMatrix();
    //rotate(radians(targetZ*i*4));
   // popMatrix();
 // };

  if (textTyped.length() > 0) {
    // get the points on font outline
    RGroup grp;
    grp = font.toGroup(textTyped);
    grp = grp.toPolygonGroup();
    RPoint[] pnts = grp.getPoints();

    // ------ svg modules ------
    // module1
    int alpha = floor((facePos.z*2)*255);
    // add if statment to keep alpha bellow 255;
   if (alpha > 255){
     alpha = 255;
   }
 

 
  imageDisplay(alpha,30, pnts,#009D8F);
  imageDisplay(floor((facePos.z*2)*255),18, pnts,#CBFFD4);
   
  }
  popMatrix();
  
  //second string
  pushMatrix();
  // margin border
  translate(width/2,height/2);
   rotate(-HALF_PI);
  
    //for (int i = 1; i <= 20; i++) {
    strokeWeight(5);
//    float scale = width*.65-(i*15);
    //float X = targetX*(i*.04);
   // float Y = targetY*(i*.04);
    
    //pushMatrix();
    //rotate(radians(targetZ*i*4));
    //popMatrix();
 // };

  if (textTyped2.length() > 0) {
    // get the points on font outline
    RGroup grp;
    grp = font.toGroup(textTyped2);
    grp = grp.toPolygonGroup();
    RPoint[] pnts = grp.getPoints();

    // ------ svg modules ------
    // module1
  int alpha = 255-floor((facePos.z*2)*255);
    // add if statment to keep alpha bellow 255;
   if (alpha > 255){
     alpha = 255;
   }
   
  imageDisplay(alpha,140, pnts,#FA7272 );
      
    // module2
    imageDisplay((255-floor((facePos.z*2)*255)),19, pnts,#ED1111);
  }
  popMatrix();

}
 private void imageDisplay(int alpha,
 float diameter,
 RPoint points[],
 color colorHexCode
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
        shape(module2, 0,0, diameter+(targetY/2.5),diameter+(targetY/2.5));
        popMatrix();
      }
    }
 }
  // uncomment for extra information on face orientation
  //PVector orientation = orient(); // the orientation returns the orientation of the face  as a pvector
  //orientation.mult(100);
  //stroke(255, 0, 0);
  //line(width/2, height/2, width/2+orientation.y, height/2+orientation.x);
