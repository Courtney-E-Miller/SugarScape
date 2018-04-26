class Agent {
  /* Agent fields:
  *    metabolism - int? float?
  *    vision - int, right? measured in grid steps
  *    stored sugar - int, right?
  *    movement rule - a reference to a MovementRule object
  *     (should all Agents have the same movement rule?)
  */
  private int metabolism;
  private int vision;
  private int sugarLevel;
  private MovementRule movementRule;
  private int age;
  private char sex;
  private boolean[] culture = new boolean[11];
  
  /* initializes a new Agent with the specified values for its 
  *  metabolism, vision, stored sugar, sex, and movement rule.
  *
  */
  public Agent(int metabolism, int vision, int initialSugar, MovementRule m, char sex) {
    this.metabolism = metabolism; 
    this.vision = vision;
    this.sugarLevel = initialSugar;
    this.movementRule = m;
    this.age = 0;
    this.sex = sex;
    if((sex != 'X') || (sex != 'Y')){
      assert(1 == 0);
    }
    for (int i = 0; i < 11; i++) {
      int rand = (int)random(2);
      if (rand == 0);
        culture[i] = true;
      if (rand == 1)
        culture[i] = false;
    }
  }
  
  //Constructor randomly assigns sex to either 'X' or 'Y'
  public Agent(int metabolism, int vision, int initialSugar, MovementRule m) {
    this.metabolism = metabolism; 
    this.vision = vision;
    this.sugarLevel = initialSugar;
    this.movementRule = m;
    this.age = 0;
    //assigns sex of Agent randomly to either 'X' or 'Y'
    int randi = (int)random(0, 2);
    if(randi == 0){
      this.sex = 'Y';
    }
    if(randi == 1){
      this.sex = 'X';
    }
    for (int i = 0; i < 11; i++) {
      int rand = (int)random(2);
      if (rand == 0);
        culture[i] = true;
      if (rand == 1)
        culture[i] = false;
    }
  }
  
  /* returns the amount of food the agent needs to eat each turn to survive. 
  *
  */
  public int getMetabolism() {
    return this.metabolism; // stubbed
  } 
  
  /* returns the agent's vision radius.
  *
  */
  public int getVision() {
    return this.vision; // stubbed
  } 
  
  /* returns the amount of stored sugar the agent has right now.
  *
  */
  public int getSugarLevel() {
    return this.sugarLevel; // stubbed
  } 
  
  /* returns the Agent's movement rule.
  *
  */
  public MovementRule getMovementRule() {
    return this.movementRule; 
  } 
  
  //returns the Agent's age
  public int getAge() {
    return this.age;
  }
  
  //returns the Agent's sex
  public char getSex(){
    return this.sex;
  }
  
  public void setSugarLevel(int amount){
    this.sugarLevel = amount;
  }
  
  //Provided that this agent has at least amount sugar, transfers that amount from this 
  //agent to the other agent. 
  public void gift(Agent other, int amount){
    if(this.sugarLevel < amount){
      assert(0 == 1);
    }
    this.sugarLevel -= amount;
    other.sugarLevel += amount;
  }
  
  /* Moves the agent from source to destination. If the destination is already occupied, the program should crash with an assertion error instead, unless the destination is the same as the source.
  *
  */
  public void move(Square source, Square destination) {
    destination.setAgent(source.getAgent());
    source.setAgent(null);
  } 
  
  /* Reduces the agent's stored sugar level by its metabolic rate, to a minimum value of 0.
  *
  */
  public void step() {
    if(this.sugarLevel - this.metabolism >= 0){
      sugarLevel = sugarLevel - metabolism;
    }
    else {
      sugarLevel = 0;
    } 
    this.age++;
  } 
  
  /* returns true if the agent's stored sugar level is greater than 0, false otherwise. 
  * 
  */
  public boolean isAlive() {
    if(this.sugarLevel > 0) {
      return true;
    }
    else{
    return false;
    }
  } 
  
  /* The agent eats all the sugar at Square s. The agents sugar level is increased by that amount, and the amount of sugar on the square is set to 0.
  *
  */
  public void eat(Square s) {
    this.sugarLevel = this.sugarLevel + s.getSugar();
    s.setSugar(0);
    
  } 
  
  /* returns true if this Agent passes all the tests I can think of
  *
  */
  public boolean test() {
    if (getSugarLevel() < 0) return false;
    if (isAlive() && getSugarLevel() == 0) return false;
    // is having no sugar the only way to die?
    
    return true;
  }
  
  public void influence(Agent other) {
    int num = (int)random(11);
    //if some random cultural value of THIS agent doesn equal OTHER agent
    if (this.culture[num] != other.culture[num])
      //set OTHER's culture value to THIS agent's culture
      other.culture[num] = this.culture[num];
  }

  public void nurture(Agent parent1, Agent parent2) {
    //for each boolean value in culture
    for (int i = 0; i < 11; i++) {
      //randomly assign cultural values to THIS agent
      int rand = (int)random(2);
      if (rand == 0)
        this.culture[i] = parent1.culture[i];
      else
        this.culture[i] = parent2.culture[i];
    }
  }

  public boolean getTribe() {
    int numTrue = 0;
    //for each boolean value in culture
    for (boolean b : culture) {
      //if the cultural value is true, increment numTrue
      if (b == true)
        numTrue++;
    }
    //if numTrue is greater than 5, than more values are true than false
    if (numTrue > 5)
      return true;
    //otherwise, return false
    return false;
  }
  
  public void display(int x, int y, int scale){
    //fill(0);
    rect(x, y, 10, 10);
    //ellipse(x, y, 3*scale/4, 3*scale/4);
  }
  
  public void setAge(int howOld){
    if(howOld >= 0){ //<>// //<>//
      this.age = howOld; //<>// //<>//
    }
    else{
      assert(1==0);
    }
    
  }
}
