import geomerative.*;

import processing.pdf.*;

import java.util.Calendar;


RFont font;


String textTyped2 = "S I L E N T";


String textTyped = "L I S T E N";


int shapeSet = 0;

PShape module1, module2;


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

  float targetX = facePos.x-.5; 

  float targetY = facePos.y-.5;

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

    strokeWeight(5);

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

 

  println(alpha);

    fill(#009D8F, alpha);

    float diameter = 30;

    for (int i=0; i < pnts.length-1; i++ ) {

      // on every third point

      if (i%3 == 0) {

        // rotate the module facing to the next one (i+1)

        pushMatrix();

        float angle = atan2(pnts[i].y-pnts[i+1].y, pnts[i].x-pnts[i+1].x);

        translate(pnts[i].x, pnts[i].y);

        rotate(angle);

        rotate(radians(-targetX));

        shape(module1, 0,0, diameter+(targetY/2.5),diameter+(targetY/2.5));

        popMatrix();

      }

    }


    // module2

    alpha = floor((facePos.z*2)*255);

    fill(#CBFFD4, alpha);

    diameter = 18;

    for (int i=0; i < pnts.length-1; i++ ) {

      // on every third point

      if (i%3 == 0) {

        // rotate the module facing to the next one (i+1)

        pushMatrix();

        float angle = atan2(pnts[i].y-pnts[i+1].y, pnts[i].x-pnts[i+1].x);

        translate(pnts[i].x, pnts[i].y);

        rotate(angle);

        rotate(radians(targetX));

        shape(module2, 0,0, diameter+(targetY/2.5),diameter+(targetY/2.5));

        popMatrix();

      }

    }

  }

  popMatrix();

  

  //second string

  pushMatrix();

  // margin border

  translate(width/2,height++);

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

 

  println(alpha);

    fill(#FA7272, alpha);

    float diameter = 140;

    for (int i=0; i < pnts.length-1; i++ ) {

      // on every third point

      if (i%3 == 0) {

        // rotate the module facing to the next one (i+1)

        pushMatrix();

        float angle = atan2(pnts[i].y-pnts[i+1].y, pnts[i].x-pnts[i+1].x);

        translate(pnts[i].x, pnts[i].y);

        rotate(angle);

        rotate(radians(-targetX));

        shape(module1, 0,0, diameter+(targetY/2.5),diameter+(targetY/2.5));

        popMatrix();

      }

    }


    // module2

  alpha = 255-floor((facePos.z*2)*255);

    fill(#ED1111, alpha);

    diameter = 18;

    for (int i=0; i < pnts.length-1; i++ ) {

      // on every third point

      if (i%3 == 0) {

        // rotate the module facing to the next one (i+1)

        pushMatrix();

        float angle = atan2(pnts[i].y-pnts[i+1].y, pnts[i].x-pnts[i+1].x);

        translate(pnts[i].x, pnts[i].y);

        rotate(angle);

        rotate(radians(targetX));

        shape(module2, 0,0, diameter+(targetY/2.5),diameter+(targetY/2.5));

        popMatrix();

      }

    }

  }

  popMatrix();


}


  // uncomment for extra information on face orientation

  //PVector orientation = orient(); // the orientation returns the orientation of the face  as a pvector

  //orientation.mult(100);

  //stroke(255, 0, 0);

  //line(width/2, height/2, width/2+orientation.y, height/2+orientation.x);
