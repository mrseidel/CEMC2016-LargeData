/**
 * This class creates the Actors and associates a name, number of movies per actor
 * and a bubble per Actor object
 */

class Actor {

  String name;
  float numberOfMovies;
  Bubbles bubby;
//  Attractor attract;


  Actor(String name, int numberOfMovies, Bubbles bubby) { // constructor for the class
    this.name = name;
    this.numberOfMovies = numberOfMovies;
    this.bubby = bubby;
   // this.attract = attract;
  }
  /**
   * This function increases the number of movies
   */
  void increaseNumberOfMovies() { 
    numberOfMovies++;
  }
  /**
   * This function returns the number of movies value
   *
   * @return number of movies per actor
   */

  float movieCount() {
    return numberOfMovies;
  }
  /** 
   * This function displays the bubble of the Actor and updates the radius
   */

  void display(float radius) {
    bubby.display(radius);
  }
  /**
   * This function allows the movement of the bubbles
   */

  void update() {
    bubby.movement();
  }

  /** 
   * This function gives the bubble a new location
   */
  void order(int xnew) {
    bubby.order(xnew);
  }
  /**
   * This function changes the colour of the bubble 
   */
  void changeFill(color newC){
    bubby.changeFill(newC);
  }
}

