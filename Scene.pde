public interface Scene {

  /**
   * An entry point to the scene. Updates the scene by one frame
   */
  public void draw();
  
  /**
   * Methods for controls...
   */
  public void keyReleased();
  public void keyPressed();
}
