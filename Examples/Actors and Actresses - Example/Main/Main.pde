


/**
 * This program uses a data file of all the actors and actress' in IMDB
 * and creates bubbles for each actor and actress representing the number of movies
 * they have acted by the size of their radius.
 *
 *@author A.R.
 *@version 1.0
 *@since Processing 2.1.2
 *@since January 20th 2015
 */



import java.io.*;
int counter = 0;
int x = 11540;
ArrayList<Actor> newActors;
String keypressInput = "";
boolean sort = false;
int largest;
boolean showInstructions = true;
RandomAccessFile raf;


/**
 * This function sets ups the screen size and initializes the array of Actor objects to be used. Only carries out the functions once
 */
void setup() { 
  newActors = new ArrayList<Actor>();
  size(600, 600);
}

/**
 * This function continuously carries out the tasks being done repeatedly
 *
 * shows the instructions for how to run program
 *
 * displays object of actors on screen
 */

void draw() {
  try {
    background(244);
    fill(0);
    textAlign(CENTER, CENTER);
    if (showInstructions)
      text("Press 'm' for actors or press 'f' for actresses then press spacebar to run the file."+"\n"+"To switch between files you can just press m or f anytime and"+ "\n"+"press the spacebar to see the change of names."+"\n"+"Press the left button for sorting" + "\n" + "Press right button to search for the actor/actress with largest number of movies", width/2, height/2);
    if (key == 'm') {
      raf = new RandomAccessFile("actors.list", "r");
      raf.seek(x);
      if (raf == null) {
        noLoop();
        }
      } 
    else if (key == 'f') {
      raf = new RandomAccessFile("actresses.list", "r");
      raf.seek(x);
      if (raf == null) {
        noLoop();
        }
      }
      for (Actor a : newActors) {
        a.display(a.movieCount());
        if (!sort)
          a.update();
      }
  } 
  catch (Exception e) {
    println(e);
  }
}


/**
 * This function allows the Actor's bubbles to be displayed on screen when the spacebar is pressed
 * and updates the actors being shown on screen.
 */

void keyPressed() {
  sort = false;
  showInstructions = false;
  if (key == ' ') {
    search();
  }
}

/**
 * This function will sort the arraylist of Actors on their number of movies when left clicking on the mouse
 * and will search for the largest actor when the right button is pressed
 */
void mousePressed() {
  if (mouseButton == RIGHT) {

    largest = newActors.size()-1;
    println(newActors.get(newActors.size()-1).name);
    newActors.get(largest).changeFill(color(0));


    sort = true;
  }
  if (mouseButton == LEFT) {
    newActors = selectionSort(newActors, 0);
  }
}

/**
 * This function stops the arrangment the bubbles in the orbit when the mousebutton is released
 */

void mouseReleased() {
  sort = false;
}

/**
 * This function goes through the data file and creates new Actor objects everytime there is 
 * a new name. It also adds the number of movies per actor. 
 *
 * Only displays 500 lines at a time
 */

void search() {
  try {
    newActors.clear(); 
    raf.seek(x);
    for (int i = 0; i < 500; i++) {    
      x++;
      String line = raf.readLine();
      if (line != null) {
        try {
          String[] pieces = split(line, "\t\t");
          String name = pieces[0]; //unique name
          String movie = pieces[1];

          if (!name.equals("")) {
            newActors.add(new Actor(pieces[0], 1, new Bubbles(random(width), random(height), pieces[0], color(random(255), random(255), random(255)))));
          } 
          else if (name.equals("")) {
            newActors.get(newActors.size() - 1).increaseNumberOfMovies(); // adds number of movies to the Actor
          }
        }
        catch (Exception e) {
          String[] pieces = split(line, "\t\t\t");
        }
      }
    }
  }


  catch (Exception e) {
    println(e);
  }
}



/**
 * This function contains the algorhithm that sorts the arrayList of Actors based on their number of movies recursively
 *
 * @return the arrayList hollywood if the starting point is greater than the size of the 
 * size of ht earray
 *
 * @return  the sorted arrayList and its starting position + 1
 */

ArrayList<Actor> selectionSort(ArrayList<Actor> hollywood, int startingPoint) {
  if (startingPoint >= hollywood.size()-1) {
    return hollywood;
  } 
  else {

    int min = startingPoint;
    for (int j = startingPoint + 1; j < hollywood.size (); j++) { 
      if (hollywood.get(j).numberOfMovies < hollywood.get(min).numberOfMovies) {
        min = j;
      }
    }

    Actor temp = hollywood.get(startingPoint);
    hollywood.set(startingPoint, hollywood.get(min));
    hollywood.set(min, temp);
    return selectionSort(hollywood, startingPoint + 1);
  }
}