import java.util.*; 

public class RingBuffer
{
    private double[] ringBuffer; 
    private int theBufferSize; 
    private int bufferFirst;
    private int bufferLast; 
    private int theSize; 
    private double addedItems;

    //This method is my constructor that shows the default values of my private variables 
    public RingBuffer(int capacity){
      //setting ringBuffer array to be as large as capacity
        this.ringBuffer = new double[capacity];
        this.theBufferSize = capacity; 
        this.bufferFirst = 0; 
        this.bufferLast = 0; 
        this.theSize =0;
        this.addedItems = 0; 
    }

    //This method returns number of items currently in the buffer
    public int size(){
        int increment = 0; 
        //while in range of buffersize we add to theSize variable to find the right amount of items 
        while (increment != theBufferSize){
            theSize++;            
            increment++;
        }
        return theSize; 
    }

    //This method shows if the buffer is empty (size equals zero)?
    public boolean isEmpty(){
        int increment = 0; 
        boolean isEmpty = false; 
        //while in range of buffersize we make sure that theSize is not empty, if it is then return true else we return false 
        while (increment != theBufferSize){
            if (this.theSize == 0){
                isEmpty = true;
            }            
            increment++;
        }
   
        return isEmpty; 
    }

    //This method shows if the buffer full  (size equals capacity)?
    public boolean isFull(){    
        int increment = 0; 
        boolean isFull = false; 
        //are we in range of bufferSize, if we are then make sure that we aren't full, if we are then return true, else false 
        while (increment != theBufferSize){
            if (this.theSize == this.theBufferSize){
                isFull = true; 
            }
            increment++;
        } 
        return isFull; 
    }

    //both methods below give exceptions for methods in dequeue, enqueue, peek  
    public void exceptionsOne(){
        throw new IllegalStateException("You are attempting to enqueue a full buffer");  
    }

    public void exceptionsTwo(){
        throw new NoSuchElementException("You are attempting to enqueue an empty buffer"); 
    }

    //This method adds item x to the end (as long as the buffer is not full)
    public void enqueue(double x){   
        if (isFull()){
          //call exception if we are too full in buffer 
            exceptionsOne();
        }
        else{ 
          //add the x variable given 
            addedItems = x; 
            //the store that in the last position of ringBuffer 
            ringBuffer[bufferLast] = addedItems;
            //make sure that we wrap around if needed, if we are at the end then last is now 0, else increment to get to next position 
            if (bufferLast == theBufferSize-1){
                bufferLast = 0;
            }
            else {
                bufferLast ++;  
            }
            //make sure to incrment the size too 
            theSize ++; 
        }
    }

    // This method deletes and return item from the front (as long as the buffer is not empty)
    public double dequeue() {
        double bufferFront = 0; 
        if (isEmpty()) {
            exceptionsTwo(); 
        }
        else {
          //same thing as method above but now with the first
            bufferFront = ringBuffer[bufferFirst];
            //if we need to wrap around, then if we are at the end of buffersize zero out first, else increment to next positino 
            if (bufferFirst == theBufferSize-1){
                bufferFirst = 0;
            }
            else {
                bufferFirst ++;  
            }
            //increment the size too 
            theSize--; 
        }
        //return the bufferfront at position of first 
        return bufferFront;
    }

    //Method that returns (but does not delete) item from the front of the buffer
    public double peek(){
        if (isEmpty()) {
          //throw excpetion if we are empty 
            exceptionsOne();
        }     
        //else just return ringBuffer at position first 
        return ringBuffer[bufferFirst];
    }    

    //Method that overrides toString and returns a String of the form [front, next, next, last] 
    public String toString(){
        int bufferSize = this.size();
        if (bufferSize == 0){
            return "[]";
        }
        int current = this.bufferFirst; 
        int capacity = this.theBufferSize; 
        String printing = "["+ringBuffer[current]; 
        int noOfEntriesAdded = 1;
        while(noOfEntriesAdded != bufferSize){ 
          //in case we need to wrap around, change first position to 0 if at end, else increment 
            if (current == theBufferSize-1){
                current = 0;
            }
            else {
                current ++;  
            }
            printing += ", " + ringBuffer[current];
            noOfEntriesAdded++;
        }
        return printing + "]"; 
    }
}