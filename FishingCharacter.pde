public class FishingCharacter {

    public static final int HITBOX_RADIUS = 200;

    private static final int STATIC = 0;
    private static final int DIVING = 1;
    private static final int CLIMBING = 2;
    private static final float DIVE_SPEED = 20.0;
    private final int DIVING_END = displayHeight - 700;
  
    public PVector position;
    public PVector originalPosition;

    private int state;
    private PImage[] animation;
    private PImage divingImage;
    private int animationState;
  
    public FishingCharacter(PVector position) {
        this.position = position;
        this.originalPosition = position.copy();
        this.animationState = 0;
        
        animation = new PImage[3];
        animation[0] = loadImage("FishBird_Fly0.png");
        animation[1] = loadImage("FishBird_Fly1.png");
        animation[2] = loadImage("FishBird_Fly2.png");
        animation[0].resize(400, 0);
        animation[1].resize(400, 0);
        animation[2].resize(400, 0);
        divingImage = loadImage("FishBird_Dive.png");
        divingImage.resize(400, 0);
    }
  
    public void integrate() {
        if (state == DIVING) {
            this.position.y += DIVE_SPEED;
            if (this.position.y > DIVING_END) {
                state = CLIMBING;
                this.position.y = DIVING_END;
            }
        } else if (state == CLIMBING) {
            this.position.y -= DIVE_SPEED;
            if (this.position.y < originalPosition.y) {
                state = STATIC;
                this.position.y = originalPosition.y;
            }
        }
    }
  
    public void draw() {
        pushMatrix();
        translate(position.x, position.y);
        if (state == DIVING) {
            animationState = 0;
            image(divingImage, -animation[0].width / 2, 0);
        } else {
            if (animationState % 24 < 6) {
                image(animation[0], -animation[0].width / 2, 0);
            } else if (animationState % 24 > 12 && animationState % 24 < 18) {
                image(animation[2], -animation[2].width / 2, 0);
            }
            else {
                image(animation[1], -animation[1].width / 2, 0);
            }
            animationState++;
        }
        popMatrix();
    }

    public void dive() {
        if (state == STATIC) {
            state = DIVING;
        } else if (state == DIVING) {
            state = CLIMBING;
        }
    }
}
