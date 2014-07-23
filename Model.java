import java.util.ArrayList;
import java.util.Collections;


import org.jfree.chart.ChartFactory;
import org.jfree.chart.JFreeChart;
import org.jfree.data.xy.XYSeries;
import org.jfree.data.xy.XYSeriesCollection;
import org.jfree.chart.ChartPanel;;

public class Model{
	public static ArrayList<Cell> cellarray;
	public static double RA;
	public Model(double amt){
		RA = amt;
	}
	public void setCellarray(int number){
	cellarray = new ArrayList<Cell>();
	for (int a =0; a<number; ++a) {
		propagating e = new propagating(0, true);
		cellarray.add(e);
	}
}
	public ArrayList<Cell> getarray(){
		return cellarray;
	}
public void makemove(double prob){
	int numb = (int) (prob*cellarray.size());
	Collections.shuffle(cellarray);
	for (int b = 0; b<numb; ++b){
		cellarray.get(b).getprobab();
		cellarray.get(b).getphase();
		Cell newcell = cellarray.get(b).cellaction(cellarray.size(), RA);
		if (newcell != null){
			if (newcell.isequal(cellarray.get(b))) {
				cellarray.add(newcell);
			} else if (newcell.getlife()){
				cellarray.set(b, newcell);
			} else {
				cellarray.remove(b);
			}
		}
	}
}
public ChartPanel run(int number, int times,double prob){
	setCellarray(number);
	XYSeriesCollection data = new XYSeriesCollection();
	XYSeries s1 = new XYSeries("Total Population");
	XYSeries s2 = new XYSeries("Propagating Population");
	XYSeries s3 = new XYSeries("Precommittal Population");
	XYSeries s4 = new XYSeries("Terminal Population");
	for (int d=0; d<times; ++d){
		makemove(prob);
		int pop = cellarray.size();
		s1.add(d,pop);
		int a = 0;
		int b = 0;
		int c = 0;
		for (int i = 0; i<pop; ++i){
			//if (cellarray.get(i).getphase()==4){
			//	a = a+1;
			//}
			if (cellarray.get(i) instanceof terminal){
				a=a+1;
			} else if (cellarray.get(i) instanceof propagating){
				b=b+1;
			} else {
				c = c+1;
			}
		}
		s2.add(d,b);
		s3.add(d,c);
		s4.add(d,a);
	}
	data.addSeries(s1);
	data.addSeries(s2);
	data.addSeries(s3);
	data.addSeries(s4);
	String title = "Moves versus Population";
	String xaxis = "Moves";
	String yaxis = "Population";
	JFreeChart chart = ChartFactory.createXYLineChart(title, xaxis, yaxis, data);
	return new ChartPanel(chart);
}

public void changeprobab(double renewal, double death){
	
}
}
