import java.util.Random; 

public class GuitarString {
    private final double decayFactor = .996;
    private final double sampleRate = 44100.00; 
    private RingBuffer newRingBuffer;
    private int theTicTimes = 0;
    private int desiredCapacity;
    private double whiteNoise; 
    private double fre; 

    //This method creates a guitar string of the given frequency, using a smapling rate of 44,100
    public GuitarString(double frequency) {
        this.fre = frequency; 
        //setting capacity we want with the right sample rate and frequency 
        this.desiredCapacity = (int) (sampleRate / fre);
        //calling that into ring buffer
        this.newRingBuffer = new RingBuffer(desiredCapacity);
        this.whiteNoise = 0;
        //calling helper method 
        bufferEnqueue();
    }

    //Method enqueues zero's/ helper method  
    public void bufferEnqueue() {
        int increment = 0;
        //while we are in range of capacity, zero out enqueue
        while (increment != desiredCapacity) {
            newRingBuffer.enqueue(0);
            increment++;
        }
    }

    // This method creates a guitar whose size and initial vaules are given by the array 
    public GuitarString(double[] init) {
      //store length of initial value 
        int initialValues = init.length;
        //call that in ringbuffer
        this.newRingBuffer = new RingBuffer(initialValues);
        //while loop to not get out of bouds of length of initial value 
        int increment = 0;
        while (increment != initialValues) {
            double incrementInitial = init[increment];
            //go to enqueue of buffer and pass increment value 
            newRingBuffer.enqueue(incrementInitial);
            increment++;
        }
    }
    
    //helper method used to get the sample 
    public double collectingSample(){
        //store dequeue in variable, do same with peek 
        double newDequeues = newRingBuffer.dequeue();
        double newPeeks = newRingBuffer.peek();
        //add them together store in variable
        double sample = (newDequeues + newPeeks);
        //return the sample 
        return sample; 
    }

    //This method advances the simulation one time step
    public void tic() {
      //store returned sample in variable 
        double sample = collectingSample(); 
        //get the average of the sample of dequeue and peeks 
        double average = ((sample) / 2);
        //multiply by decay factor
        newRingBuffer.enqueue(average * decayFactor);
        //increment the tics 
        theTicTimes++;
    }

    // This method returns the number of tics 
    public int time() {
        return theTicTimes;
    }

    //This method sets the buffer to white noise 
    public void pluck() {
        for(int i=0;i<desiredCapacity;i++){
            //getting rid of data in the ring buffer by emptying out enqueue        
            newRingBuffer.dequeue();           
            //adding white noise in range of .5 to -.5
            whiteNoise = -0.5 + Math.random();
            //store that white noise in enqueue
            newRingBuffer.enqueue(whiteNoise);
        }
    }

    //This method returns the current sample
    public double sample() {
        return newRingBuffer.peek();
    }
}