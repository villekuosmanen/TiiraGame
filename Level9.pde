import java.util.List;
import java.util.ArrayList;

public class Level9 extends WaterScene {

    private List<Trash> trash;
    private int numberOfTrash;
    
    public Level9() {
        super();
        endDistance = 8000;
        levelSpeed = 8;
        numberOfFish = 4;
        numberOfTrash = 10;
        fishToCatch = 2;
        backgroundHeightOffset = -500;

        background = loadImage("Level9Back.jpg");
        background.resize(displayWidth + (endDistance / int(levelSpeed) + 500), 0);
        generateLevel();
    }

    public void draw() {
        fill(20, 20, 40);  //Water colour
        super.draw();
        for (Trash t: trash) {    
            if (!paused && !lostLevel) {
                t.integrate(levelSpeed);
            }
            t.draw();
            if (t.position.dist(player.position) < FishingCharacter.HITBOX_RADIUS) {
                lostLevel = true;
            }
        }
    }

    protected void generateLevel() {
        super.generateLevel();

        trash = new ArrayList<Trash>();
        PImage bottle = loadImage("bottle.png");
        PImage can = loadImage("can.png");

        for (int i = 0; i < numberOfTrash; i++) {
            int height = random.nextInt(150);
            int width = random.nextInt(endDistance);
            boolean isBottle = random.nextBoolean();
            if (isBottle) {
                trash.add(new Trash(new PVector(width + displayWidth, displayHeight - 700 + height), bottle));
            } else {
                trash.add(new Trash(new PVector(width + displayWidth, displayHeight - 700 + height), can));
            }
        }

        //Fake trash, too deep
        for (int i = 0; i < numberOfTrash; i++) {
            int height = random.nextInt(300);
            int width = random.nextInt(endDistance);
            boolean isBottle = random.nextBoolean();
            if (isBottle) {
                trash.add(new Trash(new PVector(width + displayWidth, displayHeight - 400 + height), bottle));
            } else {
                trash.add(new Trash(new PVector(width + displayWidth, displayHeight - 400 + height), can));
            }
        }
    }
}