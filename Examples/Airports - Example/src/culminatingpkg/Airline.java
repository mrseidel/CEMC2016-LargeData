package culminatingpkg;

import java.awt.Color;

/**
 * This Airlines class will be used as a generic outline for what to do when we
 * want to create a profile regarding an airline.
 * 
 * @author M.C.
 * @version 1.0
 * @since JDK 7
 * @since May 2016
 */
public class Airline implements FlightData {
	private int airline_id;
	private Color colour;
	private String name, alias, iata, icao, country, active;

	/**
	 * This constructor is used to construct an airline
	 * 
	 * @param airline_id
	 *            id of the airline
	 * @param name
	 *            name of the airline
	 * @param alias
	 *            alias of the airline
	 * @param iata
	 *            iata code name of the airline
	 * @param icao
	 *            icao code name of the airline
	 * @param callsign
	 *            callsign of the airline
	 * @param country
	 *            country where the airline headquarter is located
	 * @param active
	 *            whether if the airline is active (Y for yes, and left blank
	 *            for no)
	 */
	public Airline(int airline_id, String name, String alias, String iata, String icao, String callsign, String country,
			String active) {
		this.airline_id = airline_id;
		this.name = name;
		this.alias = alias;
		this.iata = iata;
		this.icao = icao;
		this.country = country;
		this.active = active;
		if (airline_id<0){
			airline_id=255;
		}
		this.colour = (new Color(airline_id%255, Functions.asciiValueOf(name)%255,
				Functions.asciiValueOf(iata + icao)%255));
	}

	/**
	 * This function returns the String value of a specific characteristic of
	 * the airline.
	 * 
	 * @param info
	 *            the characteristic needed to be returned
	 * @return the value of the characteristic asked as a String or
	 *         "Invalid info type" if input characteristic is invalid
	 */
	public String getStringInfo(String info) {
		info = info.toLowerCase();
		switch (info) {
		case ("name"):
			return name;
		case ("alias"):
			return alias;
		case ("iata"):
			return iata;
		case ("icao"):
			return icao;
		case ("country"):
			return country;
		case ("active"):
			return active;
		}
		return "Invalid info type";
	}

	/**
	 * This function returns the integer value of a specific characteristic of
	 * the airline.
	 * 
	 * @param info
	 *            the characteristic needed to be returned
	 * @return the value of the characteristic asked as an int or -1 if invalid
	 *         info type is asked
	 */
	public int getIntInfo(String info) {
		info = info.toLowerCase();
		switch (info) {
		case ("airline_id"):
			return airline_id;
		}
		return -1;
	}

	/**
	 * This function returns the colour of this specific airline
	 * 
	 * @return colour used to draw the airline route (as a Color)
	 */
	public Color getColour(){
		return colour;
	}
}
