package culminatingpkg;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.ArrayList;

import javax.swing.*;

/**
 * This is culminating project displays the routes and destination airports of a
 * selected airport in a visual representation
 * 
 * @author M.C.
 * @author Mr. Seidel
 * @since June 2016
 * @since JDK 7
 * @version 1.0
 * 
 */
public class Main extends JFrame {

	public static void main(String[] args) {
		// --------------------------------------------------- Setup Section
		ArrayList<FlightData> airlines = new ArrayList<FlightData>();
		ArrayList<FlightData> airports = new ArrayList<FlightData>();
		ArrayList<FlightData> routes = new ArrayList<FlightData>();
		ArrayList<FlightData> iata_sorted_airports = new ArrayList<FlightData>();
		ArrayList<FlightData> icao_sorted_airports = new ArrayList<FlightData>();
		ArrayList<FlightData> iata_sorted_airlines = new ArrayList<FlightData>();
		ArrayList<FlightData> icao_sorted_airlines = new ArrayList<FlightData>();
		read("data/airlines.dat", fileCountLines("data/airlines.dat"), airlines, iata_sorted_airports,
				icao_sorted_airports, iata_sorted_airlines, icao_sorted_airlines);
		iata_sorted_airlines = new ArrayList<FlightData>(mergeSort(airlines, "iata"));
		icao_sorted_airlines = new ArrayList<FlightData>(mergeSort(airlines, "icao"));
		read("data/airports.dat", fileCountLines("data/airports.dat"), airports, iata_sorted_airports,
				icao_sorted_airports, iata_sorted_airlines, icao_sorted_airlines);
		iata_sorted_airports = new ArrayList<FlightData>(mergeSort(airports, "iata"));
		icao_sorted_airports = new ArrayList<FlightData>(mergeSort(airports, "icao"));
		read("data/routes.dat", fileCountLines("data/routes.dat"), routes, iata_sorted_airports, icao_sorted_airports,
				iata_sorted_airlines, icao_sorted_airlines);
		ArrayList<FlightData> sorted_routes = new ArrayList<FlightData>(mergeSort(routes, "source_airport"));

		// Add routes into each source airports
		mergeSort(airports, "name");
		for (int i = 0; i < routes.size(); i++) {
			Route current_route = (Route) sorted_routes.get(i);
			String source_airport = current_route.getStringInfo("source_airport");
			int airport_index = -1;
			if (source_airport.length() == 3) {
				airport_index = Functions.binarySearch(iata_sorted_airports, "iata", source_airport);
				if (airport_index < 0) {
					continue;
				}
				String source_airport_name = iata_sorted_airports.get(airport_index).getStringInfo("name");
				airport_index = Functions.binarySearch(airports, "name", source_airport_name);
				if (airport_index < 0) {
					continue;
				}
				((Airport) airports.get(airport_index)).addRoute(current_route);
			} else if (source_airport.length() == 4) {
				airport_index = Functions.binarySearch(icao_sorted_airports, "icao", source_airport);
				if (airport_index < 0) {
					continue;
				}
				String source_airport_name = icao_sorted_airports.get(airport_index).getStringInfo("name");
				airport_index = Functions.binarySearch(airports, "name", source_airport_name);
				if (airport_index < 0) {
					continue;
				}
				((Airport) airports.get(airport_index)).addRoute(current_route);
			}
		}

		// --------------------------------------------------- Interaction
		// Section
		AirroutesView theView = new AirroutesView(airports);
		theView.setVisible(true);
		// writes things into file
		try (Writer writer = new BufferedWriter(
				new OutputStreamWriter(new FileOutputStream("filename.txt"), "ISO-8859-1"))) {
			for (int i = 0; i < airports.size(); i++) {
				writer.write(airports.get(i).getStringInfo("name") + "\n");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	/**
	 * This function counts the lines in a file with specified location. It uses
	 * byte counter to do so.
	 * 
	 * @param path
	 *            the location of the file needed to have lines counted
	 * @return the number of lines in the file
	 */
	public static int fileCountLines(String path) {
		try {
			FileInputStream stream = new FileInputStream(path);
			byte[] buffer = new byte[8192];
			int count = 0;
			int n;
			while ((n = stream.read(buffer)) > 0) {
				for (int i = 0; i < n; i++) {
					if (buffer[i] == '\n')
						count++;
				}
			}
			stream.close();
			return count;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	/**
	 * This function reads the file with specified location and creates objects
	 * according to the file. While reading a file, a progress bar will pop up
	 * to demonstrate its progression.
	 * 
	 * @param path
	 *            the location where the file is stored
	 * @param lines
	 *            the number of lines in the file
	 * @param input_array
	 *            the array to be filled with newly created objects: airlines,
	 *            airports, or routes
	 * @param iata_airports
	 *            an array of airports sorted by iata value
	 * @param icao_airports
	 *            an array of airports sorted by icao value
	 */
	public static void read(String path, int lines, ArrayList<FlightData> input_array,
			ArrayList<FlightData> iata_airports, ArrayList<FlightData> icao_airports,
			ArrayList<FlightData> iata_airlines, ArrayList<FlightData> icao_airlines) {
		final JFrame frame = new JFrame();
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.setSize(1000, 100);
		frame.setVisible(true);
		frame.setTitle("Reading file...");
		final DefaultBoundedRangeModel model = new DefaultBoundedRangeModel();
		final JProgressBar progressBar = new JProgressBar(model);
		progressBar.setStringPainted(true);
		frame.add(progressBar);
		progressBar.setValue(0);
		int progressValue = 0;
		Airport temp_airport = null;
		Airline temp_airline = null;
		int airport_index, airline_index;

		// Read file
		try (BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(path), "ISO-8859-1"))) {
			String current_line;
			String data[];
			while ((current_line = br.readLine()) != null) {
				int shift = 0;
				if (path.toLowerCase().indexOf("airlines") >= 0) {
					data = current_line.replaceAll("\"", "").replaceAll("\\\\", "").split(",");
					if (linearSearch(input_array, "name", data[1]) == -1) {
						input_array.add(new Airline(Integer.parseInt(data[0]), data[1], data[2], data[3], data[4],
								data[5], data[6], data[7]));
					}
				} else if (path.toLowerCase().indexOf("airports") >= 0) {
					data = current_line.replaceAll("\"", "").replaceAll("\\\\", "").split(",");
					if (data.length > 11) {
						data[2] += ("," + data[3]);
						shift = 1;
					}
					if (linearSearch(input_array, "name", data[1]) == -1) {
						input_array.add(new Airport(Integer.parseInt(data[0]), data[1], data[2], data[3 + shift],
								data[4 + shift], data[5 + shift], Double.parseDouble(data[6 + shift]),
								Double.parseDouble(data[7 + shift]), Double.parseDouble(data[8 + shift]),
								Double.parseDouble(data[9 + shift]), data[10 + shift]));
					}
				} else if (path.toLowerCase().indexOf("routes") >= 0) {
					if (current_line.substring(current_line.length() - 1, current_line.length()).equals(",")) {
						current_line += " ";
					}
					data = current_line.replaceAll("\"", "").replaceAll("\\\\", "").split(",");

					// create temp_airline
					if (data[0].length() == 2
							&& (airline_index = Functions.binarySearch(iata_airlines, "iata", data[0])) >= 0) {
						temp_airline = (Airline) iata_airlines.get(airline_index);

					} else if (data[0].length() == 3
							&& (airline_index = Functions.binarySearch(icao_airlines, "icao", data[0])) >= 0) {
						temp_airline = (Airline) icao_airlines.get(airline_index);
					}
					// create temp_airport
					if (data[4].length() == 3
							&& (airport_index = Functions.binarySearch(iata_airports, "iata", data[4])) >= 0) {
						temp_airport = new Airport((Airport) iata_airports.get(airport_index));

					} else if (data[4].length() == 4
							&& (airport_index = Functions.binarySearch(icao_airports, "icao", data[4])) >= 0) {
						temp_airport = new Airport((Airport) icao_airports.get(airport_index));
					}
					// create and add new route to arraylist input_array
					if (null != temp_airport && null != temp_airline) {
						input_array.add(new Route(temp_airline, data[2], data[3], data[6], Integer.parseInt(data[7]),
								data[8], temp_airport));
					}
				} else {
					System.out.println("Not acceptable input file");
				}

				// update progress bar
				try {
					progressValue++;
					final int setValue = (int) ((1.0 * progressValue) / (lines * 1.0) * 100.0);

					SwingUtilities.invokeLater(new Runnable() {
						public void run() {
							progressBar.setValue(setValue);
							progressBar.setString("Reading in file... " + setValue + "%");
						}
					});
				} catch (Exception e) {
					e.printStackTrace();
				}

			}

			// closes progress bar window
			try {
				SwingUtilities.invokeLater(new Runnable() {
					public void run() {
						progressBar.setValue(100);
						frame.setVisible(false);
						frame.dispose();
					}
				});
			} catch (Exception e) {
				e.printStackTrace();
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	/**
	 * This function sorts an array of String in ascending order using a merge
	 * sort algorithm
	 * 
	 * @param array
	 *            input array that needs to be sorted
	 * @param key_value
	 *            the value that needs to be in the ascending order (either
	 *            "icao" or "iata")
	 * @return the sorted array according to iata or icao in ascending order as
	 *         an ArrayList of FlightData
	 */
	public static ArrayList<FlightData> mergeSort(ArrayList<FlightData> array, String key_value) {
		if (array.size() > 1) {
			int mid = (int) (array.size() / 2);
			ArrayList<FlightData> left_half = new ArrayList<FlightData>(array.subList(0, mid));
			ArrayList<FlightData> right_half = new ArrayList<FlightData>(array.subList(mid, array.size()));
			mergeSort(left_half, key_value);
			mergeSort(right_half, key_value);
			int i = 0;
			int j = 0;
			int k = 0;

			while (i < left_half.size() && j < right_half.size()) {

				if ((left_half.get(i)).getStringInfo(key_value.toLowerCase())
						.compareTo((right_half.get(j)).getStringInfo(key_value.toLowerCase())) < 0) {
					array.set(k, left_half.get(i));
					i += 1;
				} else {
					array.set(k, right_half.get(j));
					j += 1;
				}

				k += 1;
			}

			while (i < left_half.size()) {
				array.set(k, left_half.get(i));
				i += 1;
				k += 1;
			}

			while (j < right_half.size()) {
				array.set(k, right_half.get(j));
				j += 1;
				k += 1;
			}
		}
		return array;
	}

	/**
	 * This function returns the first index value of an airport, airline or
	 * route that has a specific value stored in a specific variable in an
	 * ArrayList of FlightData. It uses linear search algorithm.
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
	public static int linearSearch(ArrayList<FlightData> array, String value_type, String key_value) {
		for (int i = 0; i < array.size(); i++) {
			if (array.get(i).getStringInfo(value_type).equals(key_value)) {
				return i;
			}
		}
		return -1;
	}

}
