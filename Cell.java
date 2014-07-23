
public class Cell{
	public static int population;
	public final int maxpop = 20000;
	public final double RAmin = 0.1;
	public Cell() {
		popadd();
	}
	public void stagechange() {
		
	}
	public int popcount() {
		return population;
	}
	public void popadd() {
		++population;
	}
	public void popsub() {
		--population;
	}
	public double getprobab() {
		return 0;
	}
	public void setprobab(double rp) {
		
	}
	public int getphase(){
		return 5;
	}
	public Cell cellaction(int pop, double RA) {
		return null;
	}
	public boolean getlife(){
		return false;
	}
	public boolean isequal(Cell c){
		return true;
	}
	public int getstage(){
		return 0;
	}
	public double getdeath(){
		return 0;
	}
	public void setdeath(double dp){
		
	}
}
