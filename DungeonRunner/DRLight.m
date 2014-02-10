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
    CGFloat red, green, blue;
    float flicker;
}

-(id)initWithTexture:(SKTexture *)texture
{
    if (self = [super initWithTexture:texture]) {
        //init
        
        self.isDynamicallyLit = NO;
    }
    
    return self;
}

-(void)setLightColor:(UIColor *)lightColor
{
    if (!_lightColor)
    {
        //get initial coloring
        [lightColor getRed:&red green:&green blue:&blue alpha:nil];
    }
    
    _lightColor = lightColor;
    
    if (!glow)
    {
        glow = [[SKSpriteNode alloc] initWithTexture:[SKTexture textureWithImageNamed:@"glow.png"] color:lightColor size:CGSizeMake(300, 300)];
        
        glow.alpha = 0.2;
        glow.position = self.position;
        glow.zPosition = 1000;
        glow.colorBlendFactor = 1;
        
        glow.blendMode = SKBlendModeAdd;
        
        DRDungeonScene *scene = (DRDungeonScene *)self.scene;
        [scene.nodeCamera addChild:glow];
    }
    
    glow.color = lightColor;
    self.color = lightColor;
    self.colorBlendFactor = 1;
}

-(void)update:(CFTimeInterval)currentTime
{
    DRDungeonScene *scene = (DRDungeonScene *)self.scene;
    
    if (self.position.x + scene.nodeCamera.position.x < -scene.size.width/2)
    {
        //remove
        [self removeFromParent];
        return;
    }
    
    glow.position = self.position;
    
    if (self.shouldFlicker && arc4random()%3 == 0){
        flicker = (0.5 - (float)(arc4random()%100)/100.0f) * 0.3;
    }
    
    for (DRSprite *sprite in scene.nodeCamera.children)
    {
        if (sprite == self || ![sprite isKindOfClass:[DRSprite class]] || !sprite.isDynamicallyLit) continue;
        
        [self lightSprite:sprite];
    }
}

-(void)lightSprite:(DRSprite *)sprite
{
    float distance = [JCMath distanceBetweenPoint:self.position andPoint:sprite.position sorting:NO];
    
    if (distance > 300) return;
    
    float divisor = (1+distance * 0.01);
    
    sprite.red += (red + flicker) / divisor;
    sprite.green += (green + flicker) / divisor;
    sprite.blue += (blue + flicker) / divisor;
}

-(void)removeFromParent
{
    [super removeFromParent];
    
    [glow removeFromParent];
    glow = nil;
}

@end
