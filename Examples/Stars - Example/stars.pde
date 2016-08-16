/**
 * This class contains stars and their information.
 * 
 * @author H.T.
 * @version 1.0
 * @since JDK 1.7.0_25
 * @since Nov 28th, 2013
 */

/**
 * @param   x           x coordinate for the individual star
 * @param   y           y coordinate for the individual star
 * @param   z           z coordinate for the individual star
 * @param   num1        Henry Draper number for the individual star
 * @param   num2        Harvard Revised number for the individual star
 * @param   brightness  the magnitude (brightness) of the individual star
 * @param   name1       name #1 for the individual star
 * @param   name2       name #2 for the individual star
 * @param   name3       name #3 for the individual star
 */
public class Stars extends celestialobjects {
  float num1;
  float num2;
  float brightness;
  String name1;
  String name2;
  String name3;
  public Stars(float x, float y, float z, float num1, float brightness, float num2, String name1, String name2, String name3) {
    super(x, y, z);
    this.num1 = num1;
    this.brightness = brightness;
    this.num2 = num2;
    this.name1 = name1;
    this.name2 = name2;
    this.name3 = name3;
  }
}

