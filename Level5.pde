public class Level5 extends WaterScene {

    private BigFish bigFish;
    
    public Level5() {
        super();
        endDistance = 10000;
        levelSpeed = 12;
        numberOfFish = 12;
        fishToCatch = 4;
        backgroundHeightOffset = 0;

        background = loadImage("Level5Back.png");
        background.resize(0, displayHeight - 700);

        generateLevel();
    }

    public void draw() {
        fill(20, 50, 150);  //Water colour
        super.draw();
        if (!paused && !lostLevel) {
            bigFish.integrate();
        }
        bigFish.draw();
        if (bigFish.position.dist(player.position) < (FishingCharacter.HITBOX_RADIUS + 150)) {
            lostLevel = true;
        }
    }

    @Override
    protected void generateLevel() {
        super.generateLevel();
        bigFish = new BigFish(250);
    }
}