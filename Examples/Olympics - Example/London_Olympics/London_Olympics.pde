import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;
import javax.swing.JOptionPane;
import javax.swing.JFrame;
import processing.serial.*;

/**
 * This file is the main file and runs the program
 * 
 * @author J.B.
 * @since January 21
 * @since JDK 8
 * @version 1.0
 * 
 */
float sideSpace, heightSpace;
float radius; //for semi circle
ArrayList<Country> countries;
ArrayList<Country> athletes;
float timer;
float bufferSpace;
float extension;
ArrayList<String> countryname;
ArrayList<String> infoByName;
ArrayList<String> nameList;
ArrayList<String> displayNames;
int countryTracker;
int counter;
boolean stop;
int countryIndex;
float timer2;
color col;
boolean initiate;
void setup() {
  initiate=false;
  stop=false;
  size(1400, 700); 
  background(255);
  sideSpace=1;
  heightSpace=100;
  counter=0;
  timer=0;
  timer2=0;
  displayNames=new ArrayList<String>();
  nameList=new ArrayList<String>();
  countries=new ArrayList<Country>();
  athletes=new ArrayList<Country>();
  countryname=new ArrayList<String>();
  infoByName =  new  ArrayList<String>();
  radius=height-2*heightSpace;
  bufferSpace=sideSpace*250+100;
  extension=1400;
  countryTracker=0;
  countryname=readfiles("Data\\country list Olympic Order.txt");
  infoByName=readfiles("Data\\Final Data Sorted by Name.txt");
  nameList=readfiles("Data\\Names List.txt");
}

void draw() {



  if (timer%31==0) {
    countries.add(new Country(countryname.get(countryTracker), width-sideSpace+bufferSpace+extension, height/2+radius/2, sideSpace+bufferSpace, radius/2));
    countryTracker+=1;
  }
  if (countries.size()==countryname.size()) {
    timer=1;
  }

  timer2+=1;
  if (initiate==true) {
    if (athletes.size()<=displayNames.size ()) {

      if (timer2%33==0) {
        athletes.add(new Athletes(displayNames.get(counter)+",     ", width-sideSpace+bufferSpace+extension+10, height/2+175, sideSpace+bufferSpace, 175, col));
        counter+=1;
      }
    }
  }
  if (stop==false) {
    timer+=1;

    drawMap();
    for (int i=0; i< countries.size (); i++) {
      if (countries.get(i).clicked()==true) {
        countryIndex=i;
        stop=true;
      }
      countries.get(i).display();
    }
  } else {
    if (athletes.size()==0) {
      initiateAthletes(countryIndex);
    } else {
      drawSmallMap();
      for (int i=0; i < athletes.size (); i++) {
        athletes.get(i).display();
        if (athletes.get(i) instanceof Country ) {
          athletes.get(0).drawFlag(width/2, height/2, false);
        }
      }
    }
  }
}


/**
 * This function loads a file as an arraylist
 *
 * @param name of file to be loaded
 * 
 */
public ArrayList<String> readfiles(String fileName) {
  String[] file= loadStrings(fileName);
  ArrayList <String> list = new ArrayList<String>();


  for (int i=0; i<file.length; i++) {

    list.add(file[i]);
  }
  return list;
}

/**
 * This function joins an array as a string
 *
 * @param array this is the array to be joined
 * @param addBetween this is the string to be added in between
 * 
 */
String JoinArray(String[] array, String addBetween) {
  String arrayHolder="";

  for (int i=0; i<array.length; i++) {
    arrayHolder+=(array[i] + addBetween);
  } 
  return arrayHolder.substring(0, arrayHolder.length()-1);
}

/**
 * This function draw the large track and serves as the main track
 * 
 */
void drawMap() {
  background(255);
  stroke(145, 58, 0);
  noFill();
  strokeWeight(150);
  line(sideSpace+bufferSpace, heightSpace, width-sideSpace+bufferSpace+extension, heightSpace);
  line(sideSpace+bufferSpace, height-heightSpace, width-sideSpace+bufferSpace+extension, height-heightSpace);
  ellipse(sideSpace+bufferSpace, height/2, radius, radius);
  ellipse(width-sideSpace+bufferSpace+extension, height/2, radius, radius);

  strokeWeight(350);
  stroke(255);
  line(sideSpace+bufferSpace, height/2, width-sideSpace+bufferSpace+extension, height/2);

  stroke(50);
}

/**
 * This function draws a smaller map used for the second round
 */
void drawSmallMap() {
  strokeWeight(400);
  stroke(145, 58, 0);

  line(sideSpace+bufferSpace, height/2, width-sideSpace+bufferSpace+extension, height/2);

  stroke(255);
  strokeWeight(350);
  line(sideSpace+bufferSpace, height/2, width-sideSpace+bufferSpace+extension, height/2);
}

/**
 * This function initiates the athletes array
 *
 * @param _index the index of the arraylist we needed
 * 
 */
void initiateAthletes(int _index) {
  athletes.add(new Country(countries.get(_index).countryInfo, width-sideSpace+bufferSpace+extension-30, height/2+175, sideSpace+bufferSpace, 175));

  displayNames=displayNameList(athletes.get(0).nameOfCountry());
  col=countries.get(_index).colour();
  initiate=true;
}

/**
 * This function splits the name of the athletes
 *
 * @param name name of the country to look for
 * 
 */
ArrayList displayNameList(String name) {
  String country;
  String athlete;
  String[] array = new String[2];
  ArrayList<String> athletelist = new ArrayList<String>();

  for (int i=0; i<nameList.size (); i++) {  
    array=split(nameList.get(i), ",");
    country=array[0];
    athlete=array[1];
    country=country.substring(0, country.length()-1);
    if (country.equals(name)) {
      athletelist.add(array[1]);
    }
  }
  return athletelist;
}

void keyPressed() {
  if (key==' ') {
    stop=false;
    countries.get(countryIndex).setFalse();
    athletes.clear();
    counter=0;
    timer2=0;
    initiate=false;
    displayNames.clear();
  }
}