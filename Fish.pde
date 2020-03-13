public class Fish {

    public static final int DIAMETER = 20;

    public PVector position;
    public PImage sprite;

    public Fish(PVector position) {
        this.position = position;
        this.sprite = loadImage("Fish.png");
    }

    public void integrate(float levelSpeed) {
        position.x -= levelSpeed;
    }

    public void draw() {
        image(sprite, position.x, position.y);
    }
}