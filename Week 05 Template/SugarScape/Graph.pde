import java.util.*;

class Graph {
  int x;
  int y; 
  int howWide;
  int howTall;
  String xlab;
  String ylab;
  
  public Graph(int x, int y, int howWide, int howTall, String xlab, String ylab){
    this.x = x;
    this.y = y;
    this.howWide = howWide;
    this.howTall = howTall;
    this.xlab = xlab;
    this.ylab = ylab;
  }
 
  public void update(SugarGrid g){
    stroke(255);
    rect(x, y, howWide, howTall);
    stroke(0);
    strokeWeight(.75);
    //x-axis
    line(x, y+howTall, x+howWide, y+howTall);
    //y-axis
    line(x, y, x, y+howTall);
    
    stroke(0);
    //fill(0);
    text(xlab, x + howWide/3, y + howTall + 15);
    pushMatrix();
    translate(x, y);
    rotate(-PI/2.0);
    text(ylab, -howTall/2, -10);
    popMatrix();   
  }
}

abstract class LineGraph extends Graph {
  int numUpdate; 
  
  public LineGraph(int x, int y, int howWide, int howTall, String xlab, String ylab){
    super(x, y, howWide, howTall, xlab, ylab);
    numUpdate = 0;
  }
  
  public abstract int nextPoint(SugarGrid g);
  
  public void update(SugarGrid g){
    if(numUpdate == 0){
      super.update(g);
    }
    else{
      //determines next y
      int pY = this.nextPoint(g);
    
    
    //creates rectangle for next point on graph
    //fill(0);
    stroke(0);
    strokeWeight(1);
    rect(x+numUpdate, y + howTall - pY, 1, 1);
    
    if(numUpdate > howWide){
      numUpdate = 0;
      }
    } 
    numUpdate++;
  } 
}

class AvgSugarGraph extends LineGraph{

    int sugarSum;

  public AvgSugarGraph(int x, int y, int howWide, int howTall, String xlab, String ylab){
    super(x, y, howWide, howTall, xlab, ylab);
  }
  
  public int nextPoint(SugarGrid g){
    ArrayList<Agent> listAgents = g.getAgents();
    sugarSum = 0;
 
    for(int i = 0; i < listAgents.size(); i++){
      Agent curAg = listAgents.get(i);
      sugarSum += curAg.getSugarLevel();
    }
    println(sugarSum/listAgents.size());
    return sugarSum/listAgents.size();  
  } 
}

class AvgMetabolismGraph extends LineGraph{

    int metabolismSum;

  public AvgMetabolismGraph(int x, int y, int howWide, int howTall, String xlab, String ylab){
    super(x, y, howWide, howTall, xlab, ylab);
  }
  
  public int nextPoint(SugarGrid g){
    ArrayList<Agent> listAgents = g.getAgents();
    metabolismSum = 0;
 
    for(int i = 0; i < listAgents.size(); i++){
      Agent curAg = listAgents.get(i);
      metabolismSum += curAg.getMetabolism();
    }
    //multiplied by 4 to help zoom in so you can see patterns develop
    return (metabolismSum/listAgents.size() * 4);  
  } 
}

abstract class CDFGraph extends Graph{
  int numUpdates;
  int callsPerValue;
  
  public CDFGraph(int x, int y, int howWide, int howTall, String xlab, String ylab, int callsPerValue){
    super(x, y, howWide, howTall, xlab, ylab);
    numUpdates = 0;
    this.callsPerValue = callsPerValue;
  }
  
  public abstract void reset(SugarGrid g);
  
  public abstract int nextPoint(SugarGrid g);
  
  public abstract int getTotalCalls(SugarGrid g);
  
  public void update(SugarGrid g){
    numUpdates = 0;
    super.update(g);
    reset(g);
    int numPerCell = howWide/getTotalCalls(g);
    while(numUpdates < getTotalCalls(g)){
      rect(x + (numUpdates* numPerCell), y + howTall - nextPoint(g), numPerCell, 1);
      numUpdates++;
    } 
  } 
}

class WealthCDFGraph extends CDFGraph{ 
  ArrayList<Agent> sortedAgents;
  int totalSugar;
  int sugarSoFar;
  int avgSum;
  
  public WealthCDFGraph(int x, int y, int howWide, int howTall, String xlab, String ylab, int callsPerValue){
    super(x, y, howWide, howTall, xlab, ylab, callsPerValue);
  }
  
  public void reset(SugarGrid g){
    sortedAgents = g.getAgents();
    QuickSorter qs = new QuickSorter();
    //sorts agents using quicksort
    qs.sort(sortedAgents);
    
    totalSugar = 0;
    
    //calculates the total sugar owned by all agents
    for(Agent a : sortedAgents){
      totalSugar += a.getSugarLevel();
    }
    
    sugarSoFar = 0; 
  }
  
  //uses numUpdates from superclass to compute the number fo agnets that ha
  public int nextPoint(SugarGrid g){
    avgSum = 0;
    
    if(callsPerValue > sortedAgents.size() - super.numUpdates*callsPerValue){
      for(int i = super.numUpdates*callsPerValue; i < sortedAgents.size(); i++){
        avgSum += sortedAgents.get(i).getSugarLevel();
      }
    }
  
    else{
      for(int i = super.numUpdates*callsPerValue; i < super.numUpdates*callsPerValue + callsPerValue; i++){
        avgSum += sortedAgents.get(i).getSugarLevel();
      }
    }
      avgSum /= callsPerValue;
      sugarSoFar += avgSum;
      return ((totalSugar/sugarSoFar)); 
    
  }
  
  public int getTotalCalls(SugarGrid g){
    return sortedAgents.size() / callsPerValue;
  }
}

class A9Q2Demo extends LineGraph {
  
  int sum;

  public A9Q2Demo(int x, int y, int howWide, int howTall, String xlab, String ylab) {
    super(x, y, howWide, howTall, xlab, ylab);
  }

  public int nextPoint(SugarGrid g) {
    ArrayList<Agent> agentList = g.getAgents();
    return agentList.size() / 10;
  }
}
