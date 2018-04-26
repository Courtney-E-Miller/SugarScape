 import java.util.*;


SugarGrid myGrid;
AgentFactory fac;
AvgSugarGraph as;
AvgMetabolismGraph am;
WealthCDFGraph wc;

A9Q2Demo q2 = new A9Q2Demo(1010, 5, 360, 200, "Time", "Agents");

void setup() {
  /*
  SquareTester st = new SquareTester();
  st.test();  

 GrowbackRuleTester gr = new GrowbackRuleTester();
  gr.test();  

  SugarGridTester sg = new SugarGridTester();
  sg.test();

  AgentTester at = new AgentTester();
  at.test();

  ReplacementRuleTester rr = new ReplacementRuleTester();
  rr.test();

  SorterTester sort = new SorterTester();
  sort.test();
  
  SocialNetworkNodeTester snn = new SocialNetworkNodeTester();
  snn.test();
  
  //SocialNetworkTester sn = new SocialNetworkTester();
 // sn.test();
  
   
  fill(0, 255, 0);
  noStroke();
  ellipse(50, 50, 50,50);
  */
  size(1400,800);
  
  
  myGrid = new SugarGrid(50, 40, 20, new GrowbackRule(1));
  fac = new AgentFactory(1,10,2,4,10,20, new SugarSeekingMovementRule());
  
  myGrid.addSugarBlob(10, 10, 1, 8);
  myGrid.addSugarBlob(40, 10, 2, 6);
  myGrid.addSugarBlob(25, 30, 3, 5);


  for (int i = 0; i < 400; i++) {
    myGrid.addAgentAtRandom(fac.makeAgent());
  }
  /*
  as = new AvgSugarGraph(1025, 5, 360, 200, "Time", "Avg Sugar");
  am = new AvgMetabolismGraph(1025, 225, 360, 200, "Time", "Avg Metabolism");
  wc = new WealthCDFGraph(1025, 445, 360, 200, "Number of Agents", "SugarLevel Percentile", 5);
  
  myGrid.addSugarBlob(10,10,1,8);
  myGrid.addSugarBlob(40, 10, 2, 6);
  myGrid.addSugarBlob(25, 30, 3, 5);
  
  for(int i = 0; i <= 50; i++){
    myGrid.addAgentAtRandom(fac.makeAgent());
  }
  
  myGrid.display();
  
  as.update(myGrid);
  am.update(myGrid);
  wc.update(myGrid);
  */

  
  q2.update(myGrid);
  frameRate(4);

}

void draw() {
  
  myGrid.update();
  
  myGrid.display();
  
 
  q2.update(myGrid);
  
}
