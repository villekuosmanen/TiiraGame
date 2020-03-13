import java.util.Random;
import java.util.List;
import java.util.ArrayList;

public abstract class FlyingScene implements Scene {

    protected int endDistance;
    protected int noOfGoodWinds;
    protected int noOfBadWinds;
    protected PImage background;
    protected float levelSpeed;
    protected float backgroundSpeed;
    protected FlyingCharacter playerCharacter;
    protected List<Bullet> bullets;
    protected Random random;
    protected boolean paused;
    protected boolean died;
    
    private List<Wind> winds;
    private float distance;
    private float backgroundDistance;
  
    public FlyingScene() {
        died = false;
        paused = false;
        random = new Random();
    }
  
    public void integrate() {
        checkCollisions();
        distance += levelSpeed;
        backgroundDistance += backgroundSpeed;

        playerCharacter.integrate(levelSpeed);
        for (Bullet bullet: bullets) {
            bullet.integrate(levelSpeed);
        }

        List<Wind> windsToDelete = new ArrayList<Wind>();
        for (Wind wind : winds) {
            wind.integrate(levelSpeed);
            if (wind.top > displayHeight) {
                windsToDelete.add(wind);
            }
        }
        winds.removeAll(windsToDelete);
        if (playerCharacter.stamina < 0 || playerCharacter.position.y > displayHeight) {
            died = true;
        }
        if (distance >= endDistance + displayHeight) {
            endGame();
        }
    }

    protected void endGame() {
        incrementScene();
    }
  
    public void draw() {
        if (!paused && !died) {
            integrate();
        }
        
        image(background, 0, -background.height + displayHeight + int(backgroundDistance));
        fill(150, 50, 50, 100);
        rect(0, 0, displayWidth / 4, displayHeight);
        rect(displayWidth / 4 + displayWidth / 2, 0, displayWidth, displayHeight);
        for (Wind wind : winds) {
            wind.draw();
        }
        for (Bullet bullet: bullets) {
            bullet.draw();
        }
        playerCharacter.draw();
        textSize(30);

        // Progress bar
        fill(255);
        text("Stamina: ", 200, 20);
        fill(150);
        rect(300, 5, 200, 30);
        fill(255, 0, 0);
        rect(300, 5, (playerCharacter.stamina / 100) * 200, 30);
        
        // Progress bar
        fill(255);
        text("Distance: ", 200, 60);
        fill(150);
        rect(300, 45, 200, 30);
        fill(0, 0, 255);
        rect(300, 45, distance / (endDistance + displayHeight) * 200, 30);
        if (died) {
            fill(255);
            textSize(70);
            text("You died. Press [R] to restart level.", displayHeight / 2, displayWidth / 2);
        }
    }
  
    public void keyReleased() {
        if (key == CODED) {
            if (keyCode == UP || keyCode == DOWN ) {
                playerCharacter.horizontal = Direction.NONE;
            }
            if (keyCode == LEFT || keyCode == RIGHT) {
                playerCharacter.vertical = Direction.NONE;
            }
        } else if (key == 'p') {
            paused = !paused;
        } else if (key == 'r') {
            if (died) {
                died = false;
                paused = false;
                generateLevel();
            }
        }
    }

    protected void generateLevel() {
        distance = 0;
        backgroundDistance = 0;
        playerCharacter = new FlyingCharacter(new PVector(displayWidth / 2, displayHeight / 2));
        winds = new ArrayList<Wind>();
        bullets = new ArrayList<Bullet>();

        PImage[] goodAnimation = new PImage[3];
        goodAnimation[0] = loadImage("GoodWind0.png");
        goodAnimation[1] = loadImage("GoodWind1.png");
        goodAnimation[2] = loadImage("GoodWind2.png");

        PImage[] badAnimation = new PImage[3];
        badAnimation[0] = loadImage("BadWind0.png");
        badAnimation[1] = loadImage("BadWind1.png");
        badAnimation[2] = loadImage("BadWind2.png");

        int numberOfSlots = endDistance / 1000;
        int[] goodWinds = new int[numberOfSlots];
        int[] badWinds = new int[numberOfSlots];
        for (int i = 0; i < noOfGoodWinds; i++) {
            goodWinds[random.nextInt(numberOfSlots)] += 1;
        }
        for (int i = 0; i < noOfBadWinds; i++) {
            badWinds[random.nextInt(numberOfSlots)] += 1;
        }

        for (int i = 0; i < goodWinds.length; i++) {
            int goods = goodWinds[i];
            int bads = badWinds[i];
            int total = goods + bads;
            int maxWidth = displayWidth - (displayWidth / 2) - (total * Wind.WIDTH);
            if (maxWidth < 0) {
                maxWidth = 1;
            }
            int startWidth = random.nextInt(maxWidth) + (displayWidth / 4);
            for (int k = 0; k < total; k++) {
                if (goods > 0) {
                    if (bads > 0) {
                        if (random.nextFloat() > 0.5) {
                            winds.add(new Wind(startWidth + (k * Wind.WIDTH), -i*1000, 1000, true, goodAnimation));
                            goods--;
                        } else {
                            winds.add(new Wind(startWidth + (k * Wind.WIDTH), -i*1000, 1000, false, badAnimation));
                            bads--;
                        }
                    } else {
                        winds.add(new Wind(startWidth + (k * Wind.WIDTH), -i*1000, 1000, true, goodAnimation));
                        goods--;
                    }
                } else {
                    winds.add(new Wind(startWidth + (k * Wind.WIDTH), -i*1000, 1000, false, badAnimation));
                    bads--;
                }
            }
        }
    }

    public void keyPressed() {
        if (key == CODED) {
            if (keyCode == UP) playerCharacter.horizontal = Direction.UP;
            else if (keyCode == DOWN) playerCharacter.horizontal = Direction.DOWN;
            else if (keyCode == LEFT) playerCharacter.vertical = Direction.LEFT;
            else if (keyCode == RIGHT) playerCharacter.vertical = Direction.RIGHT;
        }
    }

    private void checkCollisions() {
        playerCharacter.inGoodWind = false;
        playerCharacter.inBadWind = false;
        if (playerCharacter.position.x < displayWidth / 4 || playerCharacter.position.x > displayWidth / 4 + displayWidth / 2) {
            playerCharacter.inBadWind = true;
        } else {
            for (Wind wind : winds) {
                if (playerCharacter.position.x > wind.left && playerCharacter.position.x < wind.right
                        && playerCharacter.position.y > wind.top && playerCharacter.position.y < wind.bottom) {
                    if (wind.isGoodWind) {
                        playerCharacter.inGoodWind = true;
                    } else {
                        playerCharacter.inBadWind = true;
                    }
                }
            }
        }

        List<Bullet> bulletsToDelete = new ArrayList<Bullet>();
        for (Bullet bullet: bullets) {
            if (bullet.position.x > playerCharacter.position.x - 140 && bullet.position.x < playerCharacter.position.x + 140
                && bullet.position.y > playerCharacter.position.y && bullet.position.y < playerCharacter.position.y + 120) {
                died = true;
            }
        }
        bullets.removeAll(bulletsToDelete);
    }
}
