public class Cutscene implements Scene {

    private PImage image;
    private String text;
    private int framesSinceStart;

    public Cutscene(PImage image, String text) {
        this.image = image;
        this.text = text;
        if (image != null) {
            image.resize(displayWidth, 0);
        }
    }

    public void draw() {
        framesSinceStart++;
        if (image != null) {
            image(image, 0, 0);
        }
        textSize(40);
        fill(0);
        textAlign(CENTER, CENTER);
        if (text != null) {
            text(text, displayWidth / 2, displayHeight / 2 - 500);
        }

        if (framesSinceStart > 4*60) {
            text("Press [SPACE] to continue.", displayWidth / 2, displayHeight - 500);
        }
    }

    public void keyPressed() {
        // Do nothing
    }

    public void keyReleased() {
        if (key == ' ') {
            incrementScene();
        }
    }
}