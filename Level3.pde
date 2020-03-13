public class Level3 extends FlyingScene {

    private boolean gameEnd = false;
    private boolean afterHit = false;
    private Drone drone;
    
    public Level3() {
        super();
        background = loadImage("Level3Back.jpg");
        background.resize(displayWidth, 0);
        levelSpeed = 14.0;
        backgroundSpeed = 0.7;
        endDistance = 30000;
        noOfGoodWinds = 15;
        noOfBadWinds = 25;

        generateLevel();
    }

    @Override
    public void draw() {
        super.draw();
        if (gameEnd) {
            drone.integrate(levelSpeed);
            drone.draw();
            if (afterHit) {
                playerCharacter.position.y += 5 * levelSpeed;
                if (playerCharacter.position.y > displayHeight) {
                    incrementScene();
                }
            } else {
                if (drone.position.dist(playerCharacter.position) < drone.RADIUS) {
                    afterHit = true;
                } if (drone.position.y > displayHeight) {
                    // This shouldn't happen
                    incrementScene();
                }
            }
        }
        
    }

    @Override
    protected void endGame() {
        if (!gameEnd) {
            gameEnd = true;
            playerCharacter.stamina = 20;
            // Create drone
            drone = new Drone(playerCharacter.position.x, 30.0);
        }
    }
}