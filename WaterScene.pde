import java.util.Random;
import java.util.List;
import java.util.ArrayList;

public abstract class WaterScene implements Scene {

    protected int endDistance;
    protected float levelSpeed;
    protected int numberOfFish;
    protected int fishToCatch;
    protected PImage background;
    protected boolean lostLevel;
    protected int backgroundHeightOffset;
    protected Random random;
    protected FishingCharacter player;
    protected boolean paused;

    private List<Fish> fishes;
    private int fishCaught;
    private int distance;

    public WaterScene() {
        random = new Random();
    }

    public void integrate() {
        checkCollisions();
        distance += levelSpeed;

        player.integrate();
        List<Fish> fishToDelete = new ArrayList<Fish>();
        for (Fish fish : fishes) {
            fish.integrate(levelSpeed);
            if (fish.position.x < 0) {
                fishToDelete.add(fish);
            }
        }
        fishes.removeAll(fishToDelete);

        if (distance >= endDistance + displayWidth) {
            if (fishCaught >= fishToCatch) {
                incrementScene();
            } else {
                lostLevel = true;
            }
        }
    }

    public void draw() {
        if (!paused && !lostLevel) {
            integrate();
        }

        image(background, -(distance / levelSpeed), backgroundHeightOffset);
        rect(0, displayHeight - 700, displayWidth, displayHeight);
        for (Fish fish : fishes) {
            fish.draw();
        }
        player.draw();

        textSize(30);
        fill(0);
        text("Caught: " + fishCaught + "/" + fishToCatch, 200, 20);

        // Progress bar
        text("Distance: ", 200, 60);
        fill(150);
        rect(300, 45, 200, 30);
        fill(0, 0, 255);
        rect(300, 45, (float(distance) / (endDistance + displayWidth)) * 200, 30);
        if (lostLevel) {
            fill(0);
            textSize(70);
            text("You lost. Press [R] to restart level.", displayHeight / 2, displayWidth / 2);
        }
    }

    public void keyPressed() {
        if (key == 'p') {
            paused = !paused;
        } else if (key == 'r') {
            if (lostLevel) {
                lostLevel = false;
                paused = false;
                generateLevel();
            }
        }
    }

    public void keyReleased() {
        if (key == ' ') {
            player.dive();
        }
    }

    protected void generateLevel() {
        distance = 0;
        fishCaught = 0;
        player = new FishingCharacter(new PVector(250, 300));
        fishes = new ArrayList<Fish>();

        for (int i = 0; i < numberOfFish; i++) {
            int height = random.nextInt(150);
            int width = random.nextInt(endDistance);
            fishes.add(new Fish(new PVector(width + displayWidth, displayHeight - 700 + height)));
        }

        //Fake fish, too deep
        for (int i = 0; i < numberOfFish; i++) {
            int height = random.nextInt(300);
            int width = random.nextInt(endDistance);
            fishes.add(new Fish(new PVector(width + displayWidth, displayHeight - 400 + height)));
        }
    }

    private void checkCollisions() {
        List<Fish> fishToDelete = new ArrayList<Fish>();
        for (Fish fish : fishes) {
            if (fish.position.dist(player.position) < FishingCharacter.HITBOX_RADIUS) {
                fishToDelete.add(fish);
                fishCaught++;
            }
        }
        fishes.removeAll(fishToDelete);
    }
}
