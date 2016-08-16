/**
 *This file is for the species and subspecies classes
 *
 * @author F.D.
 * @since January 21st, 2015
 * @since JDK 8
 * @version 1.0
 * 
 */
class Species {

  float x, y, size;
  boolean selected;
  PVector currentMouse, speed;

  int index;

  String name;
  String author;
  String epithet;
  String kingdom;
  String phylum;
  String class_variable;
  String order;
  String family;
  String genus;
  String species;
  String id;
  String accepted;

  /**
   * This is the default constructor. It uses default Species(int) constructor to generate a default species at
   * (width / 2, height / 2).
   * 
   */
  Species(int index_) {
    index = index_;
    size = height / 80;

    x = width / 2;
    y = height / 2;

    currentMouse = new PVector(mouseX, mouseY);
    speed = new PVector(random(-1, 1), random(-1, 1));

    name = table.getRow(index).getString("Scientific name");
    author = table.getRow(index).getString("Author");
    epithet = table.getRow(index).getString("Specific epithet");
    kingdom = table.getRow(index).getString("Kingdom");
    phylum = table.getRow(index).getString("Phylum");
    class_variable = table.getRow(index).getString("Class");
    order = table.getRow(index).getString("Order");
    family = table.getRow(index).getString("Family");
    genus = table.getRow(index).getString("Genus");
    species = table.getRow(index).getString("Species");
    id = table.getRow(index).getString("IABIN ID");
    accepted = table.getRow(index).getString("Accepted");
  }

  /** This function is used to call the other functions within the Species class
   *
   */
  void run() {
    display();
    update();
    checkEdges();
    dragMouse();
  }

  /** This function is used to draw the species onto the screen
   *
   */
  void display() {
    strokeWeight(size / 10);
    stroke(grey);
    if (mouseX >= x - size / 2 && mouseX <= x + size / 2 && mouseY >= y - size / 2 && mouseY <= y + size / 2) {
      fill(white);
    } else {
      fill(brown);
    }
    ellipse(x, y, size, size);

    if (selected) {
      image(crosshair, x, y, size * 4, size * 4);
    }

    textSize(size);   
    fill(white);
    text(name, x, y - size / 2);
  }

  /** This function is used to update the species' movements
   *
   */
  void update() {
    x += speed.x;
    y += speed.y;
  }

  /** This function is used to check the species' boundaries and reflect them once they hit a wall
   *
   */
  void checkEdges() {
    if (x > width || x < 0) {
      speed.x *= -1;
    }    
    if (y > height || y < 0) {
      speed.y *= -1;
    }
  }

  /** This function is used to select the Species upon a mouse click
   *
   */
  void clicked() {
    if (mouseX >= x - size / 2 && mouseX <= x + size / 2 && mouseY >= y - size / 2 && mouseY <= y + size / 2) {
      selected = true;
    } else {
      selected = false;
    }
  }

  /** This function is used to drag the species' position
   *
   */
  void dragMouse() {
    if (mousePressed) {
      if (selected) {
        x += mouseX - currentMouse.x;
        y += mouseY - currentMouse.y;
        currentMouse = new PVector(mouseX, mouseY);
      }
    }
  }
}

class Subspecies extends Species {

  /**
   * This is the default constructor. It inherits the default Species(int) constructor to generate a default subspecies at
   * (width / 2, height / 2).
   * 
   */
  Subspecies(int index_) {
    super(index_);
  }

  /** This function is used to draw the subspecies onto the screen
   *
   */
  void display() {
    strokeWeight(size / 10);
    stroke(grey);
    if (mouseX >= x - size / 2 && mouseX <= x + size / 2 && mouseY >= y - size / 2 && mouseY <= y + size / 2) {
      fill(white);
    } else {
      fill(yellow);
    }
    ellipse(x, y, size, size);

    if (selected) {
      image(crosshair, x, y, size * 4, size * 4);
    }

    textSize(size);   
    fill(white);
    text(name, x, y - size / 2);
  }
}