import java.util.LinkedList;
import java.*;

public class SquareTester{
  void test(){
    Square s = new Square(5, 9, 50, 50); // square with sugarLevel 5, maxSugarLevel 9, position (x, y) = (50, 50)
    assert (s.getSugar() == 5);
    assert (s.getMaxSugar() == 9);
    assert(s.getX() == 50);
    assert(s.getY() == 50);
    
    //constructor is now working
    
    //setSugar() tests
    s.setSugar(6);
    assert(s.getSugar() == 6);
    s.setSugar(10);
    assert(s.getSugar() == 9);
    s.setSugar(-3);
    assert(s.getSugar() == 0);
    s.setSugar(6);
    assert(s.getSugar() == 6);
    //we check up on maxSugar again because this would be an easy bug to create
    assert(s.getMaxSugar() == 9);
    //test edge cases 
    s.setSugar(7);
    assert(s.getSugar() == 7);
    s.setSugar(0);
    assert(s.getSugar() == 0);
    //now test things that are out of range
    s.setSugar(-1);
    assert(s.getSugar() == 0);
    s.setSugar(10);
    //due to specifications 
    assert(s.getSugar() == 9);
    //make sure that setting it BACK to -1 still sets it to 0
    s.setSugar(-1);
    assert(s.getSugar() == 0);
    //setSugar is working now.
    
    //setMaxSugar tests:
    s.setMaxSugar(-3);
    assert(s.getMaxSugar() == 0);
    s.setMaxSugar(9);
    assert(s.getMaxSugar() == 9);
    s.setSugar(8);
    s.setMaxSugar(6);
    assert(s.getMaxSugar() == 6);
    assert(s.getSugar() == 6);
    s.setMaxSugar(-5);
    assert(s.getMaxSugar() == 0 && s.getSugar() == 0);
    s.setMaxSugar(10);
    assert(s.getMaxSugar() == 10);
    s.setSugar(5);
    assert(s.getSugar() == 5);
    s.setMaxSugar(11);
    assert(s.getMaxSugar() == 11 && s.getSugar() == 5);
    
    
    //setMaxSugar is working now
    
    //getAgent tests:
    //since we should start out with no agents
    assert(s.getAgent() == null);
    
    //creating a new agent to test getAgent()
    Agent a = new Agent(0, 0, 0, null);
    s.setAgent(a);
    assert(s.getAgent() == a);
    s.setAgent(a);
    assert(s.getAgent() == a);
    s.setAgent(null);
    assert(s.getAgent() == null);
    //setAgent is now working
    
    //tests for class Square are now complete (we're not testing display())
  }
}
  
  public class GrowbackRuleTester{
    void test(){
    //GrowbackRule(int rate) tests:
    GrowbackRule n = new GrowbackRule(3);
    //UNSURE OF HOW TO TEST GrowbackRule(int rate)
    
    //growBack() tests:
    Square s = new Square(1, 10, 2, 2);
    n.growBack(s);
    assert(s.getSugar() == 4);
    n.growBack(s);
    assert(s.getSugar() == 7);
    n.growBack(s);
    assert(s.getSugar() == 10);
    n.growBack(s);
    assert(s.getSugar() == 10);
    //growBack() is now working
    
    //tests for class GrowbackRule are now complete
    }
  }
  
  public class SugarGridTester{
    void test(){
      //SugarGrid() tests:
      GrowbackRule n = new GrowbackRule(3);
      SugarGrid g = new SugarGrid(50, 40, 25, n);
      assert(g.getWidth() == 50);
      assert(g.getHeight() == 40);
      assert(g.getSquareSize() == 25);
      //constructor and accessors work
      
      //getSugarAt() tests:
      assert(g.getSugarAt(9, 8) == 0);
      assert(g.getSugarAt(10, 9) == 0);
      assert(g.getSugarAt(3, 3) == 0);
      assert(g.getSugarAt(0, 2) == 0);
      assert(g.getSugarAt(11, 7) == 0);
      assert(g.getSugarAt(0, 0) == 0);
      //getSugatAt() is now working:
      
      //getMaxSugarAt(), getSugarAt, getAgentAt() tests:
      for(int i = 0; i < g.getWidth(); i++){
        for(int j = 0; j < g.getHeight(); j++){
          assert(g.getSugarAt(i, j) == 0);
          assert(g.getMaxSugarAt(i, j) == 0);
          assert(g.getAgentAt(i, j) == null);
        }
      }
      //getMaxSugarAt(), getSugarAt, getAgentAt() are now working:

      
      Agent a = new Agent(0, 0, 0, null);
      for(int i = 0; i < g.getWidth(); i++){
        for(int j = 0; j < g.getHeight(); j++){
          assert(g.getAgentAt(i, j) == null);
          g.placeAgent(a, i, j);
          assert(g.getAgentAt(i, j) == a);
        }
      }

      assert(g.euclidianDistance(g.grid[10][10], g.grid[10][10]) == 0);
      assert(g.euclidianDistance(g.grid[10][10], g.grid[14][14]) == Math.sqrt(32));
      assert(g.euclidianDistance(g.grid[2][3], g.grid[49][39]) == Math.sqrt(25));
      assert(g.euclidianDistance(g.grid[2][3], g.grid[49][39]) == g.euclidianDistance(g.grid[49][39], g.grid[2][3]));
      assert(g.euclidianDistance(g.grid[2][39], g.grid[49][3]) == g.euclidianDistance(g.grid[49][39], g.grid[2][3]));
      assert(g.euclidianDistance(g.grid[49][3], g.grid[2][39]) == g.euclidianDistance(g.grid[49][39], g.grid[2][3]));
      
      //adddSugarBlob tests:
      
      //checks to make sure current maxSugar is at 0 for whole grid before we add a blob
        for(int i = 0; i < g.getWidth(); i++){
          for(int j = 0; j < g.getHeight(); j++){
            assert(g.getMaxSugarAt(i, j) == 0);
        }
      }
      
      
      g.addSugarBlob(5, 5, 5, 4);
      assert(g.grid[5][5].getMaxSugar() == 4);
      assert(g.grid[5][4].getMaxSugar() == 3);
      //addSugarBlob() is working
      
      //generateVision() testing:
      g.generateVision(5, 5, 2);
      
      //addAgentAtRandom() testing:
      //create new empty sugar grid
      SugarGrid f = new SugarGrid(50, 40, 25, n);
      for(int i = 0; i < g.getWidth(); i++){
          for(int j = 0; j < g.getHeight(); j++){
            assert(f.grid[i][j].getAgent() == null);
          }
      }
      
     Agent c = new Agent(0, 0, 0, null);
     f.addAgentAtRandom(c);    

     
    }
    
  }
  
  public class AgentTester{
    void test(){
      MovementRule m = new SugarSeekingMovementRule();
      Agent a = new Agent(5, 6, 7, m);
      assert(a.getMetabolism() == 5);
      assert(a.getVision() == 6);
      assert(a.getSugarLevel() == 7);
      assert(a.getMovementRule() == m);
      assert(a.getAge() == 0);
      
      //Constructor and accessors now work
      
      Square s = new Square(5, 5, 0, 0);
      Square t = new Square(5, 5, 0, 1);
      t.setAgent(a);
      assert(t.getAgent() == a);
      a.move(t, s);
      assert(s.getAgent() == a);
      assert(t.getAgent() == null);
      //move is now working correctly
      
      assert(a.getSugarLevel() == 7);
      assert(a.isAlive() == true);
      a.step();
      assert(a.getSugarLevel() == 2);
      assert(a.isAlive() == true);
      a.step();
      assert(a.getSugarLevel() == 0);
      assert(a.isAlive() == false);
      a.step();
      assert(a.getSugarLevel() == 0);
      assert(a.isAlive() == false);
      //step() and isAlive() are now working
      
      
      Agent b = new Agent(5, 6, 7, m);
      assert(t.getSugar() == 5);
      assert(b.getSugarLevel() == 7);
      b.eat(t);
      assert(t.getSugar() == 0);
      assert(b.getSugarLevel() == 12);
      
      //updated step() testing:
      Agent c = new Agent(5, 6, 7, m);
      assert(c.getMetabolism() == 5);
      assert(c.getVision() == 6);
      assert(c.getSugarLevel() == 7);
      assert(c.getMovementRule() == m);
      assert(c.getAge() == 0);
      c.step();
      assert(c.getAge() == 1);
      assert(c.getSugarLevel() == 2);
      c.step();
      assert(c.getAge() == 2);
      assert(c.getSugarLevel() == 0);
      assert(c.isAlive() == false);
      c.step();
      //keeps aging agent when you call step, even if they are dead**
      assert(c.getAge() == 3);
      
      //updated step() is now working
      
      //setAge() testing:
      c.setAge(5);
      assert(c.getAge() == 5);
      c.setAge(0);
      assert(c.getAge() == 0);
      c.setAge(2);
      assert(c.getAge() == 2);
      
      //setAge() is now working
    } 
  }
  
public class ReplacementRuleTester{
  void test(){
    MovementRule m = new SugarSeekingMovementRule();
    Agent a = new Agent(5, 6, 7, m);
    AgentFactory f = new AgentFactory(1, 5, 1, 5, 1, 5, m);
    ReplacementRule r = new ReplacementRule(1, 5, f);
    r.replaceThisOne(a);
    
      
  }
}

public class SorterTester{
  Agent a;
  Agent b;
  Agent c;
  Agent d;
  Agent e;
  
  void test(){
    MovementRule m = new SugarSeekingMovementRule();
    //agents 
    Agent a = new Agent(5, 6, 1, m);
    Agent b = new Agent(5, 6, 2, m);
    Agent c = new Agent(5, 6, 3, m);
    Agent d = new Agent(5, 6, 4, m);
    Agent e = new Agent(5, 6, 5, m);
    
    //empty array list
    ArrayList<Agent> emptyAl = new ArrayList<Agent>();
    assert(emptyAl.size() == 0);
    
    //array list with one element
    ArrayList<Agent> oneElement = new ArrayList<Agent>();
    oneElement.add(a);
    assert(oneElement.size() == 1);
    
    //array list in backwards order
    ArrayList<Agent> backwardsAl = new ArrayList<Agent>();
    backwardsAl.add(e);
    backwardsAl.add(d);
    backwardsAl.add(c);
    backwardsAl.add(b);
    backwardsAl.add(a);
    
    //array list with even number of elements in scatterd order
    ArrayList<Agent> evenAl = new ArrayList<Agent>();
    evenAl.add(c);
    evenAl.add(e);
    evenAl.add(a);
    evenAl.add(b);
    
    //array list with odd number of elements in scattered order
    ArrayList<Agent> oddAl = new ArrayList<Agent>();
    oddAl.add(c);
    oddAl.add(e);
    oddAl.add(a);
    oddAl.add(b);
    oddAl.add(d);
    
    //Bubblesort Testing:
    BubbleSorter bubble = new BubbleSorter();
    //tests empty list
    bubble.sort(emptyAl);
    
    //tests list with one element
    bubble.sort(oneElement);
    assert(oneElement.get(0).equals(a));

    //tests list with backwards order
    bubble.sort(backwardsAl);
    assert(backwardsAl.get(0).equals(a));
    assert(backwardsAl.get(1).equals(b));
    assert(backwardsAl.get(2).equals(c));
    assert(backwardsAl.get(3).equals(d));
    assert(backwardsAl.get(4).equals(e));

    
    //tests list with even number of elemnts in scatterd order 
    bubble.sort(evenAl);
    assert(evenAl.get(0).equals(a));
    assert(evenAl.get(1).equals(b));
    assert(evenAl.get(2).equals(c));
    assert(evenAl.get(3).equals(e));

    //tests list with odd number of elements in scattered order
    bubble.sort(oddAl);
    assert(oddAl.get(0).equals(a));
    assert(oddAl.get(1).equals(b));
    assert(oddAl.get(2).equals(c));
    assert(oddAl.get(3).equals(d));
    assert(oddAl.get(4).equals(e));

    //BubbleSort tests complete


    //InsertionSort tests:
    InsertionSorter inst = new InsertionSorter();
    //tests empty list
    inst.sort(emptyAl);
    
    //tests list with one element
    inst.sort(oneElement);
    assert(oneElement.get(0).equals(a));


    //tests list with backwards order
    inst.sort(backwardsAl);
    assert(backwardsAl.get(0).equals(a));
    assert(backwardsAl.get(1).equals(b));
    assert(backwardsAl.get(2).equals(c));
    assert(backwardsAl.get(3).equals(d));
    assert(backwardsAl.get(4).equals(e));

    
    //tests list with even number of elemnts in scatterd order 
    inst.sort(evenAl);
    assert(evenAl.get(0).equals(a));
    assert(evenAl.get(1).equals(b));
    assert(evenAl.get(2).equals(c));
    assert(evenAl.get(3).equals(e));

    //tests list with odd number of elements in scattered order
    inst.sort(oddAl);
    assert(oddAl.get(0).equals(a));
    assert(oddAl.get(1).equals(b));
    assert(oddAl.get(2).equals(c));
    assert(oddAl.get(3).equals(d));
    assert(oddAl.get(4).equals(e));
    
    //InsertionSort tests complete
    
    //MergeSorter testing:
    MergeSorter mm = new MergeSorter();
    //tests empty list
    mm.sort(emptyAl);
  
    //tests list with one element
    mm.sort(oneElement);
    assert(oneElement.get(0).equals(a));

    //tests list with backwards order
    mm.sort(backwardsAl);
    assert(backwardsAl.get(0).equals(a));
    assert(backwardsAl.get(1).equals(b));
    assert(backwardsAl.get(2).equals(c));
    assert(backwardsAl.get(3).equals(d));
    assert(backwardsAl.get(4).equals(e));

    
    //tests list with even number of elemnts in scatterd order 
    mm.sort(evenAl);
    assert(evenAl.get(0).equals(a));
    assert(evenAl.get(1).equals(b));
    assert(evenAl.get(2).equals(c));
    assert(evenAl.get(3).equals(e));

    //tests list with odd number of elements in scattered order
    mm.sort(oddAl);
    assert(oddAl.get(0).equals(a));
    assert(oddAl.get(1).equals(b));
    assert(oddAl.get(2).equals(c));
    assert(oddAl.get(3).equals(d));
    assert(oddAl.get(4).equals(e));
    
    //MergeSorter tests complete
    
    //QuickSorter testing:
    QuickSorter qs = new QuickSorter();
    //tests empty list
    qs.sort(emptyAl);
  
    //tests list with one element
    qs.sort(oneElement);
    assert(oneElement.get(0).equals(a));

    //tests list with backwards order
    qs.sort(backwardsAl);
    assert(backwardsAl.get(0).equals(a));
    assert(backwardsAl.get(1).equals(b));
    assert(backwardsAl.get(2).equals(c));
    assert(backwardsAl.get(3).equals(d));
    assert(backwardsAl.get(4).equals(e));

    
    //tests list with even number of elemnts in scatterd order 
    qs.sort(evenAl);
    assert(evenAl.get(0).equals(a));
    assert(evenAl.get(1).equals(b));
    assert(evenAl.get(2).equals(c));
    assert(evenAl.get(3).equals(e));

    //tests list with odd number of elements in scattered order
    qs.sort(oddAl);
    assert(oddAl.get(0).equals(a));
    assert(oddAl.get(1).equals(b));
    assert(oddAl.get(2).equals(c));
    assert(oddAl.get(3).equals(d));
    assert(oddAl.get(4).equals(e));
    
    //QucikSorter tests complete
  }
}

public class SocialNetworkNodeTester{
  
  public void test(){
    MovementRule m = new SugarSeekingMovementRule();
    Agent a = new Agent(5, 6, 1, m);
    
    SocialNetworkNode n = new SocialNetworkNode(a);
    assert(n.getAgent() == a);
    assert(n.painted() == false);
    n.paint();
    assert(n.painted() == true);
    n.unpaint();
    assert(n.painted() == false);
  }
}

public class SocialNetworkTester{
  
  public void test(){
  SugarGrid grid = new SugarGrid(6, 6, 50, new GrowbackRule(0));
    grid.addSugarBlob(1, 2, 1, 5);
    Agent a1 = new Agent(1, 1, 50, new SugarSeekingMovementRule());
    Agent a2 = new Agent(1, 1, 50, new SugarSeekingMovementRule());
    Agent a3 = new Agent(1, 2, 50, new SugarSeekingMovementRule());
    Agent a4 = new Agent(1, 1, 50, new SugarSeekingMovementRule());
    Agent a5 = new Agent(1, 1, 50, new SugarSeekingMovementRule());
    println("a1 " + a1);
    println("a2 " + a2);
    println("a3 " + a3);
    println("a4 " + a4);
    println("a5 " + a5);
    grid.placeAgent(a3, 2, 1);
    grid.placeAgent(a4, 5, 1);
    grid.placeAgent(a5, 3, 3);
    grid.placeAgent(a1, 2, 0);
    grid.placeAgent(a2, 0, 1);
    SocialNetwork sn = new SocialNetwork(grid);
    SocialNetworkNode a2Node = sn.getNode(a2);
    SocialNetworkNode a3Node = sn.getNode(a3);
    println("a2 node " + a2Node);
    println("a2 sees " + sn.sees(a2Node));
    println("a2 seen by " + sn.seenBy(a2Node));
    assert(sn.adjacent(a3Node, a2Node));
    assert(sn.pathExists(a1, a3));
    assert(sn.pathExists(a3, a4));
    assert(sn.pathExists(a1, a2));
    assert(sn.pathExists(a1, a4));
    grid.display();
    
    
  }
  
}