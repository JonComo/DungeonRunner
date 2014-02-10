//
//  DRSprite.h
//  DungeonRunner
//
//  Created by Jon Como on 2/9/14.
//  Copyright (c) 2014 Jon Como. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface DRSprite : SKSpriteNode

@property BOOL shouldScreenWrap;

@property float red, green, blue;
@property (nonatomic, assign) BOOL isDynamicallyLit;

-(void)update:(CFTimeInterval)currentTime;

@end