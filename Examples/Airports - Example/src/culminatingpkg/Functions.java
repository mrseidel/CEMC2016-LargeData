package culminatingpkg;

import java.util.ArrayList;

/**
 * This class is used to store all the functions needed for this program
 * 
 * @author M.C.
 * @version 1.0
 * @since JDK 7
 * @since June 2016
 */
public class Functions {

	/**
	 * This function returns the sum of the ASCII value of each characters in
	 * the input string
	 * 
	 * @param input_string
	 *            the string of which you want the ASCII value of
	 * @return the sum of ASCII value of each character in the input string (as
	 *         an int)
	 */
	public static int asciiValueOf(String input_string) {
		if(input_string.length()<1){
			return 0;
		}
		if (input_string.length() < 2) {
			return (int) input_string.charAt(0);
		}
		return (int) input_string.charAt(0) + asciiValueOf(input_string.substring(1, input_string.length()));
	}

	/**
	 * This function returns the index value of an airport, airline or route
	 * that has a specific value stored in a specific variable in a sorted
	 * ArrayList of FlightData. It uses binary search algorithm.
	 * 
	 * @param array
	 *            input array that contains the object to be searched
	 * @param value_type
	 *            type of value used to compare when searching: any of the
	 *            String variable used in the object
	 * @param key_value
	 *            the specified value you want to search for
	 * @return the index value (as an integer) of the an airport, airline, or
	 *         route that has the specified value
	 */
	public static int binarySearch(ArrayList<FlightData> array, String value_type, String key_value) {
		int maximum = array.size();
		int minimum = 0;
		int middle;
		while (minimum < maximum) {
			middle = (int) Math.floor((maximum + minimum) / 2);
			if (array.get(middle).getStringInfo(value_type).compareTo(key_value) < 0) {
				minimum = middle + 1;
			} else {
				maximum = middle;
			}
		}
		if (minimum == maximum && array.get(minimum).getStringInfo(value_type).equals(key_value)) {
			return minimum;
		} else {
			return -1;
		}
	}
}
