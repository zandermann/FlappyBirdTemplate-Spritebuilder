#import "GamePlayScene.h"
#import "Character.h"
#import "Obstacle.h"

@implementation GamePlayScene

- (void)initialize

{
    // your code here
    
    character = (Character*)[CCBReader load:@"Character"];
    [physicsNode addChild:character];
    [self addObstacle];
    timeSinceObstacle = 0.0f;
    
}

-(void)update:(CCTime)delta
{
    // put update code here
    // Increment the time since the last obstacle was added
    timeSinceObstacle += delta; // delta is approximately 1/60th of a second
    
    // Check to see if two seconds have passed
    if (timeSinceObstacle > 2.0f)
    {
        // Add a new obstacle
        [self addObstacle];
        
        // Then reset the timer.
        timeSinceObstacle = 0.0f;
    }
    // move and loop the bushes
    for (CCNode *bush in _bushes) {
        // move the bush
        bush.position = ccp(bush.position.x -
                            (character.physicsBody.velocity.x * delta), bush.position.y);
        
        // if the left corner is one complete width off the screen,
        // move it to the right
        if (bush.position.x <= (-1 * bush.contentSize.width)) {
            bush.position = ccp(bush.position.x +
                                2 * bush.contentSize.width, bush.position.y);
        }
    }
    
    // move and loop the clouds
    for (CCNode *cloud in _clouds) {
        // move the cloud
        cloud.position = ccp(cloud.position.x -
                             (character.physicsBody.velocity.x * delta), cloud.position.y);
        
        // if the left corner is one complete width off the screen,
        // move it to the right
        if (cloud.position.x <= (-1 * cloud.contentSize.width)) {
            cloud.position = ccp(cloud.position.x +
                                 2 * cloud.contentSize.width, cloud.position.y);
        }
    }
}

// put new methods here

- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event {
    // this will get called every time the player touches the screen
    [character flap];
    
}

@end
