public class Level1 extends FlyingScene {
    
    public Level1() {
        super();
        background = loadImage("Level1Back.jpg");
        background.resize(displayWidth, 0);
        levelSpeed = 14.0;
        backgroundSpeed = 1.2;
        endDistance = 25000;
        noOfGoodWinds = 20;
        noOfBadWinds = 5;

        generateLevel();
    }
}