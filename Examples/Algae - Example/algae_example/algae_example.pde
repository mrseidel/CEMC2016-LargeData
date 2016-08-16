/**
 * Mr. Seidel's Grade 12 Computer Science class Semester 1 (ICS4UO)
 * 
 * @author F.D.
 * @since January 21st, 2015
 * @since JDK 8
 * @version 1.0
 * 
 */

Table table;

ArrayList<Species> species;

String input;
boolean inputted;

StringList genus_list;

int [] stringPosition;

IntList cluster;

color black = color(0);
color white = color(255);
color grey = color(100);
color red = color(255, 0, 0);
color green = color(0, 255, 0);
color blue = color(0, 0, 255);
color brown = color(150, 50, 0);
color yellow = color(255, 255, 0);

PImage spinner, crosshair;
boolean loaded;

void settings() {
  size(int(displayWidth / 1.2), int(displayHeight / 1.2));
}

void setup() {
  spinner = loadImage("load_spin.png");

  species = new ArrayList<Species>();

  input = "";

  stringPosition = new int [0];
  cluster = new IntList();

  thread("loadData");
}

void draw() {
  imageMode(CENTER);
  ellipseMode(CENTER);
  textAlign(CENTER);
  background(black);

  if (!loaded) {
    loadingScreen();
  } else if (!inputted) {
    selectData();
  } else {
    run();
  }
}

void mousePressed() {
  for (int i = 0; i < species.size(); i++) {
    species.get(i).currentMouse = new PVector(mouseX, mouseY);
  }
}

void mouseClicked() {
  for (int i = 0; i < species.size(); i++) {
    species.get(i).clicked();
  }
}

void mouseDragged() {
  for (int i = 0; i < species.size(); i++) {
    species.get(i).dragMouse();
  }
}

void keyPressed() {
  if (key == ENTER) {
    loaded = false;
    loadSearch();
    inputted = true;
  } else if (keyCode != SHIFT) {
    input += key;
  }
}

/** This function is used to display the user's text input at the beginning
 *
 */
void selectData() {
  textSize(40);
  text("Type in the index of your desired Genus:", width / 2, height / 4);
  text(input, width / 2, height / 2);
}

/** This function is used to run the main draw portion of the program
 *
 */
void run() {
  for (int i : cluster) {
    species.get(i).run();
  }
}

/** This function is used to load setup data at the beginning of the program, in a separate thread
 *
 */
void loadData() {
  table = loadTable("taxonomy-search-1398436937824.csv", "header");
  crosshair = loadImage("crosshair.png");

  genus_list = noRepeatSort("Genus");

  int row_count = 0;

  for (TableRow row : table.rows()) {
    if (row.getString("Rank").equals("species")) {
      species.add(new Species(row_count));
    } else {
      species.add(new Subspecies(row_count));
    }

    row_count++;
  }

  loaded = true;
}

/** This function is used to process the input data from the user
 *
 */
void loadSearch() {
  String query = genus_list.get(int(input));

  cluster = columnSearch(query, "Genus");

  for (int i : cluster) {
    append(stringPosition, i);
  }

  loaded = true;
}

/** This function is used to display the loading screen while data is loading or being processing
 *
 */
void loadingScreen() {
  textSize(height / 10);
  fill(white);
  text("Loading Algae Data...", width / 2, height / 5);
  pushMatrix();
  translate(width / 2, height / 2);
  rotate((frameCount / 6) % TWO_PI);
  image(spinner, 0, 0, height / 4, height / 4);
  popMatrix();
}