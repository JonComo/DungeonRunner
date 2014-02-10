//
//  DRSprite.m
//  DungeonRunner
//
//  Created by Jon Como on 2/9/14.
//  Copyright (c) 2014 Jon Como. All rights reserved.
//

#import "DRSprite.h"

#import "DRDungeonScene.h"

#import "JCMath.h"

@implementation DRSprite

-(id)initWithTexture:(SKTexture *)texture
{
    texture.filteringMode = SKTextureFilteringNearest;
    
    if (self = [super initWithTexture:texture]) {
        //init
        
        self.xScale = 3;
        self.yScale = 3;
        
        _isDynamicallyLit = YES;
        self.colorBlendFactor = 0.9;
    }
    
    return self;
}

-(void)update:(CFTimeInterval)currentTime
{
    DRDungeonScene *scene = (DRDungeonScene *)self.scene;
    
    for (DRSprite *sprite in scene.nodeCamera.children)
    {
        if (sprite == self || sprite.zPosition >=1000) continue;
        
    }
    
    [self calculateColor];
}

-(void)calculateColor
{
    if (!self.isDynamicallyLit){
        return;
    }
    
    self.color = [UIColor colorWithRed:self.red green:self.green blue:self.blue alpha:1];
    
    self.red = 0;
    self.blue = 0;
    self.green = 0;
}

-(void)setIsDynamicallyLit:(BOOL)isDynamicallyLit
{
    _isDynamicallyLit = isDynamicallyLit;
    
    self.colorBlendFactor = isDynamicallyLit ? 1 : 0;
}

@end