public class LevelEagle extends FlyingScene {

    private Eagle eagle;
    
    public LevelEagle() {
        super();
        levelSpeed = 12.5;
        backgroundSpeed = 1.2;
        endDistance = 20000;
        noOfGoodWinds = 10;
        noOfBadWinds = 10;

        generateLevel();
    }

    @Override
    public void draw() {
        super.draw();   
        if (!paused && !died) {
            eagle.integrate(levelSpeed);
        }
        eagle.draw();
        if (eagle.state == eagle.ATTACK_LEFT || eagle.state == eagle.ATTACK_RIGHT) {
            PVector eagleHitPos = new PVector(eagle.position.x + eagle.REACH_X_OFFSET, eagle.position.y + eagle.REACH_Y_OFFSET);
            if (eagleHitPos.dist(playerCharacter.position) < eagle.REACH) {
                died = true;
            }
        }
    }

    @Override
    protected void generateLevel() {
        background = loadImage("LevelEagleBack.jpg");
        background.resize(displayWidth, 0);
        super.generateLevel();
        eagle = new Eagle();
    }
}