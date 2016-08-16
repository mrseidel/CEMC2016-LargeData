package culminatingpkg;

/**
 * This Routes class will be used as a generic outline for what to do when we
 * want to create a profile regarding a flight route.
 * 
 * @author M.C.
 * @version 1.0
 * @since JDK 7
 * @since May 2016
 */
public class Route implements FlightData {
	private String source_airport, source_airport_id, codeshare, equipment;
	private int stops;
	private Airport destination_airport;
	private Airline airline;

	/**
	 * This constructor is used to construct a route object
	 * 
	 * @param airline
	 *            airline that uses this route
	 * @param source_airport
	 *            source airport name of the route
	 * @param source_airport_id
	 *            source airport id of the route
	 * @param codeshare
	 *            whether the route is operated by the airline (Y if route is
	 *            operated by another carrier, left blank if no)
	 * @param stops
	 *            number of stops of the route
	 * @param equipment
	 *            equipment (aircrafts) usually used on the route
	 * @param destination_airport
	 *            destination airport of the route
	 */
	public Route(Airline airline, String source_airport, String source_airport_id, String codeshare, int stops,
			String equipment, Airport destination_airport) {
		this.airline = airline;
		this.source_airport = source_airport;
		this.source_airport_id = source_airport_id;
		this.codeshare = codeshare;
		this.stops = stops;
		this.equipment = equipment;
		this.destination_airport = destination_airport;
	}

	/**
	 * This function returns the String value of a specific characteristic of
	 * the route.
	 * 
	 * @param info
	 *            the characteristic needed to be returned
	 * @return the value of the characteristic asked as a String or
	 *         "Invalid info type" if input characteristic is invalid
	 */
	public String getStringInfo(String info) {
		info = info.toLowerCase();
		switch (info) {
		case ("source_airport"):
			return source_airport;
		case ("source_airport_id"):
			return source_airport_id;
		case ("codeshare"):
			return codeshare;
		case ("equipment"):
			return equipment;
		}
		return "Invalid info type";
	}

	/**
	 * This function returns the integer value of a specific characteristic of
	 * the route.
	 * 
	 * @param info
	 *            the characteristic needed to be returned
	 * @return the value of the characteristic asked as an int or -1 if invalid
	 *         info type is asked
	 */
	public int getIntInfo(String info) {
		info = info.toLowerCase();
		switch (info) {
		case ("stops"):
			return stops;
		}
		return -1;
	}

	/**
	 * This function returns the destination airport of the route
	 * 
	 * @return the destination airport of the route as an Airports
	 */
	public Airport getDesAirport() {
		return destination_airport;
	}

	/**
	 * This function returns the airline that uses the route
	 * 
	 * @return the airline that uses the route as an Airlines
	 */
	public Airline getAirline() {
		return airline;
	}

}
