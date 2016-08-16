package culminatingpkg;

/**
 * This interface contains methods that return the basic information of the
 * object that implements this interface of the objects. It is also used to be
 * able create an ArrayList of different classes of objects when reading a file.
 * 
 * @author M.C.
 * @version 1.0
 * @since JDK 7
 * @since May 2016
 */
public interface FlightData {
	public String getStringInfo(String info);

	public int getIntInfo(String info);
}
