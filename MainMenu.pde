public class MainMenu implements Scene {
  
  boolean playHighlighted = false;
  
  public void draw() {
    if (mouseX > displayWidth / 2 - 300 && 
        mouseX < displayWidth / 2 + 300 && 
        mouseY > displayHeight / 2 && 
        mouseY < displayHeight / 2 + 100) {
      playHighlighted = true;
    } else {
      playHighlighted = false;
    }
    
    fill(220);
    rect(displayWidth / 2 - 300, displayHeight / 2, 600, 100);
    
    fill(0);
    textSize(70);
    text("TIIRA", displayWidth / 2, displayHeight / 2 - 500);
    if (playHighlighted) {
      textSize(70);
    } else {
      textSize(50);
    }   
    textAlign(CENTER, CENTER);
    text("Play", displayWidth / 2, displayHeight / 2 + 50);
    
    if (mousePressed && (mouseButton == LEFT) && playHighlighted) {
      incrementScene();
    }
  }

  public void keyPressed() {
    //Not implemented in this scene
  }
  
  public void keyReleased() {
    //Not implemented in this scene
  }
}
