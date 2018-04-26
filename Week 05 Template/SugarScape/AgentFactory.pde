import java.util.*;

class AgentFactory{
  
  private int minMetabolism;
  private int maxMetabolism;
  private int minVision;
  private int maxVision;
  private int minInitialSugar;
  private int maxInitialSugar;
  private MovementRule m;
  
  public AgentFactory(int minMetabolism, int maxMetabolism, int minVision, int maxVision, int minInitialSugar, int maxInitialSugar, MovementRule m){
  this.minMetabolism = minMetabolism;
  this.maxMetabolism = maxMetabolism;
  this.minVision = minVision;
  this.maxVision = maxVision;
  this.minInitialSugar = minInitialSugar;
  this.maxInitialSugar = maxInitialSugar;
  this.m = m;
  }
  
  public Agent makeAgent(){
    //randomly selects metabolism, vision, and initialSugar from range provided by agentFactory
    int metabolism = (int)random(minMetabolism, maxMetabolism+1);
    int vision = (int)random(minVision, maxVision+1);
    int initialSugar = (int)random(minInitialSugar, maxInitialSugar+1);
    
    //creates and returns a new agent with these randomly selected parameters
    Agent a = new Agent(metabolism, vision, initialSugar, m);
    return a;
  }
  
}