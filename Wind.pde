public class Wind {

    public static final int WIDTH = 350;

    public int bottom;
    public int top;
    public int left;
    public int right;
    public boolean isGoodWind;

    private int state;
    private PImage[] animation;

    public Wind(int x, int y, int length, boolean isGoodWind, PImage[] animation) {
        this.bottom = y;
        this.top = y - length;
        this.left = x - WIDTH / 2;
        this.right = x + WIDTH / 2;
        this.isGoodWind = isGoodWind;
        this.animation = animation;
    }

    public void integrate(float levelSpeed) {
        bottom += levelSpeed;
        top += levelSpeed;
    }

    public void draw() {
        if (state % 24 < 8) {
            image(animation[0], left, top);
        } else if (state % 24 < 16) {
            image(animation[1], left, top);
        } else {
            image(animation[2], left, top);
        }
        state++;
    }
}