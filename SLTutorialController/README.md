# SLTutorialController

SLTutorialController is a class that manages the user's progression through
 a linear tutorial. We built it while adding a tutorial to a game we made for a client.
 
In this post, you'll learn what it can be used for, and how to use it!

# Tutorial Tutorial!

Say you have three stages in a tutorial: build a building, select a unit, and defeat an enemy.

First, you'd list the stages in SLTutorialController.h:

    typedef enum  {

    // ***** v EDIT THIS PART v *****
        SLTutorialBuildABuilding = 0,   // step 1, build a building
        SLTutorialSelectAUnit,          // step 2, select a unit
        SLTutorialDefeatAnEnemy,        // step 3, defeat an enemy
        SLTutorialComplete              // tutorial complete
    // ***** ^ EDIT THIS PART ^ *****

    } SLTutorialStage;
    
Next, whenever your player builds a building (at any stage), you add this line:

    [[SLTutorialController sharedController] tutorialStagePerformed:SLTutorialBuildABuilding];

Likewise, whenever your player selects a unit, you do this:

    [[SLTutorialController sharedController] tutorialStagePerformed:SLTutorialSelectAUnit];
    
Likewise for SLTutorialDefeatAnEnemy.

Calls to `-tutorialStagePerformed:` will ONLY move to the next tutorial stage if the tutorial is actually at that stage. This means your game logic code doesn't have to do a bunch of state checks on the tutorial, you just stick a `-tutorialStagePerformed:` at the right spots.

You can ask SLTutorialController for the tutorial's current state via the tutorialStage property:

    // put this in a method that updates the display
    if ([SLTutorialController sharedController].tutorialStage == SLTutorialBuildABuilding) {
        // display the "you should build a building now!" message
    }

SLTutorialController posts the SLTutorialStageUpdated notification whenever the tutorial state changes. This means that you can easily be notified when the state changes.

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tutorialStageUpdated:) name:SLTutorialStageUpdated object:nil];
    
    - (void)tutorialStageUpdated:(NSNotification*)notification {
        // update the tutorial display!
    }
    
SLTutorialController stores its data in NSUserDefaults, so it's remembered for you.