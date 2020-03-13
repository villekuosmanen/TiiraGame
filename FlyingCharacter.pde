public class FlyingCharacter {
  
  private final float UP_SPEED = -20.0;
  private final float NONE_SPEED = -5.0;
  private final float DOWN_SPEED = 15.0;
  private final float LEFT_SPEED = -12.0;
  private final float RIGHT_SPEED = 12.0;
  
  public float stamina;
  public boolean inGoodWind;
  public boolean inBadWind;
  public PVector position;
  public Direction vertical;
  public Direction horizontal;

  private PImage[] animation;
  private int animationState;
  
  public FlyingCharacter(PVector position) {
    this.position = position;
    vertical = Direction.NONE;
    horizontal = Direction.NONE;

    animation = new PImage[3];
    animation[0] = loadImage("MainCharacter[-1].png");
    animation[1] = loadImage("MainCharacter.png");
    animation[2] = loadImage("MainCharacter[1].png");
    animation[0].resize(400, 0);
    animation[1].resize(400, 0);
    animation[2].resize(400, 0);
    stamina = 100;
  }
  
  public void integrate(float levelSpeed) {
    float forwardCost = 0.2;
    float steeringCost = 0.02;
    float restCost = -0.05;
    float bigRestCost = -0.5;
    
    if (horizontal == Direction.UP) {
        position = new PVector(position.x, position.y + UP_SPEED);
        stamina -= forwardCost;
    } else if (horizontal == Direction.DOWN) {
        position = new PVector(position.x, position.y + DOWN_SPEED);
        stamina -= bigRestCost;
    }
    if (vertical == Direction.LEFT) {
        position = new PVector(position.x + LEFT_SPEED, position.y);
        stamina -= steeringCost;
    } else if (vertical == Direction.RIGHT) {
        position = new PVector(position.x + RIGHT_SPEED, position.y);
        stamina -= steeringCost;
    }
    if (horizontal == Direction.NONE && vertical == Direction.NONE) {
        stamina -= restCost;
    }

    if (stamina > 100) {
        stamina = 100;
    }
    float speed_loss = levelSpeed;
    if (inGoodWind) {
        speed_loss = 0;
    } if (inBadWind) {
        speed_loss *= 2;
    }
    position = new PVector(position.x, position.y + speed_loss + NONE_SPEED);
  }
  
  public void draw() {
    pushMatrix();
    translate(position.x, position.y); 
    if (this.vertical == Direction.LEFT) {
      rotate(11 * PI / 6);
    } else if (this.vertical == Direction.RIGHT) {
      rotate(PI / 6);
    }
    if (animationState % 34 < 6) {
        image(animation[0], -animation[0].width / 2, 0);
    } else if (animationState % 34 > 12 && animationState % 34 < 24) {
        image(animation[2], -animation[2].width / 2, 0);
    }
    else {
        image(animation[1], -animation[1].width / 2, 0);
    }
    animationState++;
    popMatrix();
  }
}
