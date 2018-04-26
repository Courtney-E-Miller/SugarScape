import java.util.*;

public interface MovementRule{
  public Square move(LinkedList<Square> neighbourhood, SugarGrid g, Square middle); 
}


class SugarSeekingMovementRule implements MovementRule{
  /* The default constructor. For now, does nothing.
  *
  */
  public SugarSeekingMovementRule() {}
  
  /* For now, returns the Square containing the most sugar. 
  *  In case of a tie, use the Square that is closest to the middle according 
  *  to g.euclidianDistance(). 
  *  Squares should be considered in a random order (use Collections.shuffle()). 
  */
  
  public Square move(LinkedList<Square> neighbourhood, SugarGrid g, Square middle) {
    Square maxS = g.grid[0][0];
    Square current = null;
    int max = 0;
    Collections.shuffle(neighbourhood);
    //for(Square i : neighbourhood){
    for (int i = 0; i < neighbourhood.size(); i++) {
      current = neighbourhood.get(i);
      if(current.getSugar() > max){
        maxS = current;
        max = maxS.getSugar();
      }
      if(current.getSugar() == max){
        if(g.euclidianDistance(current, middle) < g.euclidianDistance(maxS, middle)){
          maxS = current;
        }
      }
    }
    return maxS; // stubbed
    
  }
}

class PollutionMovementRule implements MovementRule{
  
  public PollutionMovementRule(){}
  
  public Square move(LinkedList<Square> neighbourhood, SugarGrid g, Square middle){
    Square maxS = g.grid[0][0];
    Square current = null;
    double maxRatio = 0;
    double currentRatio;
    
    Collections.shuffle(neighbourhood);
    //for(Square i : neighbourhood){
    for (int i = 0; i < neighbourhood.size(); i++) {
      current = neighbourhood.get(i);
      if(current.getPollution() == 0){
        if(maxS.getPollution() == 0){
          double maxRatioDiff = g.euclidianDistance(maxS, middle);
          double currentRatioDiff = g.euclidianDistance(current, middle);
          if(maxRatioDiff > currentRatioDiff){
            maxS = current;
            maxRatio = 1000;
          }
        } 
      }
      
      else{
         currentRatio = current.getSugar()/current.getPollution();
         if(currentRatio > maxRatio){
           maxS = current;
           maxRatio = currentRatio;
      }
      
        else if(currentRatio == maxRatio){
          double maxRatioDiff = g.euclidianDistance(maxS, middle);
          double currentRatioDiff = g.euclidianDistance(current, middle);
          if(maxRatioDiff > currentRatioDiff){
            maxS = current;
          }
        }   
      }
    }
    return maxS; 
  }
}

class CombatMovementRule extends SugarSeekingMovementRule {

  int alpha;

  //initializes a new CombatMovementRule with the specified value of ALPHA
  public CombatMovementRule(int alpha) {
    this.alpha = alpha;
  }
  
    public Square move(LinkedList<Square> neighbourhood, SugarGrid g, Square middle) {
    
    //for each square in neighbourhood
    for (int i = 0; i < neighbourhood.size(); i++) {
      //1.
      Square current = neighbourhood.get(i);
      //if current agent exists
      if (current.getAgent() != null) {
        //if current and middle are the same tribe, remove from possible list of combatants
        if (middle.getAgent().getTribe() == current.getAgent().getTribe())
          neighbourhood.remove(current);
        //2.
        //if current has more sugar than middle, remove from possible list of combatants
        if (middle.getAgent().getSugarLevel() <= current.getAgent().getSugarLevel())
          neighbourhood.remove(current);
      }
    }

    //3.
    //for each square left in neighbourhood
    for (int i = 0; i < neighbourhood.size(); i++) {
      Square current = neighbourhood.get(i);
      //if current agent exists
      if (current.getAgent() != null) {
        //get its vision
        LinkedList<Square> sVision = g.generateVision(current.getX(), current.getY(), middle.getAgent().getVision());
        //for each square in middle's possible vision
        for (Square s : sVision) {
          //if the square has an agent
          if (s.getAgent() != null) {
            //if 
            if (middle.getAgent().getTribe() != s.getAgent().getTribe() && 
              middle.getAgent().getSugarLevel() <= s.getAgent().getSugarLevel()) {
              neighbourhood.remove(current);
              break;
            }
          }
        }
      }
    }


    //4.
    LinkedList<Square> newNeighbourhood = new LinkedList<Square>();
    for (int i = 0; i < neighbourhood.size(); i++) {
      if (neighbourhood.get(i).getAgent() != null) {
        Square temp = neighbourhood.get(i);
        newNeighbourhood.add(i, new Square((temp.getSugar() + temp.getAgent().getSugarLevel() + alpha), (temp.getSugar() + temp.getAgent().getSugarLevel() + alpha), temp.getX(), temp.getY()));
      } else newNeighbourhood.add(i, neighbourhood.get(i));
    }
    //5. -- sort of
    Square superMove = super.move(newNeighbourhood, g, middle);
    Square target = neighbourhood.get(newNeighbourhood.indexOf(superMove));

    //7.
    if (target.getAgent() != null) {
      Agent casualty = target.getAgent();
      int middleSugar = middle.getAgent().getSugarLevel();
      middle.getAgent().setSugarLevel(middleSugar + casualty.getSugarLevel() + alpha);
      g.killAgent(casualty);
    }
    //6-7.
    //target.setAgent(null);
    return target;
  }
}
