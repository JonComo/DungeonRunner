//
//  DRLight.m
//  DungeonRunner
//
//  Created by Jon Como on 2/9/14.
//  Copyright (c) 2014 Jon Como. All rights reserved.
//

#import "DRLight.h"

#import "DRDungeonScene.h"
#import "JCMath.h"

@implementation DRLight
{
    SKSpriteNode *glow;
}

-(void)setLightColor:(UIColor *)lightColor
{
    _lightColor = lightColor;
    
    glow = [[SKSpriteNode alloc] initWithTexture:[SKTexture textureWithImageNamed:@"glow.png"] color:self.color size:CGSizeMake(200, 200)];
    
    glow.alpha = 0.8;
    glow.position = self.position;
    glow.zPosition = 1000;
    glow.colorBlendFactor = 1;
    
    glow.blendMode = SKBlendModeAdd;
    
    DRDungeonScene *scene = (DRDungeonScene *)self.scene;
    [scene.nodeCamera addChild:glow];
}

-(void)update:(CFTimeInterval)currentTime
{
    glow.position = self.position;
    
    DRDungeonScene *scene = (DRDungeonScene *)self.scene;
    
    for (DRSprite *sprite in scene.nodeCamera.children)
    {
        if (sprite == self || ![sprite isKindOfClass:[DRSprite class]] || !sprite.isDynamicallyLit) continue;
        
        if (self.lightColor){
            [self lightSprite:sprite];
        }
    }
}

-(void)lightSprite:(DRSprite *)sprite
{
    if (!self.lightColor) return;
    if (!sprite.isDynamicallyLit) return;
    
    CGFloat lightR, lightG, lightB;
    
    [self.lightColor getRed:&lightR green:&lightG blue:&lightB alpha:nil];
    
    float distance = [JCMath distanceBetweenPoint:self.position andPoint:sprite.position sorting:NO] * 0.01;
    
    sprite.red += lightR / (1+distance);
    sprite.green += lightG / (1+distance);
    sprite.blue += lightB / (1+distance);
}

-(void)removeFromParent
{
    [glow removeFromParent];
    glow = nil;
}

@end
