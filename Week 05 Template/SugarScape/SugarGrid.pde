import java.lang.Math;
import java.util.*;
class SugarGrid {


  /* Initializes a new SugarGrid object with a w*h grid of Squares, 
  *  a sideLength for the squares (used for drawing purposes only) 
  *  of the specified value, and 
  *  a sugar growback rule g. 
  *  Initialize the Squares in the grid to have 0 initial and 0 maximum sugar.
  *
  */
  private int w;
  private int h;
  private int sideLength;
  private GrowthRule gr;
  private FertilityRule fr;
  private ReplacementRule rr;
  private MovementRule mr;
  private AgentFactory fac;
  public Square[][] grid;
  public int vision;
  public Square goal;
  
  public SugarGrid(int w, int h, int sideLength, GrowthRule g) {
    this.w = w;
    this.h = h;
    this.sideLength = sideLength;
    this.gr = g;
    grid = new Square[w][h];
    for(int i = 0; i < w; i++){
      for(int j = 0; j < h; j++){
        grid[i][j] = new Square(0, 0, i, j);
      }
    }
    //11-3
    HashMap<Character, Integer[]> childBearingAge = new HashMap<Character, Integer[]>();
    childBearingAge.put('X', new Integer[]{12, 15});
    childBearingAge.put('Y', new Integer[]{12, 15});
    HashMap<Character, Integer[]> climactericOnset = new HashMap<Character, Integer[]>();
    climactericOnset.put('X', new Integer[]{30, 40});
    climactericOnset.put('Y', new Integer[]{40, 50});

    mr = new SugarSeekingMovementRule();

    fac = new AgentFactory(1, 10, 2, 4, 10, 50, mr);

    fr = new FertilityRule(childBearingAge, climactericOnset);
    gr = g;
    rr = new ReplacementRule(60, 100, fac);
    
    
  }

  /* Accessor methods for the named variables.
  *
  */
  public int getWidth() {
    return this.w; 
  }
  
  public int getHeight() {
    return this.h; 
  }
  
  public int getSquareSize() {
    return this.sideLength; 
  }
  
  /* returns respectively the initial or maximum sugar at the Square 
  *  in row i, column j of the grid.
  *
  */
  public int getSugarAt(int i, int j) {
    if(i >= 0 && j >= 0 && i < w && j < h){
      return(grid[i][j].getSugar());
    }
    else{
      //since this means this a square at index [i][j] does not exist (out of bounds)
      return -1;
    }
  }
 
  public int getMaxSugarAt(int i, int j) {
    if(i >= 0 && j >= 0 && i < w && j < h){
      return(grid[i][j].getMaxSugar());
    }
    else{
      //since this means this a square at index [i][j] does not exist (out of bounds)
      return -1;
    }
  }

  /* returns the Agent occupying the square at position (i,j) in the grid, 
  *  or null if no agent is present there.
  *
  */
  public Agent getAgentAt(int i, int j) {
    if(i >= 0 && j >= 0 && i < w && j < h){
        return(grid[i][j].getAgent());
    }
    else{
      //since this means this a square at index [i][j] does not exist (out of bounds)
      return null;
    }
  }

  /* places Agent a at Square(x,y), provided that the square is empty. 
  *  If the square is not empty, the program should crash with an assertion failure.
  *
  */
  public void placeAgent(Agent a, int x, int y) {
    if(grid[x][y].getAgent() == null){
      grid[x][y].setAgent(a);
    }
    else if (grid[x][y].getAgent() != null){
       assert(1 == 0); 
    }
  }

  /* A method that computes the Euclidian distance between two squares on the grid 
  *  at (x1,y1) and (x2,y2). 
  *  Points are indexed from (0,0) up to (width-1, height-1) for the grid. 
  *  The formula for Euclidean distance is normally sqrt( (x2-x1)2 + (y2-y1)2 ) However...
  *  
  *  As in the book, the grid is a torus. 
  *  This means that an Agent that moves off the top of the grid ends up at the bottom 
  *  (and vice versa), and 
  *  an Agent that moves off the left hand side of the grid ends up on the right hand 
  *  side (and vice versa). 
  *
  *  You should return the minimum euclidian distance between the two points. 
  *  For example, euclidianDistance((1,1), (19,19)) on a 20x20 grid would be 
  *  sqrt(2*2 + 2*2) = sqrt(8) ~ 3, and not sqrt(18*18 + 18*18) = sqrt(648) ~ 25. 
  *
  *  The built-in Java method Math.sqrt() may be useful.
  *
  */
  /*
  public double euclidianDistance(Square s1, Square s2) {
    int outgridX = abs( abs( min( abs(s1.getX()-0), abs(h-s1.getX()))) + abs( min( abs(s2.getX()-0), abs(h-s2.getX()))));
    int ingridX = abs( s1.getX() - s2.getX());
    int finalX = min(outgridX, ingridX);
    
    int outgridY = abs( abs( min( abs(s1.getY()-0), abs(h-s1.getY()))) + abs( min( abs(s2.getY()-0), abs(h-s2.getY()))));
    int ingridY = abs( s1.getY() - s2.getY());
    int finalY = min(outgridY, ingridY);
    println(s1.getX(), s1.getY(), s2.getX(), s2.getY());
    println(ingridX, ingridY, outgridX, outgridY);
    return Math.sqrt(finalX*finalX + finalY*finalY);
    
  }
  */
  
    public double euclidianDistance(Square a, Square b){
    int aX = a.getX();
    int aY = a.getY();
    int bX = b.getX();
    int bY = b.getY();
    int ingridX = abs(aX-bX);
    int ingridY = abs(aY-bY);
    int outgridX = abs(  min(abs(aX-0), abs(w-aX)) + min(abs(bX-0), abs(w-bX))  );
    int outgridY = abs(  min(abs(aY-0), abs(h-aY)) + min(abs(bY-0), abs(h-bY))  );
    //println(aX, aY, bX, bY);
    //println( ingridX, ingridY, outgridX, outgridY);
    int finalX = min(outgridX, ingridX);
    int finalY = min(outgridY, ingridY);
    return Math.sqrt(finalX*finalX + finalY*finalY); 
  }
  
  /* Creates a circular blob of sugar on the gird. 
  *  The center of the blob is at position (x,y), and 
  *  that Square is updated to store a maximum of max sugar or 
  *  its current maximum value, whichever is greater. 
  *
  *  Then, every square within euclidian distance of radius is updated 
  *  to store a maximum of (max-1) sugar, or its current maximum value, 
  *  whichever is greater. 
  *
  *  Then, every square within euclidian distance of 2*radius is updated 
  *  to store a maximum of (max-2) sugar, or its current maximum value, 
  *  whichever is greater. 
  *
  *  This process continues until every square has been updated. 
  *  Any Square that has a new maximum value 
  *  should also have its Sugar level set to this maximum.
  *
  */

  
    public void addSugarBlob(int x, int y, int radius, int maxL) {
    int increment = maxL;
    while (increment > 0) {
      for (int i = 0; i < w; i++) {
        for (int j = 0; j < h; j++) {
          double mdist = euclidianDistance(grid[i][j], grid[x][y]);
          if (mdist < radius * increment) {
            int sugar = maxL - increment;
            grid[i][j].setMaxSugar(sugar);
            grid[i][j].setSugar(sugar);
          }
        }
      }
      increment--;
      grid[x][y].setSugar(maxL);
      grid[x][y].setMaxSugar(maxL);
    }
  }

  
  /* Returns a linked list containing radius squares in each cardinal direction, 
  *  centered on (x,y). 
  *
  *  For example, generateVision(5,5,2) should return the squares 
  *   (5,5), (4,5), (3,5), (6,5), (7,5), (5,4), (5,3), (5,6), and (5,7). 
  *
  *  Your program may do whatever it likes if (x,y) is not a point on the grid, 
  *  or radius is negative. 
  *
  *  When radius is 0, it should return a list containing only (x,y). 
  *
  */
  public LinkedList<Square> generateVision(int x, int y, int radius) {
    Square center = grid[x][y];
    LinkedList<Square> vision = new LinkedList<Square>();
    for(int i = 0; i < w; i++){
        for(int j = 0; j < h; j++){
          if(i == x){
            if(euclidianDistance(grid[x][y], grid[i][j]) <= radius){
              vision.add(grid[i][j]);
            }
          }
           if(j == y){
            if(euclidianDistance(grid[x][y], grid[i][j]) <= radius){
              vision.add(grid[i][j]);
            }
          }
        }
    }
   return vision;
  }
  
  public void update(){
    ArrayList<Agent> lastAgent = new ArrayList<Agent>();
    for(int i = 0; i < w; i++){
        for(int j = 0; j < h; j++){
          //applies growBack() to every square
          gr.growBack(grid[i][j]);
          
          //if the square is not empty, completes processing, else skips over these commands    
          if (grid[i][j].getAgent() != null && lastAgent.contains(grid[i][j].getAgent()) == false){
          //fertility
          Square sq = grid[i][j];
          gr.growBack(sq);
          Agent a = sq.getAgent();
          LinkedList<Square> fertilityVision = this.generateVision(i, j, 1);

          for (Square s : fertilityVision) {
            if (s.getAgent() != null) {
              LinkedList<Square> sFertilityVision = this.generateVision(s.getX(), s.getY(), 1);
              fr.breed(a, s.getAgent(), fertilityVision, sFertilityVision);
            }
          }
 
            
             vision = a.getVision();
             LinkedList<Square> area = generateVision(grid[i][j].getX(), grid[i][j].getY(), vision);
             
             //applies movement rule move(LinkedList<Square> neighbourhood, SugarGrid g, Square middle) 
             MovementRule m = a.getMovementRule();
             
             while(area.size() != 0){
             goal = m.move(area, this, this.grid[(w-1)/2][(h-1)/2]);
             if(goal.getAgent() == null){
               a.move(grid[i][j], goal);
               break;
             }
             else{
               area.remove(goal);
             }
             }
             //System.out.println(goal.getX() + ", " + goal.getY());
             
             //moves agent to perferred square (will crash if square is occupied)
             
             //agent performes metabolic processes
             a.step();
             
             //if agent is dead, marks square to unoccupied
             if(a.isAlive() == false){
               goal.setAgent(null);
             }
             
             //if agent is still alive, it eats all the sugar at its current square
             if(a.isAlive() == true){
               a.eat(goal);
               lastAgent.add(a);
             }
          }
  
        }
      } 
  }
  
  public void display() {
     for(int i = 0; i < w; i++){
        for(int j = 0; j < h; j++){
          grid[i][j].display(sideLength);
        }
     } 
  }
  
  public void addAgentAtRandom(Agent a){
    LinkedList<Square> emptySquares = new LinkedList<Square>();
    
    //cycles through sugarGrid and adds empty squares to list emptySquares
    for(int i = 0; i < w; i++){
        for(int j = 0; j < h; j++){
          if(grid[i][j].getAgent() == null){
            emptySquares.add(grid[i][j]);
          }
        }
     }

     //creates a random number bewtewen 0 and the size of the linkedList
     int num = (int)random(0, emptySquares.size());
     
     //accesses the square in emptySquares at that random index
     Square chosenOne = emptySquares.get(num);
     
     //places the agent at that randomly chosen square
     //chosenOne.setAgent(a);
     //Changed because of autograder error
     this.placeAgent(a, chosenOne.getX(), chosenOne.getY());
  }
  
  public ArrayList<Agent> getAgents(){
    ArrayList<Agent> allAgents = new ArrayList<Agent>();
    for(int i = 0; i < w; i++){
        for(int j = 0; j < h; j++){
          if(grid[i][j].getAgent() != null){
            allAgents.add(grid[i][j].getAgent());
          }
        }
    } 
    return allAgents;
  }
  
    public Agent killAgent(Agent a) {
    //kill agent
    a.setSugarLevel(0);
    //pass dead agent to fertility and replacement rule stored in sugargrid
    fr.isFertile(a);
    rr.replace(a, this.getAgents());
    return a;
  }
  
  
}
