
public class terminal extends Cell{
	private boolean life;
	private double deathp = .1;
	private final int stage = 3;
	public terminal(boolean l) {
		super();
		life = l;
	}
	public Cell cellaction(int pop, double RA) {
		if (pop<maxpop){
			double r = (Math.random());
					//*(1-pop/maxpop);
		if (r<=(deathp)){
			Cell e = new terminal(false);
			return e;
		} else {
			return null;
		}
		} else {
			Cell e = new terminal(false);
			return e;
		}
	}
	public boolean getlife(){
		return life;
	}
	public int getstage(){
		return this.stage;
	}
	public boolean isequal(Cell c){
		if ((this.life == c.getlife()) && (this.stage==c.getstage())){
			return true;
		} else {
			return false;
		}
	}
	public double getdeath(){
		return deathp;
	}
	public void setdeath(double dp){
		deathp = dp;
	}
}
