import java.awt.BorderLayout;

import javax.swing.JFrame;
import javax.swing.JPanel;

import org.jfree.chart.ChartPanel;


public class Test {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		int length = 200;
		double prob = .25;
		int times = 1000;
		Model m1 = new Model(0.15);
	    ChartPanel chart1 = m1.run(length,times,prob);
		chart1.setDomainZoomable(true);
		JPanel jpanel1 = new JPanel();
		jpanel1.setLayout(new BorderLayout());
		jpanel1.add(chart1, BorderLayout.CENTER);
		JFrame frame = new JFrame();
		frame.add(jpanel1);
		frame.pack();
		frame.setVisible(true);
	}

}
