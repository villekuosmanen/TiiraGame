public class Level4 extends FlyingScene {
    
    public Level4() {
        super();
        background = loadImage("Level4Back.jpg");
        background.resize(displayWidth, 0);
        levelSpeed = 17.0;
        backgroundSpeed = 0.7;
        endDistance = 25000;
        noOfGoodWinds = 30;
        noOfBadWinds = 20;

        generateLevel();
    }

    @Override
    protected void generateLevel() {
        super.generateLevel();
        playerCharacter.stamina = 80;
    }
}