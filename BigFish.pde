import java.util.Random;

public class BigFish {
    
    private final int DORMANT = 0;
    private final int ATTACK = 1;
    private final int RETREAT = 2;
    private final int ATTACK_SPEED = 20;
    public final int ATTACK_HEIGHT = displayHeight - 700;

    public PVector position;

    private int framesSinceLastAttack;
    private int animationState;
    private int state;
    private PImage[] animation;
    private Random random;

    public BigFish(int x) {
        this.position = new PVector(x, displayHeight - 100);
        this.animation = new PImage[2];
        this.animation[0] = loadImage("BigFish0.png");
        this.animation[1] = loadImage("BigFish1.png");
        this.random = new Random();
    }

    public void integrate() {
        if (state == DORMANT) {
            framesSinceLastAttack++;
            if (framesSinceLastAttack > 60 && random.nextInt(100) >= 90) {
                state = ATTACK;
                framesSinceLastAttack = 0;
            }
        } else if (state == ATTACK) {
            position.y -= ATTACK_SPEED;
            animationState++;
            if (position.y < ATTACK_HEIGHT) {
                state = RETREAT;
            }
        } else {
            animationState++;
            position.y += ATTACK_SPEED - 5;
            if (position.y > displayHeight - 100) {
                position.y = displayHeight - 100;
                state = DORMANT;
            }
        }
    }

    public void draw() {
        if (animationState % 16 < 8) {
            image(animation[0], position.x, position.y);
        } else {
            image(animation[1], position.x, position.y);
        }
    }
}