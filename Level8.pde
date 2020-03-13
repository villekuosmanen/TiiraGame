public class Level8 extends FlyingScene {
    
    public Level8() {
        super();
        background = loadImage("Level8Back.jpg");
        background.resize(displayWidth, 0);
        levelSpeed = 12.0;
        backgroundSpeed = 1.5;
        endDistance = 30000;
        noOfGoodWinds = 20;
        noOfBadWinds = 0;

        generateLevel();
    }

    @Override
    protected void generateLevel() {
        super.generateLevel();
        PImage bulletImage = loadImage("Bullet.png");
        for (int i = 0; i < 80; i++) {
            // Generate bullets
            int y = random.nextInt(endDistance + 20000);    // A good enoug guess to when bullets should end
            int x = random.nextInt(displayWidth / 2);
            bullets.add(new Bullet(x + displayWidth / 4, -y, bulletImage));
        }
    }
}