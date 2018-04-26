import java.util.*;

class ReplacementRule{
  //LinkedList<Agent> marked = new LinkedList<Agent>();
  //LinkedList<Integer> lifespan = new LinkedList<Integer>();
  HashMap<Agent, Integer> agentsAndAge = new HashMap<Agent, Integer>();
  private int minAge;
  private int maxAge;
  private AgentFactory fac;
  
  public ReplacementRule(int minAge, int maxAge, AgentFactory fac){
    this.minAge = minAge;
    this.maxAge = maxAge;
    this.fac = fac;
  }
  
  public boolean replaceThisOne(Agent a){
    int deathAge;
    
    if(a.isAlive() == true){
        if(agentsAndAge.containsKey(a) == true){
          deathAge = agentsAndAge.get(a);
          if(a.getAge() <= deathAge){
            return false;
          }
          if(a.getAge() > deathAge){
            a.setAge(maxAge+1);
            return true;
          } 
        }
        if(agentsAndAge.containsKey(a) == false){
          deathAge = (int)random(minAge, maxAge+1);
          agentsAndAge.put(a, deathAge);
          return false;
        }
      }  
    
    //if an agent is not alive, replace it
    return true;
  }
  
  public Agent replace(Agent a, List<Agent> others){
    return fac.makeAgent();
  }
  
}
