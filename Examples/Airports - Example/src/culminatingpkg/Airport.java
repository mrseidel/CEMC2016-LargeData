package culminatingpkg;

import java.util.ArrayList;

/**
 * This Airports class will be used as a generic outline for what to do when we
 * want to create a profile regarding an airport.
 * 
 * @author M.C.
 * @version 1.0
 * @since JDK 7
 * @since June 2016
 */
public class Airport implements FlightData {
	private int airport_id, red, green, blue, alpha, alpha_incr, radius;
	private String name, city, country, iata, icao, dst;
	private double latitude, longitude, altitude, timezone;
	private SVector fixed_pos, current_pos, pos_incr;
	private ArrayList<Route> routes;

	/**
	 * This constructure is used to construct an airport object
	 * 
	 * @param airport_id
	 *            id of the airport
	 * @param name
	 *            name of the airport
	 * @param city
	 *            city where the airport is located
	 * @param country
	 *            coutry where the airport is located
	 * @param iata
	 *            iata code of the airport
	 * @param icao
	 *            icao code of the airport
	 * @param latitude
	 *            latitude of the airport location
	 * @param longitude
	 *            longitude of the airport location
	 * @param altitude
	 *            altitude of the airport location
	 * @param timezone
	 *            timezone of the area where airport is located
	 * @param dst
	 *            day light saving time of the area where airport is located
	 */
	public Airport(int airport_id, String name, String city, String country, String iata, String icao, double latitude,
			double longitude, double altitude, double timezone, String dst) {
		this.airport_id = airport_id;
		this.name = name;
		this.city = city;
		this.country = country;
		this.iata = iata;
		this.icao = icao;
		this.latitude = latitude;
		this.longitude = longitude;
		this.altitude = altitude;
		this.timezone = timezone;
		this.dst = dst;
		this.red = airport_id % 255;
		this.green = Functions.asciiValueOf(city) % 255;
		this.blue = Functions.asciiValueOf(country) % 255;
		this.alpha = 255;
		this.alpha_incr = Functions.asciiValueOf(dst) % 8;
		routes = new ArrayList<Route>();
	}

	void setColor(int r, int g, int b, int a, int a_increment) {
		this.red = a;
		this.green = g;
		// ...
	}

	/**
	 * This constructor is used to copy and create a new identical airport
	 * 
	 * @param airport
	 *            the airport of which need to be copied
	 */
	public Airport(Airport airport) {
		this.airport_id = airport.getIntInfo("airport_id");
		this.name = airport.getStringInfo("name");
		this.city = airport.getStringInfo("city");
		this.country = airport.getStringInfo("country");
		this.iata = airport.getStringInfo("iata");
		this.icao = airport.getStringInfo("icao");
		this.latitude = airport.getDoubleInfo("latitude");
		this.longitude = airport.getDoubleInfo("longitude");
		this.altitude = airport.getDoubleInfo("altitude");
		this.timezone = airport.getDoubleInfo("timezone");
		this.dst = airport.getStringInfo("dst");
		this.red = airport.getIntInfo("red");
		this.green = airport.getIntInfo("green");
		this.blue = airport.getIntInfo("blue");
		this.alpha = airport.getIntInfo("alpha");
		this.alpha_incr = airport.getIntInfo("alpha_incr");
		routes = airport.getRoutes();
	}

	/**
	 * This function returns the String value of a specific characteristic of
	 * the airports.
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
		case ("city"):
			return city;
		case ("country"):
			return country;
		case ("iata"):
			return iata;
		case ("icao"):
			return icao;
		case ("dst"):
			return dst;
		}
		return "Invalid info type";
	}

	/**
	 * This function returns the integer value of a specific characteristic of
	 * the airport.
	 * 
	 * @param info
	 *            the characteristic needed to be returned
	 * @return the value of the characteristic asked as an int or -1 if invalid
	 *         info type is asked
	 */
	public int getIntInfo(String info) {
		info = info.toLowerCase();
		switch (info) {
		case ("airport_id"):
			return airport_id;
		case ("red"):
			return red;
		case ("green"):
			return green;
		case ("blue"):
			return blue;
		case ("alpha"):
			return alpha;
		case ("alpha_incr"):
			return alpha_incr;
		}
		return -1;
	}

	/**
	 * This function returns the double value of a specific characteristic of
	 * the airport.
	 * 
	 * @param info
	 *            the characteristic needed to be returned
	 * @return the value of the characteristic asked as a double or -1.0 if
	 *         invalid info type is asked
	 */
	public double getDoubleInfo(String info) {
		info = info.toLowerCase();
		switch (info) {
		case ("latitude"):
			return latitude;
		case ("longitude"):
			return longitude;
		case ("altitude"):
			return altitude;
		case ("timezone"):
			return timezone;
		}
		return -1.0;
	}

	/**
	 * This function adds the route that has the corresponding source airport to
	 * the ArrayList of routes
	 * 
	 * @param route
	 *            the routes that needs to be added
	 */
	public void addRoute(Route route) {
		routes.add(route);
	}

	/**
	 * This function returns the ArrayList of routes that this airport associate
	 * to (being a source airport)
	 * 
	 * @return the ArrayList of routes this airport serves as a source airport
	 *         (as an ArrayList<Route>)
	 */
	public ArrayList<Route> getRoutes() {
		return routes;
	}

	/**
	 * This function increases or decreases the alpha value based on the
	 * increment value
	 */
	public void changeAlpha() {
		if (alpha + alpha_incr < 0 || alpha + alpha_incr > 255) {
			alpha_incr *= -1;
		}
		alpha += alpha_incr;

	}

	/**
	 * This function initializes the position vector and radius of the
	 * destination airport circle that will be drawn
	 * 
	 * @param x
	 *            x value of the position of the destination airport
	 * @param y
	 *            Y value of the position of the destination airport
	 * @param r
	 *            radius value of the position of the destination airport
	 * @param des_x
	 *            x value of the position of the source airport
	 * @param des_y
	 *            y value of the position of the source airport
	 * @param incr_ratio
	 *            one of the dividence used to calculate the magnitude of the
	 *            increment of position
	 */
	public void initialize(double x, double y, int r, double des_x, double des_y, double incr_ratio) {
		this.fixed_pos = new SVector(x, y);
		this.current_pos = new SVector(x, y);
		this.pos_incr = new SVector(des_x - x, des_y - y);
		pos_incr.div(300 * incr_ratio);
		this.radius = r;
	}

	/**
	 * This function initializes the position vector and radius of the source
	 * airport circle that will be drawn
	 * 
	 * @param x
	 *            x value of the position of the airport
	 * @param y
	 *            Y value of the position of the airport
	 * @param r
	 *            radius value of the position of the airport
	 */
	public void initialize(double x, double y, int r) {
		this.fixed_pos = new SVector(x, y);
		this.current_pos = new SVector(x, y);
		this.radius = r;
	}

	/**
	 * This function updates the position of the airport
	 * 
	 * @param source_airport_pos
	 *            the position vector of the source airport
	 */
	public void changePos(SVector source_airport_pos) {
		SVector next_pos = new SVector(current_pos.getX() + pos_incr.getX(), current_pos.getY() + pos_incr.getY());
		if ((next_pos.dist(fixed_pos) > source_airport_pos.dist(fixed_pos))
				|| (next_pos.dist(source_airport_pos) > source_airport_pos.dist(fixed_pos))) {
			pos_incr.mult(-1);
		}
		current_pos.setX(next_pos.getX());
		current_pos.setY(next_pos.getY());
	}

	/**
	 * This function returns the position vector of the airport
	 * 
	 * @return the position of the airport (as a SVector)
	 */
	public SVector getPos() {
		return current_pos;
	}

	/**
	 * This function returns the radius of the airport
	 * 
	 * @return the radius of the airport (as an integer)
	 */
	public int getRadius() {
		return radius;
	}

}
