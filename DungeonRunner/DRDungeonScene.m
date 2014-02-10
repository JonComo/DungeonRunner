//
//  DRDungeonScene.m
//  DungeonRunner
//
//  Created by Jon Como on 2/9/14.
//  Copyright (c) 2014 Jon Como. All rights reserved.
//

#import "DRDungeonScene.h"

#import "DRSprite.h"

#import "DRLight.h"
#import "DRPlayer.h"

@implementation DRDungeonScene
{
    DRPlayer *player;
}

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        self.backgroundColor = [SKColor colorWithRed:0 green:0 blue:0 alpha:1.0];
        
        _nodeCamera = [[SKNode alloc] init];
        [self addChild:_nodeCamera];
        
        player = [DRPlayer player];
        player.position = CGPointMake(size.width/2, size.height/2 - 20);
        player.zPosition = 1;
        [self.nodeCamera addChild:player];
        
        [self setupScene];
    }
    
    return self;
}

-(void)setupScene
{
    //Floor
    
    for (int i = 0; i<8; i++) {
        DRSprite *floor = [[DRSprite alloc] initWithTexture:[SKTexture textureWithImageNamed:@"floorBlock.png"]];
        
        floor.shouldScreenWrap = YES;
        floor.isDynamicallyLit = NO;
        
        floor.position = CGPointMake(i * floor.size.width, 0);
        
        [self.nodeCamera addChild:floor];
    }
    
    //Lights
    DRLight *light = [[DRLight alloc] initWithTexture:[SKTexture textureWithImageNamed:@"torch.png"]];
    
    light.position = CGPointMake(self.size.width/2, self.size.height/2);
    light.shouldScreenWrap = YES;
    light.isDynamicallyLit = NO;
    
    [self.nodeCamera addChild:light];
    
    light.lightColor = light.color;
}

-(void)screenWrapSprite:(DRSprite *)sprite
{
    if (sprite.position.x + sprite.size.width/2 + self.nodeCamera.position.x < 0){
        sprite.position = CGPointMake(sprite.position.x + sprite.size.width/2 + self.size.width, sprite.position.y);
    }
}

-(void)update:(CFTimeInterval)currentTime
{
    /* Called before each frame is rendered */
    
    for (DRSprite *sprite in self.nodeCamera.children){
        if ([sprite isKindOfClass:[DRSprite class]])
        {
            [sprite update:currentTime];
            
            if (sprite.shouldScreenWrap)
                [self screenWrapSprite:sprite];
        }
    }
    
    player.position = CGPointMake(player.position.x + 1, player.position.y);
    
    self.nodeCamera.position = CGPointMake((self.nodeCamera.position.x - player.position.x + self.size.width/2)/2, (self.nodeCamera.position.y - player.position.y + self.size.height/2)/2);
}

@end