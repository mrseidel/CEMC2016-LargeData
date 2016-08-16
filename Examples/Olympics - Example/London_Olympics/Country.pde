public class Country {
  Boolean goingLeft;
  String nameOfCountry, code;
  String[] fullinfo = new String[2];
  PVector position;
  float xBound1, xBound2;
  float radius; //used for turns
  float circleRadius;//for small circle
  float moveX, moveY, yPos, preMoveY;
  float turn1, turn2;
  color col;
  PImage flag;
  String [] countryHolder;
  boolean clicked;
  String countryInfo;

  /**
   * This constructor that creates country
   *
   *@param _nameOfCountry name of athlete
   *@param _x starting x value
   *@param _y starting y value
   *@param b1 first boundary
   *@param _r radius of turn
   *@param col colour of circles
   **/
  Country(String _nameOfCountry, float _x, float _y, float b1, float _r) {
    goingLeft=true;
    countryInfo=_nameOfCountry;
    fullinfo=split(countryInfo, ',');
    nameOfCountry=fullinfo[0];
    nameOfCountry=nameOfCountry.substring(0, nameOfCountry.length()-1);
    code=fullinfo[1];
    countryHolder = new String [split(nameOfCountry, " ").length];
    countryHolder=split(nameOfCountry, " ");
    code=code.substring(1, 4);
    position=new PVector (_x-2000, _y);
    radius=_r;
    yPos=_y;
    xBound1=b1-radius;
    xBound2=_x+radius;
    moveX=1;
    moveY=0;
    turn1=b1;
    turn2=_x;
    preMoveY=0;
    col=color(random(0, 255), random(0, 255), random(0, 255));
    circleRadius=30;
    clicked=false;
  } 
  /**
   * This function displays all information
   **/
  void display() {
    strokeWeight(1);
    fill(col);

    ellipse(position.x, position.y, circleRadius, circleRadius);

    move();
    textDisplay();
    mouseHover();
  }
  /**
   * This function moves the circle
   **/
  void move() {
    position.x-=moveX;
    if (position.x<=xBound1 || position.x>=xBound2) {
      moveX*=-1;
      goingLeft=!goingLeft;
    }

    if (position.x<=turn1) {
      moveY=radius-sqrt(sq(radius)-sq(position.x-turn1));

      if (goingLeft==true) {
        position.y=yPos-moveY;
      } else {
        position.y=yPos+moveY-radius*2;
      }
    }
    if (position.x>=turn2) {
      moveY=radius-sqrt(sq(radius)-sq(position.x-turn2));

      if (goingLeft==false) {
        position.y=yPos+moveY-radius*2;
      } else {
        position.y=yPos-moveY;
      }
    }
  }
  
  /**
   * This function displays text
   **/
  void textDisplay() {
    strokeWeight(2);
    fill(0);
    textAlign(CENTER, CENTER);
    text(code, position.x, position.y);
  }

  /**
   * This function checks if the mouse if over the ball
   **/
  private void mouseHover() {
    if (dist(mouseX, mouseY, position.x, position.y)<=circleRadius/2) {

      drawFlag(width/2, height/2, true);
      if (mousePressed && mouseButton==LEFT) {
        clicked=true;
      }
    } else {
      flag=null;
    }
  }
  
  /**
   * This function displays the flag
   *
   *@param tempX temporary x position
   *@param tempY temporary y poistion
   *@showName used to decide whether or not to show name
   **/
  void drawFlag(float tempX, float tempY, boolean showName) {

    if (showName==true) {
      strokeWeight(5);
      fill(0);
      text(nameOfCountry, tempX, tempY);
    }
    if (flag == null) {
      flag=loadImage("Data\\Country Flags File\\"+JoinArray(countryHolder, "_")+".png");
    }
    imageMode(CENTER);
    image(flag, tempX, tempY+50);
  }

  /**
   * This is the getter function of the name of country
   **/
  String nameOfCountry() {
    return nameOfCountry;
  }

  /**
   * This is the getter function of colour
   **/
  color colour() {
    return col;
  }

  /**
   * This is the getter function whether or not a circle has been clicked
   **/
  boolean clicked() {
    return clicked;
  }
    /**
   * This is the setter function for set clicked as false
   **/
  public void setFalse() {
    clicked=false;
  }

  /**
   * This is the getter function of position
   **/
  PVector position() {
    return position;
  }
}

