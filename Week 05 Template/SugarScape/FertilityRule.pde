import java.util.Random;
import java.util.Map;

class FertilityRule {
  
  Map<Character, Integer[]> childbearingOnset;
  Map<Character, Integer[]> climactericOnset;
  
  //List<Agent> seen = new LinkedList<Agent>();
  
  HashMap<Agent, Integer> childBearingAge = new HashMap<Agent, Integer>();
  HashMap<Agent, Integer> climactericAge = new HashMap<Agent, Integer>();
  HashMap<Agent, Integer> sugarLevel = new HashMap<Agent, Integer>();
 
  /*
  Initializes a new FertilityRule with the specified ages for the start of the fertile and infertile 
  periods for agents of each sex. For example, the map {'X' -> [12, 15], 'Y' -> [12, 15]} indicates that between 12 
  and 15 is the inclusive childbearing period for both sexes.
  */
  public FertilityRule(Map<Character, Integer[]> childbearingOnset, Map<Character, Integer[]> climactericOnset) {
    this.childbearingOnset = childbearingOnset;
    this.climactericOnset = climactericOnset;
  }
  
  /*
  Determines whether Agent a is fertile, according to the rules listed below:
      *If a is null or dead, then remove all records of it from any storage it may be present in, and return false.
      *Otherwise, if this is the first time a was passed to this function, generate a random number for onset of 
       childbearing age(c) and the age of the start of a's climacteric (o), based on the fields of this class 
       (INCLUSIVE RANGES). Store those generated numbers in a way that is associated with a for later retrieval. 
       Store the current sugar level of a for retrieval as well.
      *Regardless of whether this is the first time, return true only if: c <= a.getAge() < o, using the values of c 
       and o that were stored for this agent earlier. a currently has at least as much sugar as it did the first time 
       we passed it to this function.
  */
  public boolean isFertile(Agent a) {
    int c = 0;
    int o = 0;
    if (a == (null) || a.isAlive() == false) {
      childBearingAge.remove(a);
      climactericAge.remove(a);
      sugarLevel.remove(a);
      return false;
    }
    if (childBearingAge.containsKey(a) == false) {
      //variable for sex of agent
      char agentSex = a.getSex();
      
      //childbearing age chosen at random
      c = (int)random(childbearingOnset.get(agentSex)[0], childbearingOnset.get(agentSex)[1] + 1);
      
      //climacteric age chosen at random
      o = (int)random(climactericOnset.get(agentSex)[0], climactericOnset.get(agentSex)[1] + 1);
      
      //place into storage for later retrieval
      childBearingAge.put(a, c);
      climactericAge.put(a, o);
      sugarLevel.put(a, a.getSugarLevel());
    }
    
    //println(a.getAge());
    
    if (childBearingAge.get(a) <= a.getAge() && a.getAge() < climactericAge.get(a)) {
      return true;
    }
    return false;
    
  }
  
  /*
  determines whether the two passed agents can form a breeding pair or not. LOCAL is the radius 1 vision around agent a. 
  Returns true only if:
      *a is fertile
      *b is fertile
      *a and b are of different sexes
      *b is on one of the Squares in LOCAL
      *at least one of the Squares in LOCAL is empty.
  */
  public boolean canBreed(Agent a, Agent b, LinkedList<Square> local) {
      if (this.isFertile(a) && this.isFertile(b) && a.getSex() != b.getSex() //&& 
          //a.getSugarLevel() >= (sugarLevel.get(a) / 2) && b.getSugarLevel() >= (sugarLevel.get(b) / 2)
          ) {
      for (Square s: local) {
        if (s.getAgent() == b) {
          for (Square s1: local) {
            if (s1.getAgent() == null)
              return true;
          }
        }
      }
    }
    return false;
    
  }
  
  /*
  creates and places a new Agent that is the offspring of a and b, according to the following process.
  The local visions of each agent are provided.
      *If a cannot breed with b and b cannot breed with a, then return null.
      *Otherwise, pick one of the parents' metabolisms, uniformly at random.
      *Pick one of the parents' visions, uniformly at random.
      *Take the MovementRule from Agent a.
      *Pick a sex uniformly at random.
      *Create a new agent (the child) using the parameters computed in the previous 4 steps, and 0 initial sugar.
      *Have each of the parents (a and b) gift half of their initial sugar amounts to the child.
      *Pick a random sqaure from aLocal or bLocal that does not have an Agent on it, and place the child on that square.
      *Return the child.

  */
  public Agent breed(Agent a, Agent b, LinkedList<Square> aLocal, LinkedList<Square> bLocal) {
    //if they can't breed, return null
    if (!this.canBreed(a, b, aLocal) && !this.canBreed(b, a, bLocal)) {
      return null;
    }
    
    //initial variables for new agent child
    int metabolism = 0;
    int vision = 0;
    
    //randomly assign metabolism, vision, and sex
    Random rand = new Random();
    int determineMet = rand.nextInt(2);
    if (determineMet == 0)
      metabolism = a.getMetabolism();
    else
      metabolism = b.getMetabolism();
      
    int determineVision = rand.nextInt(2);
    if (determineVision == 0)
      vision = a.getVision();
    else
      vision = b.getVision();
      
    //create new agent
    Agent agentChild = new Agent(metabolism, vision, 0, a.getMovementRule());
    
    //gift it half of each of its parents' sugar levels
    a.gift(agentChild, a.getSugarLevel() / 2);
    b.gift(agentChild, b.getSugarLevel() / 2);
   
    //assign culture values from parents at random by nurturing
    agentChild.nurture(a, b);
    
    int randLocal = (int)random(2);
    if (randLocal == 1) {
      Collections.shuffle(aLocal);
      for (Square s: aLocal) {
        if (s.getAgent() == null)
          s.setAgent(agentChild);
          break;
      }
    }
    else {
      Collections.shuffle(bLocal);
      for (Square s: bLocal) {
        if (s.getAgent() == null)
          s.setAgent(agentChild);
          break;
      }
    }
    
    //return agent child
    return agentChild;
  }
  
}
