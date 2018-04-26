import java.util.*;

class SocialNetwork{
  
  int w;
  int h;
  //adjacency list
  private LinkedList<SocialNetworkNode>[] adj;
  SocialNetworkNode[] snn;
  
  public SocialNetwork(SugarGrid g){
    
    w = g.getWidth();
    h = g.getHeight();
    adj = new LinkedList[g.getWidth()*g.getHeight()]; 
    snn = new SocialNetworkNode[g.getWidth()*g.getHeight()];
    
    //for every square in the sugargrid
    for (int i = 0; i < g.getWidth() * g.getHeight(); i++) {
          if(g.getAgentAt(i % w, i / w) != null){
            snn[i] = new SocialNetworkNode(g.getAgentAt(i % w, i / w));
            }   
        
    }
    
 for (int j = 0; j < (w * h); j++) {

      //if current agent exist
      if (adj[j] != null) {
        //generate its vision
        LinkedList<Square> vision = g.generateVision(j % w, j / w, snn[j].getAgent().getVision());
        adj[j].add(snn[j]);

        //for each square in current agent's vision
        for (int i = 0; i < vision.size(); i++) {

          //if agent in vision in square exists
          if (vision.get(i).getAgent() != null) {
            for (int k = 0; k < snn.length; k++) {
              if (snn[k] != null) {
                if (snn[k].getAgent().equals(vision.get(i).getAgent()) && snn[k].getAgent() != snn[j].getAgent()) {
                  adj[j].add(snn[k]);
             }
           }
          }
        }
           }
          }
     }
     
     
  }
  
  public boolean adjacent(SocialNetworkNode x, SocialNetworkNode y){
    int index = 0;
    
    if(x.getAgent() == null || y.getAgent() == null){
      return false;
    }
    
    for(int i = 0; i < (this.w * this.h); i++){
      if(x.getAgent() != null && x == snn[i]){
        index = i;
      }
    }
    
    if(adj[index].contains(y)){
      return true;
    }
    return false;
  }
  
  public List<SocialNetworkNode> seenBy(SocialNetworkNode x){
    int index = -1;
    
    for(int i = 0; i < (this.w * this.h); i++){
      if(x == snn[i]){
        index = i;
      }
    }
    
    if(index == -1){
      return null;
    }
    
    else{
      return adj[index];
    }  
  }
  
  public List<SocialNetworkNode> sees(SocialNetworkNode y){
    LinkedList<SocialNetworkNode> view = new LinkedList<SocialNetworkNode>();
    int index = -1;
    
    //determines if y is in the social network
    for(int i = 0; i < (this.w * this.h); i++){
      if(y == snn[i]){
        index = i;
      }
    }
    
    if(index == -1){
      return null;
    }
    
    for(int i = 0; i < (this.w * this.h); i++){
      if(adj[i].contains(y)){
        view.add(snn[i]);
      }
    }
    
    return view;
    }
    
    public void resetPaint(){
      for(SocialNetworkNode n : snn){
        n.unpaint();
      } 
    }
    
    public SocialNetworkNode getNode(Agent a){
      SocialNetworkNode temp = null;
      for(SocialNetworkNode n : snn){
        
        if(n.getAgent() != null && n.getAgent() == a){
          temp = n;
        }
      }
      return temp;
    }
    
    public boolean pathExists(Agent x, Agent y){
      LinkedList<SocialNetworkNode> stack = new LinkedList<SocialNetworkNode>();
      int index = -1;
      int yIndex = -1;
      
      //finds agent's node in snn
      for(int i = 0; i < (this.w * this.h); i++){
        if(x == snn[i].getAgent()){
          index = i;
        }
    }
    
     //finds agent's node in snn
      for(int i = 0; i < (this.w * this.h); i++){
        if(y == snn[i].getAgent()){
          yIndex = i;
        }
    }
    
    
    //pushes origin to stack and paints it
    stack.push(snn[index]);
    snn[index].paint();
    
    while(stack.size() > 0){
      SocialNetworkNode temp = stack.poll();
      if(temp == snn[yIndex]){
        return true;
      }
      else{
        for(SocialNetworkNode n : adj[Arrays.asList(snn).indexOf(temp)]){
          if(n.painted() == false){
            stack.push(n);
            n.paint();
          }
          
        } 
      }
    } 
      return false;
    }
    
    
   public List<Agent>bacon(Agent x, Agent y){
     List<Agent> agents = new LinkedList<Agent>();
      LinkedList<SocialNetworkNode> queue = new LinkedList<SocialNetworkNode>();
      int index = -1;
      int yIndex = -1;
      
      //finds agent's node in snn
      for(int i = 0; i < (this.w * this.h); i++){
        if(x == snn[i].getAgent()){
          index = i;
        }
    }
    
     //finds agent's node in snn
      for(int i = 0; i < (this.w * this.h); i++){
        if(y == snn[i].getAgent()){
          yIndex = i;
        }
    }
    
    
    //pushes origin to stack and paints it
    queue.add(snn[index]);
    snn[index].paint();
    agents.add(x);
    
    while(queue.size() > 0){
      SocialNetworkNode temp = queue.poll();
      agents.add(temp.getAgent());
      if(temp == snn[yIndex]){
        agents.add(y);
        return agents;
      }
      else{
        for(SocialNetworkNode n : adj[Arrays.asList(snn).indexOf(temp)]){
          if(n.painted() == false){
            queue.add(n);
            n.paint();
          }
          
        } 
      }
    } 
      return null;
        }
}