/**
 * This class is the Athletes class and extends to the country class
 *
 * 
 */


public class Athletes extends Country {

  color col;
  String info;
  String[] holder;

  /**
   * This constructor that creates country
   *
   *@param _nameOfCountry name of the coutry
   *@param _x starting x value
   *@param _y starting y value
   *@param b1 first boundary
   *@param _r radius of turn
   **/
  Athletes(String _nameOfCountry, float _x, float _y, float b1, float _r) {
    super ( _nameOfCountry, _x, _y, b1, _r);
  }

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
  Athletes(String _nameOfCountry, float _x, float _y, float b1, float _r, color col_) {
    super ( _nameOfCountry, _x, _y, b1, _r);
    col=col_;
    holder=new String[10];
    info="";
  }


  /**
   * This function displays all information
   **/
  void display() {
    strokeWeight(1);
    fill(col);
    ellipse(position.x, position.y, circleRadius, circleRadius);

    move();
    drawName();
  }

  /**
   * This function displays the name
   **/
  void drawName() {
    if (dist(mouseX, mouseY, position.x, position.y)<=circleRadius/2) {
      strokeWeight(5);
      fill(0);
      text(nameOfCountry, width/2, height/2+100);
      displayInformation();
    }
  }

  /**
   * This function displays all personal information
   **/
  void displayInformation() {

    for (int i=0; i<infoByName.size (); i++) {
      if (infoByName.get(i).indexOf(nameOfCountry)>=0) {
        holder=split(infoByName.get(i), ";");

        info="Date: "+holder[3]+" Gender: "+holder[4]+" Sport: "+holder[5];
        break;
      }
    }
    text(info, width/2, height/2+150);
  }
}

