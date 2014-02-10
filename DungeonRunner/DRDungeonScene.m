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
    
    CGPoint genPoint;
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
        
        [self generateDungeonAtPoint:CGPointMake(0, 0)];
        [self generateDungeonAtPoint:CGPointMake(self.size.width, 0)];
    }
    
    return self;
}

-(void)generateDungeonAtPoint:(CGPoint)position
{
    genPoint = position;
    
    //Floor
    for (int i = 0; i<6; i++) {
        DRSprite *floor = [[DRSprite alloc] initWithTexture:[SKTexture textureWithImageNamed:@"floorBlock.png"]];
        
        floor.position = CGPointMake(position.x + i * floor.size.width + floor.size.width/2, position.y);
        
        [self.nodeCamera addChild:floor];
    }
    
    DRLight *light = [[DRLight alloc] initWithTexture:[SKTexture textureWithImageNamed:@"torch.png"]];
    
    light.position = CGPointMake(position.x + self.size.width/2, position.y + 150);
    [self.nodeCamera addChild:light];
    
    light.lightColor = [UIColor colorWithRed:0.9 green:0.7 blue:0 alpha:1];
}

-(void)update:(CFTimeInterval)currentTime
{
    /* Called before each frame is rendered */
    
    NSLog(@"children: %i", self.nodeCamera.children.count);
    
    if (player.position.x > genPoint.x)
    {
        [self generateDungeonAtPoint:CGPointMake(genPoint.x + self.size.width, genPoint.y)];
    }
    
    for (DRSprite *sprite in self.nodeCamera.children){
        if ([sprite isKindOfClass:[DRSprite class]])
        {
            [sprite update:currentTime];
        }
    }
    
    player.position = CGPointMake(player.position.x + 1, player.position.y);
    
    self.nodeCamera.position = CGPointMake((self.nodeCamera.position.x - player.position.x + self.size.width/2)/2, (self.nodeCamera.position.y - player.position.y + self.size.height/2)/2);
}

@end