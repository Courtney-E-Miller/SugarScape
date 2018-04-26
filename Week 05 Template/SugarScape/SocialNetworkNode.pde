class SocialNetworkNode{
  
  //isPaint is true when the node is painted, and false when it is not painted.
  boolean isPaint;
  Agent a;
  
  //initializes new node with passed agent, sets isPaint to false (not painted)
  public SocialNetworkNode(Agent a){
    this.a = a;
    isPaint = false;
  }
  
  //returns true iff the node is painted
  public boolean painted(){
    return isPaint;
  }
  
  //sets the node to painted(true)
  public void paint(){
    isPaint = true;
  }
  
  //sets the node to unpainted(false)
  public void unpaint(){
    isPaint = false;
  }
  
  //returns the agent stored in node
  public Agent getAgent(){
    return a;
  }
  
}