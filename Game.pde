/**
 Game planning (required tasks)
 * Scene-by-scene sreenplay (each scene its own minigame)
 * Scene structure in code (finite state machine)
 *x Implement main menu for game, and its end screen
 *
 * Implement a generic scene to test navigating between scenes
 * Design each game scene (from game design POV)
 * Draw characters as they'd be rendered in-game
 * Implement bare-bones versions of scenes (MAIN TASK!! Split later!)
 * Implement transitions between scenes
 *
 * Write dialogue and character interactions for all scenes
 * Implement dialogue in scenes
 * Implement dialogue tree
 */

int currentSceneNumber = 0;
boolean cheatEnabled = true;    //EDIT THIS TO TOGGLE CHEATING
Scene currentScene;

void setup() {
  fullScreen();
  incrementScene();
  
}

void draw() {
  background(150);
  currentScene.draw();
}

public void keyPressed() {
  currentScene.keyPressed();
}

public void keyReleased() {
  if (cheatEnabled && key == '0') {
    incrementScene();
  }
  currentScene.keyReleased();
}

void incrementScene() {
  String text = null;
  switch (currentSceneNumber) {
    case 0:
      currentScene = new MainMenu();
      break;
    case 1:
      text = "It's time for my first migration. My family is a bit worried, but I assured them it will be just fine.\nFly in tailwinds to save energy, and try to avoid headwinds using the arrow keys. Adventure awaits!";
      currentScene = new Cutscene(null, text);
      break;
    case 2:
      currentScene = new Level1();
      break;
    case 3:
      text = "After making through the first challenge, it's time to catch the dinner.\nDive using the space bar, and try to catch as many fish as you can. Some fish swim too deep for you to catch them.";
      currentScene = new Cutscene(null, text);
      break;
    case 4:
      currentScene = new Level2();
      break;
    case 5:
      text = "It's my first night flight, but the lights of city underneath light the way. Hopefully everything will be fine.";
      currentScene = new Cutscene(null, text);
      break;
    case 6:
      currentScene = new Level3();
      break;
    case 7:
      text = "The drone hurt and knocked me off course. Will I ever see my family again?\nNow I have to find the way on my own. I think Antarctica was this way...";
      currentScene = new Cutscene(null, text);
      break;
    case 8:
      currentScene = new Level4();
      break;
    case 9:
      text = "It's time to eat, but these seas have fish larger than what I can catch.\nAvoid their hungry mouths while catching enough to keep out the hunger!";
      currentScene = new Cutscene(null, text);
      break;
    case 10:
      currentScene = new Level5();
      break;
    case 11:
      text = "This desert has favourable winds, but theres something else as well: poachers!\nAvoid their bullets to make it through.";
      currentScene = new Cutscene(null, text);
      break;
    case 12:
      currentScene = new Level8();
      break;
    case 13:
      text = "My dad told this lake used to be a stopover for all the birds flying this route.\nNow it smells of smoke, and is covered in waste. But I have no choice than eat here. ";
      currentScene = new Cutscene(null, text);
      break;
    case 14:
      currentScene = new Level9();
      break;
    case 15:
      text = "These shores look calm, but I can hear gunshots in the distance.\nI'm so hungry, but I have to push on...";
      currentScene = new Cutscene(null, text);
      break;
    case 16:
      currentScene = new Level10();
      break;
    case 17:
      text = "I'm almost home, just one more flight. I gotta make it through...";
      currentScene = new Cutscene(null, text);
      break;
    case 18:
      currentScene = new LevelEagle();
      break;
    case 19:
      currentScene = new Cutscene(loadImage("finalCutscene.png"), "Thanks for playing TIIRA!");
      break;
    case 20:
      currentScene = new GameEndScreen();
      break;
    default:
      currentSceneNumber = 0;
      currentScene = new MainMenu();
      break;	
  }
  currentSceneNumber++;
}
