public interface GrowthRule {
  public void growBack(Square s);
}


class GrowbackRule implements GrowthRule{
  /* Initializes a new GrowbackRule with the specified growth rate.
  *
  */
  private int rate;
  
  public GrowbackRule(int rate) {
    this.rate = rate;
  }
  
  /* Increases the sugar in Square s by the growth rate, 
  *  up to the maximum value that can be stored in s. 
  *  Note: you should use only public methods of the Square class. 
  *  The Autograder will provide its own Square class, 
  *  which may not have the private methods or variable names you expect.
  */
  public void growBack(Square s) {
    //increases the sugarLevel by rate once per time you call method
    s.setSugar(this.rate + s.getSugar());
  }
}

class SeasonalGrowbackRule implements GrowthRule {
  
  private int alpha;
  private int beta;
  private int gamma;
  private int equator;
  private int numSquares;
  //1 = northSummer, 0 = southSummer
  private int season;
  //keeps track of the # of times growBack has been called since the last season change
  private int count;
  
  public SeasonalGrowbackRule(int alpha, int beta, int gamma, int equator, int numSquares){
    this.alpha = alpha;
    this.beta = beta;
    this.gamma = gamma;
    this.equator = equator;
    this.numSquares = numSquares;
    //Season is initially set to northSummer (1)
    this.season = 1;
  }
  
  public void growBack(Square s){
    //determines which season a square is currently in
    //summer season
    if((s.getX() >= this.equator && season == 1) || (s.getX() < this.equator && season == 0)){
      s.setSugar(this.alpha + s.getSugar());
    }
    //winter season
    if((s.getX() >= this.equator && season == 0) || (s.getX() < this.equator && season == 1)){
      s.setSugar(this.beta + s.getSugar());
    }
    
    //changes the seasons 
    if(this.season == 1 && count == this.gamma*this.numSquares){
      season = 0;
      count = 0;
    }
    if(this.season == 0 && count == this.gamma*this.numSquares){
      season = 1;
      count = 0;
    } 
    count++;
  }
  
  public boolean isNorthSummer(){
    if(season == 1){
      return true;
    }
    return false;
  }
  
}