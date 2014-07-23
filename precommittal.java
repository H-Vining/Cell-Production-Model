
public class precommittal extends Cell{
	private int phase;
	private boolean life;
	private static double renewalp=0.55;
	private static double deathp=0.15;
	private final int stage = 2;
	public precommittal(int p, boolean l) {
		super();
		phase = p;
		life = l;
	}
	public Cell cellaction(int pop, double RA) {
		if ((pop<maxpop) && (RA>RAmin)){
			if (this.phase==0){
				double r = (Math.random());
						//*(1-pop/maxpop);
				if (r<=deathp){
					Cell e = new precommittal(0,false);
					return e;
				} else if (r<=(renewalp+deathp)){
					this.changephase();
					return null;
				} else {
					Cell e = new terminal(true);
					return e;
				}
			} else if (this.phase==4){
				this.changephase();
				Cell e = new precommittal(0,true);
				return e;
			} else {
				this.changephase();
				return null;
			}
		} else if (pop>=maxpop){
			Cell e = new precommittal(0,false);
			return e;
		} else {
			if (this.phase==0){
				double r = (Math.random())*(1-pop/maxpop);
				if (r<=renewalp){
					this.changephase();
					return null;
				} else if (r<=(renewalp+deathp)){
					Cell e = new precommittal(0,false);
					return e;
				} else {
					Cell e = new propagating(0,true);
					return e;
				}
			} else if (this.phase==4){
				this.changephase();
				Cell e = new precommittal(0,true);
				return e;
			} else {
				this.changephase();
				return null;
			}
		}
	}
	public double getprobab(){
		return renewalp;
	}
	public int getphase(){
		return phase;
	}
	public void changephase(){
		if (this.phase==4) {
			
			this.phase = 0;
		} else {
			++this.phase;
		}
	}
	public boolean getlife(){
		return life;
	}
	public int getstage(){
		return stage;
	}
	public boolean isequal(Cell c){
		if ((this.stage == c.getstage()) && (this.life == c.getlife()) && (this.phase==c.getphase())) {
			return true;
		} else {
			return false;
		}
	}
	public void setprobab(double rp){
		renewalp = rp;
	}
	public double getdeath(){
		return deathp;
	}
	public void setdeath(double dp){
		deathp = dp;
	}
}
