package culminatingpkg;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Shape;
import java.awt.Toolkit;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.geom.Ellipse2D;
import java.util.ArrayList;
import javax.swing.*;

/**
 * This AirroutesView class will be used as a generic outline for what to do
 * when we want to create a view where to draw.
 * 
 * @author M.C.
 * @version 1.0
 * @since JDK 7
 * @since May 2016
 */
public class AirroutesView extends JFrame implements ActionListener {
	private DrawBoard canvas = new DrawBoard();
	private JComboBox airports_list = new JComboBox();
	private JCheckBox fill_circle_check = new JCheckBox("Fill circles");
	private JButton refresh_button = new JButton("Refresh, mate");
	private JLabel label1 = new JLabel();
	private Timer alpha_timer;
	private ArrayList<FlightData> airports;
	private ArrayList<Route> routes;
	private Airport selected_airport;
	private String selected_airport_name;

	/**
	 * This constructor is used to construct GUI object used to display all the
	 * visual representation
	 * 
	 * @param airports
	 *            an array list of all source airports which contain the routes
	 *            they associate with
	 */
	AirroutesView(ArrayList<FlightData> airports) {
		setLayout(new BorderLayout());
		this.airports = airports;
		// set-up for frame
		setTitle("Flights Info Visual Presentation");
		Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize();
		setSize((int) (screenSize.getWidth() * 0.95),
				(int) (screenSize.getHeight() * 0.95));
		this.setVisible(true);
		setDefaultCloseOperation(EXIT_ON_CLOSE);

		// create a JComboBox that includes all airports
		for (int i = 0; i < airports.size(); i++) {
			airports_list.addItem(airports.get(i).getStringInfo("name"));
		}
		airports_list.setSelectedIndex(0);
		selected_airport_name = airports.get(0).getStringInfo("name");
		refresh(0);
		airports_list.addActionListener(this);
		airports_list.setFont(new Font("Calibri", Font.BOLD, 16));

		// create refresh button
		refresh_button.addActionListener(this);

		// create message label
		label1 = new JLabel();

		// create timer for alpha value changes
		alpha_timer = new Timer(2, this);
		alpha_timer.start();

		// create panel
		JPanel airPanel = new JPanel();
		airPanel.add(airports_list);
		airPanel.add(label1);
		airPanel.add(refresh_button);
		airPanel.add(fill_circle_check);
		this.add(airPanel, BorderLayout.NORTH);
		this.add(canvas, BorderLayout.CENTER);

	}

	/**
	 * This function is run when an event is triggered.
	 * 
	 */
	public void actionPerformed(ActionEvent e) {
		if (e.getSource() == alpha_timer) {
			selected_airport.changeAlpha();
			for (int i = 0; i < routes.size(); i++) {
				routes.get(i).getDesAirport()
						.changePos(selected_airport.getPos());
			}
			repaint();
		}
		if (e.getSource() == airports_list) {
			JComboBox cb = (JComboBox) e.getSource();
			selected_airport_name = (String) cb.getSelectedItem();
		}
		if (e.getSource() == refresh_button) {
			int index = Functions.binarySearch(airports, "name",
					selected_airport_name);
			refresh(index);
			repaint();
		}
	}

	/**
	 * This function reinitialize the drawing canvas and reinitialize the data
	 * need to be drawn
	 * 
	 * @param index
	 *            the index of the selected airport in the sorted array list of
	 *            source airports
	 */
	public void refresh(int index) {
		selected_airport = (Airport) airports.get(index);
		double x_pos = (180 + selected_airport.getDoubleInfo("longitude"))
				/ 360 * canvas.getWidth();
		double y_pos = canvas.getHeight()
				- ((90 + selected_airport.getDoubleInfo("latitude")) / 180 * canvas
						.getHeight());
		double radius = 13 + selected_airport.getDoubleInfo("timezone");
		if (radius > 25) {
			radius = 25.0;
		}
		selected_airport.initialize((x_pos), y_pos, (int) radius);

		routes = new ArrayList<Route>(selected_airport.getRoutes());
		for (int i = 0; i < routes.size(); i++) {
			x_pos = (180 + routes.get(i).getDesAirport()
					.getDoubleInfo("longitude"))
					/ 360 * canvas.getWidth();
			y_pos = canvas.getHeight()
					- ((90 + routes.get(i).getDesAirport()
							.getDoubleInfo("latitude")) / 180 * canvas
							.getHeight());
			radius = 13 + routes.get(i).getDesAirport()
					.getDoubleInfo("timezone");
			if (radius > 25) {
				radius = 25.0;
			}
			routes.get(i)
					.getDesAirport()
					.initialize(x_pos, y_pos, (int) radius,
							selected_airport.getPos().getX(),
							selected_airport.getPos().getY(),
							routes.get(i).getIntInfo("stops") + 1);
		}
	}

	/**
	 * This inner class is used generate a JPanel canvas to draw the visualized
	 * data of flight data
	 * 
	 * @author Michael D. Cai
	 * @version 1.0
	 * @since JDK 7
	 * @since June 2016
	 */
	public class DrawBoard extends JPanel {

		@Override
		public void paintComponent(Graphics g) {
			g.setColor(Color.BLACK);
			g.fillRect(0, 0, getWidth(), getHeight());
			label1.setText("Number of routes: " + String.valueOf(routes.size()));
			for (int i = 0; i < routes.size(); i++) {
				draw(routes.get(i), g);
			}
			draw(selected_airport, g);
		}

		/**
		 * This function draws the airport according to its data value
		 * 
		 * @param the_airport
		 *            the airport needs to be drawn
		 * @param g
		 *            the Graphics object where the data are to be drawn
		 */
		public void draw(Airport the_airport, Graphics g) {
			g.setColor(new Color(the_airport.getIntInfo("red"), the_airport
					.getIntInfo("green"), the_airport.getIntInfo("blue"),
					the_airport.getIntInfo("alpha")));

			if (fill_circle_check.isSelected()) {
				g.fillOval(
						(int) the_airport.getPos().getX()
								- the_airport.getRadius(), (int) the_airport
								.getPos().getY() - the_airport.getRadius(),
						the_airport.getRadius() * 2,
						the_airport.getRadius() * 2);
			} else {
				Graphics2D g2d = (Graphics2D) g;
				Shape airport_circle = new Ellipse2D.Double((int) the_airport
						.getPos().getX() - the_airport.getRadius(),
						(int) the_airport.getPos().getY()
								- the_airport.getRadius(),
						the_airport.getRadius() * 2,
						the_airport.getRadius() * 2);
				g2d.draw(airport_circle);
			}
		}

		/**
		 * This function draws the line/route that connects the source and
		 * destination airport according to its data value
		 * 
		 * @param the_route
		 *            the route needs to be drawn
		 * @param g
		 *            the Graphics object where the data are to be drawn
		 */
		public void draw(Route the_route, Graphics g) {
			g.setColor(the_route.getAirline().getColour());
			g.drawLine((int) selected_airport.getPos().getX(),
					(int) selected_airport.getPos().getY(), (int) the_route
							.getDesAirport().getPos().getX(), (int) the_route
							.getDesAirport().getPos().getY());
			draw(the_route.getDesAirport(), g);
		}
	}

}
