public class Level10 extends FlyingScene {
    
    public Level10() {
        super();
        background = loadImage("Level10Back.jpg");
        background.resize(displayWidth, 0);
        levelSpeed = 11.2;
        backgroundSpeed = 0.8;
        endDistance = 20000;
        noOfGoodWinds = 10;
        noOfBadWinds = 20;

        generateLevel();
    }

    @Override
    protected void generateLevel() {
        super.generateLevel();
        PImage bulletImage = loadImage("Bullet.png");
        for (int i = 0; i < 45; i++) {
            // Generate bullets
            int y = random.nextInt(endDistance + 10000);    // A good enough guess to when bullets should end
            int x = random.nextInt(displayWidth / 2);
            bullets.add(new Bullet(x + displayWidth / 4, -y, bulletImage));
        }
        playerCharacter.stamina = 50;
    }
}