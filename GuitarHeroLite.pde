/***************************************************************************** 
 *  Dependencies: StdAudio.java GuitarString.java
 ****************************************************************************/
private boolean drawMe = false; 
private int numInputs = 150;
private double[] inputs;
StdAudio audio;     
GuitarString[] strings;
private int addedStrings = 37; 
String keyboard = "q2we4r5ty7u8i9op-[=zxdcfvgbnjmk,.;/' ";
private double frequencyRange = 1.05956;
private int forty = 440; 

void setup() {
  // Set the size of your screen here.
  background(255);
  size(500, 500);
  frameRate(1000);
  smooth(); 

  // Create this array.
  inputs = new double[numInputs];

  // Initialize the StdAudio
  audio = new StdAudio();

  strings = new GuitarString[addedStrings];
  //iterate through each string 
  for (int i = 0; i < addedStrings; i++) {
    //add frequency to the position i of string 
    strings[i] =  new GuitarString(forty*Math.pow(frequencyRange, i - 24));
  }
}

//method needed to have methods drawn 
void draw() { 
  soundArt(); 
  // Need to fill the inputs array with multiple samples. Let's use the
  // variables defined above for this.
  for (int i = 0; i < numInputs; ++i) {
    // Save each sample to an array.
    inputs[i] = getSingleSample();
  }
  // Play the samples we've collected.
  audio.play(inputs);
}

//this method gets a single sample 
double getSingleSample() {
  double thisSample = 0;        
  //iterate through the strings, addedStrings are 37 
  for (int j = 0; j < addedStrings; j++) {
    //stores in the sample the strings at position j
    thisSample += strings[j].sample();
    //tic string at the position of j 
    strings[j].tic();
  }
  return thisSample;
}

//This method gets the input from the user.
void keyPressed() {
  if (keyPressed == true) {   
    //gets the actual key from the user
    char input = key;  
    //finds the index of that key 
    int index =keyboard.indexOf(input); 
    //makes sure that input is in the right range 
    if (input >= 'a' && input <= 'z' && index !=-1) { 
      //we pluc, if we are at a position that is within range, so if user presses what we want, letters and in range of keyboard  
      strings[index].pluck();
      //set drawMe so we know to draw figure because key has been touched and approved 
      drawMe = true; 
    }
  }
}

//provides visualization of the sound produced by guitar
void soundArt() {
  if (drawMe) {
    //only filling with pretty colors of a light shade, eliminate darker shades 
    fill(random(150,255), random(150,255), random(150,255));
    Random random= new Random();
    //random numbers from range of 1 to 3 
    int shape = random.nextInt((3-1)+1)+1;
    if (shape == 1){
      //1 is triangle 
       triangle(random(500), random(500), random(500), random(500), random(500), random(500));
    }
    else if(shape ==2){
      //two is circle 
      ellipse(random(500), random(500), random(100), random(100));
    }
    else {
      //three is rectangle 
      rect(random(500), random(500), random(100), random(100));
    }  
  }
  //reset drawMe 
  drawMe=false; 
}
