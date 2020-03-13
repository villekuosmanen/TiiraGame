public class Level2 extends WaterScene {
    
    public Level2() {
        super();
        endDistance = 7000;
        levelSpeed = 8;
        numberOfFish = 10;
        fishToCatch = 3;
        backgroundHeightOffset = -700;

        background = loadImage("Level2Back.png");
        background.resize(displayWidth + (endDistance / int(levelSpeed) + 500), 0);

        generateLevel();
    }

    public void draw() {
        fill(20, 50, 150);  //Water colour
        super.draw();
    }
}