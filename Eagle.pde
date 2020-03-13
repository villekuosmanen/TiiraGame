import java.util.Random;

public class Eagle {

    public final int REACH = 380;
    public final int REACH_X_OFFSET = 400;
    public final int REACH_Y_OFFSET = 500;
    public final int DORMANT_RIGHT = 0;
    public final int DORMANT_LEFT = 3;
    public final int ATTACK_RIGHT = 1;
    public final int ATTACK_LEFT = 2;
    public final int ATTACK_SPEED = 45;

    public PVector position;

    private int framesSinceLastAttack;
    public int state;
    private PImage[] animation;
    private Random random;

    public Eagle() {
        this.position = new PVector(0, 0);
        this.state = DORMANT_RIGHT;
        this.animation = new PImage[2];
        this.animation[0] = loadImage("Eagle.png");
        this.animation[1] = loadImage("EagleMirror.png");
        this.random = new Random();
    }

    public void integrate(float levelSpeed) {
        if (state == DORMANT_RIGHT) {
            framesSinceLastAttack++;
            if (framesSinceLastAttack > 60 && random.nextInt(100) >= 90) {
                state = ATTACK_RIGHT;
                //Set pos
                int startHeight = random.nextInt(displayHeight / 2);
                this.position.y = startHeight - 500;
                this.position.x = displayWidth;
                framesSinceLastAttack = 0;
            }
        } else if (state == DORMANT_LEFT) {
            framesSinceLastAttack++;
            if (framesSinceLastAttack > 60 && random.nextInt(100) >= 90) {
                state = ATTACK_LEFT;
                //Set pos
                int startHeight = random.nextInt(displayHeight / 2);
                this.position.y = startHeight - 500;
                this.position.x = -800;
                framesSinceLastAttack = 0;
            }
        } else if (state == ATTACK_RIGHT) {
            position.y += levelSpeed;
            position.x -= ATTACK_SPEED;
            if (position.y > displayHeight || position.x < -800) {
                state = DORMANT_LEFT;
            }
        } else {
            position.y += levelSpeed;
            position.x += ATTACK_SPEED;
            if (position.y > displayHeight || position.x > displayWidth) {
                state = DORMANT_RIGHT;
            }
        }
    }

    public void draw() {
        if (state == ATTACK_RIGHT) {
            image(animation[0], position.x, position.y);
        } else if (state == ATTACK_LEFT) {
            image(animation[1], position.x, position.y);
        }
    }
}