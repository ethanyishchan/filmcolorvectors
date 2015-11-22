/*
Instructions on how to use this damn thing:
1) Copy code to processing IDE
2) Save
3) Output vectors will be produced at the Save folder as "out.txt"
FOR EACH MOVIE:
4) Open up movie in Netflix
5) Enter Length Of Movie in Below:
    int hr=1;
    int min=25;
    int sec=32;
   Note you may need to tune the 14432.6 value based on screen res
6) Pause Movie and move around Left/Right arrow till Keyframes get loaded
7) Align Keyframe to start of movie at 00:00
8) Press Play button on IDE
9) Click on program window
10) Hover on to bottom left corner of keyframe and press g (be careful not to click on netflix window. this program should be selecting suring all this)
11) Hover on top right corner of keyframe window and press g
12) Now careful click on your browser's window
13) When subtitles start quickly select the program window and then close it
14) out.txt should be created
*/

import java.awt.*;
import java.awt.Robot; //java library that lets us take screenshots
import java.awt.AWTException;
import java.awt.event.InputEvent;
import java.awt.event.MouseListener;
import java.awt.event.MouseEvent;
import java.awt.event.KeyEvent;
import java.awt.image.BufferedImage;
import java.awt.Rectangle;
import java.awt.Dimension;
import java.io.BufferedWriter;
import java.io.FileWriter;


Point mousepointer;
Robot robby; //creates object "robby" of robot class
int presses=0; //number of clicks since start of movie
int tlx=0; //snap of top-left MOUSEX
int tly=0; //snap of top-left MOUSEY
int brx=0; //snap of bottom-right MOUSEX
int bry=0; //snap of bottom-right  MOUSEY
float tlxf=tlx; //snap of top-left MOUSEX
float brxf=brx; //snap of top-left MOUSEY

// length of movie:
int hr=1;
int min=31;
int sec=50;
// calibration variable to tune based on width of browser:
float calibration = 9100;
// file name
String movieName = "TadTheLostExplorer";
String outFilename = movieName + ".txt";
int frameNo = 0;

// screen resolution:
int screenresx=1440;
int screenresy=900;

// is used to stop the capture at the end of the movie based on the length of the movie
int counter=0;
int maxCounter=(hr*3600+min*60+sec)/10;


void setup()
{
  size(250, 250); //window size (doesn't matter)
  frame.setResizable(true);
  try //standard Robot class error check
  {
    robby = new Robot();
  }
  catch (AWTException e)
  {
    println("Robot class not supported by your system!");
    exit();
  }
  
  /*
  for(int i=0; i<10; i++){
    appendTextToFile(outFilename, "Text " + i);
  }
  */
}

void draw()
{
  if(presses<1)println("Click on bottom-left corner");
  else if(presses<2) println("Click on top-right corner");
  else if((!focused) && (counter < maxCounter)){
    if (counter == 0) {
      frame.setSize(brx-tlx, bry-tly);
    }
    int pixel; //ARGB variable with 32 int bytes where
    //sets of 8 bytes are: Alpha, Red, Green, Blue
    float r=0;
    float g=0;
    float b=0;

    //get screenshot into object "screenshot" of class BufferedImage
    BufferedImage screenshot = robby.createScreenCapture(new Rectangle(new Dimension(screenresx,screenresy)));

    println((brx-tlx)+" "+(bry-tly));

    int i=0;
    int j=0;
    for(i=tlx;i<brx; i++){
      for(j=tly; j<bry;j++){
        pixel = screenshot.getRGB(i,j); //the ARGB integer has the colors of pixel (i,j)
        r = r+(int)(255&(pixel>>16)); //add up reds
        g = g+(int)(255&(pixel>>8)); //add up greens
        b = b+(int)(255&(pixel)); //add up blues
      }
    }
    r=r/((brx-tlx)*(bry-tly)); //average red
    g=g/((brx-tlx)*(bry-tly)); //average green
    b=b/((brx-tlx)*(bry-tly)); //average blue

    println((brx-tlx)+" "+(bry-tly));

    // Debug output
    background(r,g,b); //make window background average color
    //PImage pshot = new PImage(brx-tlx, bry-tly, PConstants.ARGB);
    PImage pshot = createImage(brx-tlx, bry-tly, ARGB);
    screenshot.getRGB(tlx, tly, pshot.width, pshot.height, pshot.pixels, 0, pshot.width);
    pshot.updatePixels();
    image(pshot, 0, 0);
    pshot.save(movieName + "/" + nf(frameNo,5) + ".tif");
    frameNo ++;
    
    // Append to file
    appendTextToFile(outFilename, r+" "+g+" "+b);
    
    // Select next keyframe and update window
    robby.keyPress(KeyEvent.VK_RIGHT);

    float inc=calibration/(hr*3600+min*60+sec);  // Denominator = length of movie(s)/10. eg: forerstgump:854
    tlxf += inc;
    brxf += inc;   
    tlx = int(tlxf);
    brx = int(brxf);
    counter++;
  }
}

void keyReleased() {
  if ((key == 'g') && (presses<2)) {
    mousepointer = MouseInfo.getPointerInfo().getLocation();
    println(mousepointer.x+" "+mousepointer.y);
    if(presses<1){tlx=mousepointer.x;bry=mousepointer.y;tlxf=tlx;}
    else if(presses<2){brx=mousepointer.x;tly=mousepointer.y;brxf=brx;}
    presses++;
  }
}


/**
 * Appends text to the end of a text file located in the data directory, 
 * creates the file if it does not exist.
 * Can be used for big files with lots of rows, 
 * existing lines will not be rewritten
 */
void appendTextToFile(String filename, String text){
  File f = new File(dataPath(filename));
  if(!f.exists()){
    createFile(f);
  }
  try {
    PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter(f, true)));
    out.println(text);
    out.close();
  }catch (IOException e){
      e.printStackTrace();
  }
}

/**
 * Creates a new file including all subfolders
 */
void createFile(File f){
  File parentDir = f.getParentFile();
  try{
    parentDir.mkdirs(); 
    f.createNewFile();
  }catch(Exception e){
    e.printStackTrace();
  }
}