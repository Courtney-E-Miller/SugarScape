abstract class Sorter {

  public abstract void sort(ArrayList<Agent> al);

  //returns true iff a has less sugar than b
  public boolean lessThan(Agent a, Agent b) {
    if (a.getSugarLevel() < b.getSugarLevel()) {
      return true;
    } else {
      return false;
    }
  }
}

class BubbleSorter extends Sorter {

  public void sort(ArrayList<Agent> al) {

    if (al.size() > 1) {
      boolean noSwap = true;
      
      while (noSwap == true) { 
        noSwap = false;
        
        for (int i = 0; i < al.size()-1; i++) {
          
          if (lessThan(al.get(i+1), al.get(i)) == true) {
            Agent temp = al.get(i);
            al.set(i, al.get(i+1));
            al.set(i+1, temp);
            noSwap = true;
          }
        }
      }
    }
  }
}

class InsertionSorter extends Sorter{
  
  public void sort(ArrayList<Agent> al){
    
    if(al.size() > 1){
    for(int i = 0; i < al.size(); i++){
      int j = i;
      if(j == 0){
        break;
      }
      while(lessThan(al.get(j), al.get(j-1)) == true){
        Agent temp = al.get(j-1);
        al.set(j-1, al.get(j));
        al.set(j, temp);
        j--;
        if(j == 0){
          break;
          }
        } 
      } 
    }
  }  
}

class MergeSorter extends Sorter{
  ArrayList<Agent> aux;
  
  //calls mergeSorter on al
  public void sort(ArrayList<Agent> al){
    if(al.size() > 1){
    aux = new ArrayList<Agent>(al);
    sort(al, 0, al.size());
    }
  }
  
  public void sort(ArrayList<Agent> al, int start, int end){
    //if array has a length of 1
    if(end - start == 1) return;
    
    
    int middle = (start+end)/2;
    //sorts first half
    sort(al, start, middle);
    //sorts second half
    sort(al, middle, end);
    //joins both halves together
    merge(al, start, end);
  }
  
  private void merge(ArrayList<Agent> al, int start, int end){
    //copies segment into aux al
    for(int i = start; i < end; i++){
      aux.set(i, al.get(i));
    }
    
    int middle = (start+end)/2;
    int current = start;
    int i = start;
    int j = middle;
    
    while(i < middle && j < end){
      if(lessThan(aux.get(j), aux.get(i))){
        al.set(current++, aux.get(j++));
      }
      else{
        al.set(current++, aux.get(i++));
      }
    }
    
     if(i == middle){
       while(j < end){
         al.set(current++, aux.get(j++));
       }
     }
     if(j == end){
       while(i < middle){
         al.set(current++, aux.get(i++));
       }
     }
  }
}

class QuickSorter extends Sorter {
    
  /* shuffles an array and calls QuickSort 
  */
  public void sort(ArrayList<Agent> al) {
    if(al.size() > 1){
    Collections.shuffle(al);
    sort(al, 0, al.size()-1);
    }
  }
  
  /* QuickSort: sorts section of array from index lo to index hi
  *  finds the right place in the array for the 0th element; 
  *  calls itself recursively on the left and right sections
  */
  private void sort(ArrayList<Agent> al, int lo, int hi)
  {
    if (hi <= lo) return;
    int j = partition(al, lo, hi);
    sort(al, lo, j-1);
    sort(al, j+1, hi);
  }
  
  /* QuickSort Partition
  *
  *  @author Robert Sedgewick, Princeton U.
  *  @author Kevin Wayne, Princeton U.
  */
  private int partition(ArrayList<Agent> al, int lo, int hi) {
  int i = lo, j = hi+1;
  while (true) {
    while (lessThan(al.get(++i), al.get(lo))) {
      if (i == hi) break;
    }
    while (lessThan(al.get(lo), al.get(--j))) {
      if (j == lo) break;  
    }
    
    if (i >= j) break;
    exchange(al, i, j);
  }
  exchange(al, lo, j);
  return j;
  }
  
  /* Exchanges two elements of an arraylist
  */
  private void exchange(ArrayList<Agent> al, int i, int j) {
    Agent tmp = al.get(i);
    al.set(i, al.get(j));
    al.set(j, tmp);
  }
}