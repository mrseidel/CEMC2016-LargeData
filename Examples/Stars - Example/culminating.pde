/**
 * Culminating
 * 
 * This program reads a text file containing information about stars and outputs it.
 * 
 * @author H.T.
 * @version 1.0
 * @since JDK 1.7.0_25
 * @since Jan 20th, 2014
 * 
 * 1.   Import data into array. CHECK! stars[][]
 * 2.   Get data and reorganize it. CHECK! smallest to largest
 * 3.   Output data.
 * 4.   Make infographic showing info.
 * http://piktochart.com/how-to-create-infographic-in-5-minutes/
 * 
 * Objects                ~
 * Inheritance            ~
 * Recursion              !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 * Functions and Methods  ~
 * Sorting                ~
 * Searching              ~  (used when finding what line should be displayed)
 * File Management        ~
 */

/**
 * @param reader           BufferedReader to read text file
 * @param font             font type to display text
 * @param counter          counter # 1 for loops
 * @param count            counter # 2 for loops
 * @param numstars         total number of stars
 * @param stars            two-dimension array of stars and its information
 * @param names            array with number of names each star has
 * @param holder           place holder array to make new array of information
 * @param xval             xvalue coordinate for outputing line
 * @param yval             yvalue coordinate for outputing line
 * @param zval             zvalue coordinate for outputing line
 * @param brightval        brightvalue coordinate for outputing line
 * @param overx            to check whether mouse is over x column
 * @param overy            to check whether mouse is over y column
 * @param overz            to check whether mouse is over z column
 * @param overbright       to check whether mouse is over bright column
 * @param overrect1        to check whether mouse is over rect1
 * @param overrect2        to check whether mouse is over rect2
 * @param wanted           value wanted/searching for # 1
 * @param wanted2          value wanted/searching for # 2
 * @param output           value to output
 * @param total            total of lines that coorespond to where the mouse is
 * @param holds            variable holder for a value
 * @param colour           two-dimension array for rgb value
 * @param specialan1       to check whether to output special animation or not
 * @param countcounter     counter for specialanimation #1
 * @param specialan2       to check whether to output special animation # 2 or not
 * @param countercount     counter for specialanimation #2
 */
 
BufferedReader reader;
import java.io.IOException;
import java.io.FileReader;
PFont font;
int counter = 0;
int count = 0;
int numstars = 0;
String [][] stars;
int [] names;
float [][] holder;
float xval[];
float yval[];
float zval[];
float brightval[];
Boolean overx = false;
Boolean overy = false;
Boolean overz = false;
Boolean overbright = false;
Boolean overrect1 = false;
Boolean overrect2 = false;
int wanted = 0;
int wanted2 = 0;
float output;
int total = 0;
int holds;
int [][] colour;
Boolean specialan1 = false;
int countcounter = 0;
Boolean specialan2 = false;
int countercount = 0;

void setup() {
  frameRate(10);
  size(1000, 1000);
  font = createFont("Calibri", 32);
  //font = createFont("Calibri",72,true);
  reader = createReader("stars.txt");  
  try {
    String current;    
    while ( (current = reader.readLine ()) != null) {
      numstars++;
    }
    reader.close();
  }
  catch(IOException e) {
    e.printStackTrace();
  }
  reader = createReader("stars.txt");
  stars = new String [numstars][];
  names = new int [numstars];
  try {
    String current;
    String delim = " ";
    while ( (current = reader.readLine ()) != null) {      
      stars[counter] = split(current, delim);
      if (stars[counter].length == 6) {
        names[counter] = 0;
      }
      else if (stars[counter].length == 7) {
        names[counter] = 1;
      }
      else if (stars[counter].length == 8) {
        if (stars[counter][6].contains(";")) {
          stars[counter][6] = stars[counter][6].replace(";", "");
          names[counter] = 2;
        }
        else {
          stars[counter][6] = stars[counter][6]+" "+stars[counter][7];
          stars[counter][7] = null;
          names[counter] = 1;
        }
      }
      else if (stars[counter].length == 9) {
        if (stars[counter][6].contains(";") && stars[counter][7].contains(";")) {
          stars[counter][6] = stars[counter][6].replace(";", "");
          stars[counter][7] = stars[counter][7].replace(";", "");
          names[counter] = 3;
        }
        else if (stars[counter][6].contains(";")) {
          stars[counter][6] = stars[counter][6].replace(";", "");
          stars[counter][7] = stars[counter][7]+" "+stars[counter][8];
          stars[counter][8] = null;
          names[counter] = 2;
        }
        else if (stars[counter][7].contains(";")) {
          stars[counter][7] = stars[counter][7].replace(";", "");
          stars[counter][6] = stars[counter][6]+" "+stars[counter][7];
          stars[counter][7] = stars[counter][8];
          stars[counter][8] = null;
          names[counter] = 2;
        }
        else {
          stars[counter][6] = stars[counter][6]+" "+stars[counter][7]+" "+stars[counter][8];
          stars[counter][7] = null;
          stars[counter][8] = null;
          names[counter] = 1;
        }
      }
      else if (stars[counter].length == 10) {
        if (stars[counter][6].contains(";")) {
          stars[counter][6] = stars[counter][6].replace(";", "");
          if (stars[counter][7].contains(";")) {
            stars[counter][7] = stars[counter][7].replace(";", "");
            stars[counter][8] = stars[counter][8]+" "+stars[counter][9];
            stars[counter][9] = null;
            names[counter] = 3;
          }
          else if (stars[counter][8].contains(";")) {
            stars[counter][8] = stars[counter][8].replace(";", "");
            stars[counter][7] = stars[counter][7]+" "+stars[counter][8];
            stars[counter][8] = stars[counter][9];
            stars[counter][9] = null;
            names[counter] = 3;
          }
          else {
            stars[counter][7] = stars[counter][7]+" "+stars[counter][8]+" "+stars[counter][9];
            stars[counter][8] = null;
            stars[counter][9] = null;
            names[counter] = 2;
          }
        }
        else if (stars[counter][7].contains(";")) {
          stars[counter][7] = stars[counter][7].replace(";", "");
          stars[counter][6] = stars[counter][6]+" "+stars[counter][7];
          if (stars[counter][8].contains(";")) {
            stars[counter][8] = stars[counter][8].replace(";", "");
            stars[counter][7] = stars[counter][8];
            stars[counter][8] = stars[counter][9];
            stars[counter][9] = null;
            names[counter] = 3;
          }
          else {
            stars[counter][7] = stars[counter][8]+" "+stars[counter][9];
            stars[counter][8] = null;
            stars[counter][9] = null;
            names[counter] = 2;
          }
        }
        else if (stars[counter][8].contains(";")) {
          stars[counter][8] = stars[counter][8].replace(";", "");
          stars[counter][6] = stars[counter][6]+" "+stars[counter][7]+" "+stars[counter][8];
          stars[counter][7] = stars[counter][9];
          stars[counter][8] = null;
          stars[counter][9] = null;
          names[counter] = 2;
        }
        else {
          stars[counter][6] = stars[counter][6]+" "+stars[counter][7]+" "+stars[counter][8]+" "+stars[counter][9];
          stars[counter][7] = null;
          stars[counter][8] = null;
          stars[counter][9] = null;
          names[counter] = 1;
        }
      }
      counter++;
    }
    reader.close();
  }
  catch(Exception e) {
    e.printStackTrace();
  }  

  count = 0;
  counter = 0;  
  Stars star [] = new Stars [numstars+1];

  //making object for each star
  while (counter < numstars) {
    if (names[counter] == 0) {
      star[counter] = new Stars(Float.parseFloat(stars[counter][0]), Float.parseFloat(stars[counter][1]), Float.parseFloat(stars[counter][2]), Float.parseFloat(stars[counter][3]), Float.parseFloat(stars[counter][4]), Float.parseFloat(stars[counter][5]), null, null, null);
    }
    else if (names[counter] == 1) {
      star[counter] = new Stars(Float.parseFloat(stars[counter][0]), Float.parseFloat(stars[counter][1]), Float.parseFloat(stars[counter][2]), Float.parseFloat(stars[counter][3]), Float.parseFloat(stars[counter][4]), Float.parseFloat(stars[counter][5]), stars[counter][6], null, null);
    }
    else if (names[counter] == 2) {
      star[counter] = new Stars(Float.parseFloat(stars[counter][0]), Float.parseFloat(stars[counter][1]), Float.parseFloat(stars[counter][2]), Float.parseFloat(stars[counter][3]), Float.parseFloat(stars[counter][4]), Float.parseFloat(stars[counter][5]), stars[counter][6], stars[counter][7], null);
    }
    else {
      //names == 3
      star[counter] = new Stars(Float.parseFloat(stars[counter][0]), Float.parseFloat(stars[counter][1]), Float.parseFloat(stars[counter][2]), Float.parseFloat(stars[counter][3]), Float.parseFloat(stars[counter][4]), Float.parseFloat(stars[counter][5]), stars[counter][6], stars[counter][7], stars[counter][8]);
    }
    counter++;
  }

  counter = 0;
  //placeholder for stars when switch position
  star[numstars] = new Stars(Float.parseFloat("0"), Float.parseFloat("0"), Float.parseFloat("0"), Float.parseFloat("0"), Float.parseFloat("0"), Float.parseFloat("0"), null, null, null);

  //sort
  for (counter = 1;counter < star.length;counter++) {
    count = counter;
    while (count > 0 && star[count].brightness < star[count-1].brightness) {
      star[numstars] = star[count-1];
      star[count-1] = star[count];
      star[count] = star[numstars];
      count--;
    }
  }
  counter = 0;

  //trial
  xval = new float [numstars];
  yval = new float [numstars];
  zval = new float [numstars];
  brightval = new float [numstars];
  //x
  while (counter < numstars) {
    xval[counter] = Float.parseFloat(String.format("%.2f", star[counter].x));
    if (xval[counter] < 0) {
      xval[counter] = xval[counter] + 1;
      xval[counter] = xval[counter]*100;
      xval[counter] = xval[counter]*4;
      xval[counter] = 930 - xval[counter];
    }
    else if (xval[counter] > 0) {
      xval[counter] = xval[counter] - 1;
      xval[counter] = xval[counter]*-100;
      xval[counter] = xval[counter]*4;
      xval[counter] = 130 + xval[counter];
    }
    else {
      xval[counter] = 530;
    }
    counter++;
  }
  counter = 0;
  //y
  while (counter < numstars) {
    yval[counter] = Float.parseFloat(String.format("%.2f", star[counter].y));
    if (yval[counter] < 0) {
      yval[counter] = yval[counter] + 1;
      yval[counter] = yval[counter]*100;
      yval[counter] = yval[counter]*4;
      yval[counter] = 930 - yval[counter];
    }
    else if (yval[counter] > 0) {
      yval[counter] = yval[counter] - 1;
      yval[counter] = yval[counter]*-100;
      yval[counter] = yval[counter]*4;
      yval[counter] = 130 + yval[counter];
    }
    else {
      yval[counter] = 530;
    }
    counter++;
  }
  counter = 0;
  //z
  while (counter < numstars) {
    zval[counter] = Float.parseFloat(String.format("%.2f", star[counter].z));
    if (zval[counter] < 0) {
      zval[counter] = zval[counter] + 1;
      zval[counter] = zval[counter]*100;
      zval[counter] = zval[counter]*4;
      zval[counter] = 930 - zval[counter];
    }
    else if (zval[counter] > 0) {
      zval[counter] = zval[counter] - 1;
      zval[counter] = zval[counter]*-100;
      zval[counter] = zval[counter]*4;
      zval[counter] = 130 + zval[counter];
    }
    else {
      zval[counter] = 530;
    }
    counter++;
  }
  counter = 0;
  //brightness
  while (counter < numstars) {
    brightval[counter] = Float.parseFloat(String.format("%.1f", star[counter].brightness));
    if (brightval[counter] < 0) {
      brightval[counter] = brightval[counter] + 2;
      brightval[counter] = brightval[counter] *10;
      brightval[counter] = brightval[counter]*6;
      brightval[counter] = 920 - brightval[counter];
    } 
    else if (brightval[counter] > 0) {
      brightval[counter] = brightval[counter] - 11;
      brightval[counter] = brightval[counter]*-10;
      brightval[counter] = brightval[counter]*6;
      brightval[counter] = 140 + brightval[counter];
    }
    else {
      brightval[counter] = 800;
    }
    counter++;
  }
  counter = 0;
  count = 0;
  colour = new int [numstars][3];
  //randomize rgb values
  while (counter < numstars) {
    while (count < 3) {
      colour[counter][count] = int(random(255));
      count++;
    }
    count = 0;
    counter++;
  }
  counter = 0;
}

void draw() {
  background(255, 255, 133);
  counter = 0;
  fill(0);
  stroke(0);
  line(80, 130, 80, 930);
  line(335, 130, 335, 930);
  line(370, 130, 370, 930);
  line(625, 130, 625, 930);
  line(660, 130, 660, 930);
  line(915, 140, 915, 920);
  text("X", 58, 110);
  text("Y", 348, 110);
  text("Z", 638, 110);
  text("Brightness", 895, 110);

  //x
  output = 1.0;
  while (counter < 11) {
    text(String.format("%.1f", output-counter*0.2), 55, 135+counter*80);
    counter ++;
  }
  counter = 0;  
  //number lines
  while (counter < 11) {
    line(75, 130+counter*80, 80, 130+counter*80);
    counter++;
  }
  counter = 0;  
  //inbewteen lines
  while (counter < 10) {
    line(75, 170+counter*80, 80, 170+counter*80);
    counter++;
  }
  counter = 0;

  //y
  output = 1.0;
  while (counter < 11) {
    text(String.format("%.1f", output-counter*0.2), 345, 135+counter*80);
    counter++;
  }
  counter = 0;  
  //left
  //number lines
  while (counter < 11) {
    line(335, 130+counter*80, 340, 130+counter*80);
    counter++;
  }
  counter = 0;  
  //inbewteen lines
  while (counter < 10) {
    line(335, 170+counter*80, 340, 170+counter*80);
    counter++;
  }
  counter = 0;
  //right
  //number lines
  while (counter < 11) {
    line(365, 130+counter*80, 370, 130+counter*80);
    counter++;
  }
  counter = 0;
  //inbewteen lines
  while (counter < 10) {
    line(365, 170+counter*80, 370, 170+counter*80);
    counter++;
  }
  counter = 0;

  //z
  output = 1.0;
  while (counter < 11) {
    text(String.format("%.1f", output-counter*0.2), 635, 135+counter*80);
    counter ++;
  }
  counter = 0;
  //left
  //number lines
  while (counter < 11) {
    line(625, 130+counter*80, 630, 130+counter*80);
    counter++;
  }
  counter =0;
  //inbewteen lines
  while (counter < 10) {
    line(625, 170+counter*80, 630, 170+counter*80);
    counter++;
  }
  counter = 0;
  //right
  //number lines
  while (counter < 11) {
    line(655, 130+counter*80, 660, 130+counter*80);
    counter++;
  }
  counter = 0;
  //inbewteen lines
  while (counter < 10) {
    line(655, 170+counter*80, 660, 170+counter*80);
    counter++;
  }
  counter = 0;

  //brightness
  output = 11;
  while (counter < 14) {
    text(String.format("%.0f", output-counter*1), 925, 145+counter*60);
    counter ++;
  }
  counter = 0;
  //number lines
  while (counter < 14) {
    line(915, 140+counter*60, 920, 140+counter*60);
    counter++;
  }
  //inbetween lines
  counter = 0;
  while (counter < 13) {
    line(915, 170+counter*60, 920, 170+counter*60);
    counter++;
  }
  counter = 0;

  //interaction
  //determine where the mouse is hovering over
  if (mouseX > 55 && mouseX < 80 && mouseY > 130 && mouseY < 930) {
    overx = true;
  }
  else {
    overx = false;
  }
  if (mouseX > 335 && mouseX < 370 && mouseY > 130 && mouseY < 930) {
    overy = true;
  }
  else {
    overy = false;
  }
  if (mouseX > 625 && mouseX < 660 && mouseY > 130 && mouseY < 930) {
    overz = true;
  }
  else {
    overz = false;
  }
  if (mouseX > 915 && mouseX < 940 && mouseY > 140 && mouseY < 920) {
    overbright = true;
  }
  else {
    overbright = false;
  }
  //find what value to output
  if (overx == true || overy == true || overz == true || overbright == true) {
    if (overx == true || overy == true || overz == true) {
      wanted = mouseY - 130;
      if (wanted % 4 == 0) {  //remainder is 0, do nothing
        wanted = wanted + 130;
      }
      else if (wanted % 4 == 1) {  //remainder is 1, round down
        wanted = wanted - 1;
        wanted = wanted + 130;
      }
      else if (wanted % 4 == 2) {  //remainder is 2, round up
        wanted = wanted + 2;
        wanted = wanted + 130;
      }
      else {  //remainder is 3, round up
        wanted = wanted + 1;
        wanted = wanted + 130;
      }
      count  = 0;
      counter = 0;
      total = 0;
      if (overx == true) {
        while (count < numstars) {
          if (wanted == xval[count]) {
            total++;
            if (wanted2 != wanted) {
              holds = int(random(numstars));
            }
            stroke(colour[holds][0], colour[holds][1], colour[holds][2]);
            line(80, xval[count], 335, yval[count]);
            line(370, yval[count], 625, zval[count]);
            line(660, zval[count], 915, brightval[count]);
          }
          count++;
        }
      }
      if (overy == true) {
        while (count < numstars) {
          if (wanted == yval[count]) {
            total++;
            if (wanted2 != wanted) {
              holds = int(random(numstars));
            }
            stroke(colour[holds][0], colour[holds][1], colour[holds][2]);
            line(80, xval[count], 335, yval[count]);
            line(370, yval[count], 625, zval[count]);
            line(660, zval[count], 915, brightval[count]);
          }
          count++;
        }
      }
      if (overz == true) {
        while (count < numstars) {
          if (wanted == zval[count]) {
            total++;
            if (wanted2 != wanted) {
              holds = int(random(numstars));
            }
            stroke(colour[holds][0], colour[holds][1], colour[holds][2]);
            line(80, xval[count], 335, yval[count]);
            line(370, yval[count], 625, zval[count]);
            line(660, zval[count], 915, brightval[count]);
          }
          count++;
        }
      }
    }
    else {  //overbright = true
      wanted = mouseY - 140;
      if (wanted % 6 == 0) {
        wanted = wanted + 140;
      }
      else if (wanted % 6 == 1) {  //remainder is 1, round down
        wanted = wanted - 1;
        wanted = wanted + 140;
      }
      else if (wanted % 6 == 2) {  //remainder is 2, round down
        wanted = wanted - 2;
        wanted = wanted + 140;
      }
      else if (wanted % 6 == 3) {  //remainder is 3, round up
        wanted = wanted + 3;
        wanted = wanted + 140;
      }
      else if (wanted % 6 == 4) {  //remainder is 4, round up
        wanted = wanted + 2;
        wanted = wanted + 140;
      }
      else {  //remainder is 5, round up
        wanted = wanted + 1;
        wanted = wanted + 140;
      }
      count = 0;
      total = 0;
      while (count < numstars) {
        if (wanted == Float.parseFloat(String.format("%.0f", brightval[count]))) {
          total++;
          if (wanted2 != wanted) {
            holds = int(random(numstars));
          }
          stroke(colour[holds][0], colour[holds][1], colour[holds][2]);
          line(80, xval[count], 335, yval[count]);
          line(370, yval[count], 625, zval[count]);
          line(660, zval[count], 915, brightval[count]);
        }
        count++;
      }
      count = 0;
    }
  }
  else {
    total = 0;
  }
  //text(wanted, 490, 30);
  text("Number of stars that fit the requirement:", 55, 30);
  text(total, 275, 30);
  wanted2 = wanted;
  if (total == 0) {
    text("No data.", 55, 50);
  }
  text("Click the buttons for \"SPECIAL\" animation.", 55, 75);
  fill(0);
  noStroke();
  rect(750, 20, 100, 50);
  if (mouseX > 750 && mouseX < 850 && mouseY > 20 && mouseY < 70) {
    overrect1 = true;
  }
  else {
    overrect1 = false;
  }
  /*fill(0);
  noStroke();
  rect(650, 50, 20, 20);
  if (mouseX > 650 && mouseX < 670 && mouseY >30 && mouseY < 70) {
    overrect2 = true;
  }
  else {
    overrect2 = false;
  }*/
  counter = 0;
  count = 0;
  if (specialan1 == true) {
    if (countcounter == numstars) {
    }
    else {
      holds = int(random(numstars));
      stroke(colour[holds][0], colour[holds][1], colour[holds][2]);
      line(80, xval[countcounter], 335, yval[countcounter]);
      line(370, yval[countcounter], 625, zval[countcounter]);
      line(660, zval[countcounter], 915, brightval[countcounter]);
      countcounter++;
    }
  }
  /*if (specialan2 == true) {
    if (countercount == 2) {
    }
    else {
      while (wanted > 410) {
        while (count < numstars) {
          if (wanted == brightval[count]) {
            holds = int(random(numstars));
            stroke(colour[holds][0], colour[holds][1], colour[holds][2]);
            line(80, xval[countcounter], 335, yval[countcounter]);
            line(370, yval[countcounter], 625, zval[countcounter]);
            line(660, zval[countcounter], 915, brightval[countcounter]);
          }
        }
        wanted = wanted + counter*6;
      }
      while (wanted < 590) {
      }
    }
  }*/
}

/*if (specialan11 == true) {
 counter = 0;
 holds = int(random(numstars));
 while (counter < numstars) {
 stroke(colour[holds][0], colour[holds][1], colour[holds][2]);
 line(80, xval[counter], 335, yval[counter]);
 line(370, yval[counter], 625, zval[counter]);
 line(660, zval[counter], 915, brightval[counter]);
 counter++;
 }
 counter = 0;
 }*/

void mousePressed() {
  if (overrect1 == true) {
    specialan1 = true;
    countcounter = 0;
  }
  if (overrect2 == true) {
    specialan2 = true;
    countercount = 0;
  }
}


//roughwork/coding/links for information
/*void sort(String [] array, int bounds) {
 int count;
 System.out.println(array[0]);
 for (counter = 1;counter < bounds;counter++) {
 count = counter;
 while (count > 0 && array[count] < star[count-1]) {
 array[numstars] = array[count-1];
 array[count-1] = array[count];
 array[count] = array[numstars];
 count--;
 }
 }
 counter = 0;
 return;
 }*/

