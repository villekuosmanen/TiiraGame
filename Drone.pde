public class Drone {

    public final int RADIUS = 200;

    public PVector position;
    public PImage image;
    private float speed;

    public Drone(float x, float speed) {
        this.position = new PVector(x, 0);
        this.speed = speed;
        this.image = loadImage("Drone.png");
    }

    public void integrate(float levelSpeed) {
        position.y += speed + levelSpeed;
    }

    public void draw() {
        image(image, position.x - RADIUS, position.y);
    }
}