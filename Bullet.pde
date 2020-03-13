public class Bullet {

    private final float DOWN_SPEED = 20.0;
    private final int DIAMETER = 20;

    public PVector position;
    public PImage sprite;

    public Bullet(int x, int y, PImage image) {
        this.position = new PVector(x, y);
        this.sprite = image;
    }

    public void integrate(float levelSpeed) {
        position.y += DOWN_SPEED + levelSpeed;
    }

    public void draw() {
        image(sprite, position.x, position.y);
    }

}
