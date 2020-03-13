public class Trash {

    public static final int DIAMETER = 20;

    public PVector position;
    public PImage sprite;

    public Trash(PVector position, PImage image) {
        this.position = position;
        this.sprite = image;
    }

    public void integrate(float levelSpeed) {
        position.x -= levelSpeed;
    }

    public void draw() {
        image(sprite, position.x, position.y);
    }
}