class PollutionRule{
  
  private int gatheringPollution;
  private int eatingPollution;
  
  public PollutionRule(int gatheringPollution, int eatingPollution){
    this.gatheringPollution = gatheringPollution;
    this.eatingPollution = eatingPollution;
  }
  
  public void pollute(Square s){
    //if there is currently an agent on s
    if(s.getAgent() != null){
      Agent a = s.getAgent();
      s.setPollution((this.eatingPollution * a.getMetabolism()) + (this.gatheringPollution * s.getSugar()));
    }
  }
  
  
  
}