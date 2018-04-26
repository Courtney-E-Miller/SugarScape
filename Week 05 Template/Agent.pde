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
  
  /* initializes a new Agent with the specified values for its 
  *  metabolism, vision, stored sugar, and movement rule.
  *
  */
  public Agent(int metabolism, int vision, int initialSugar, MovementRule m) {
  }
  
  /* returns the amount of food the agent needs to eat each turn to survive. 
  *
  */
  public int getMetabolism() {
    return 0; // stubbed
  } 
  
  /* returns the agent's vision radius.
  *
  */
  public int getVision() {
    return 0; // stubbed
  } 
  
  /* returns the amount of stored sugar the agent has right now.
  *
  */
  public int getSugarLevel() {
    return 0; // stubbed
  } 
  
  /* returns the Agent's movement rule.
  *
  */
  public MovementRule getMovementRule() {
    return movementRule; // stubbed
  } 
  
  /* Moves the agent from source to destination. If the destination is already occupied, the program should crash with an assertion error instead, unless the destination is the same as the source.
  *
  */
  public void move(Square source, Square destination) {
  } 
  
  /* Reduces the agent's stored sugar level by its metabolic rate, to a minimum value of 0.
  *
  */
  public void step() {
  } 
  
  /* returns true if the agent's stored sugar level is greater than 0, false otherwise. 
  * 
  */
  public boolean isAlive() {
    return false; //stubbed
  } 
  
  /* The agent eats all the sugar at Square s. The agents sugar level is increased by that amount, and the amount of sugar on the square is set to 0.
  *
  */
  public void eat(Square s) {
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
}