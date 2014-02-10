//
//  DRPlayer.m
//  DungeonRunner
//
//  Created by Jon Como on 2/9/14.
//  Copyright (c) 2014 Jon Como. All rights reserved.
//

#import "DRPlayer.h"

@implementation DRPlayer

+(DRPlayer *)player
{
    DRPlayer *player = [[DRPlayer alloc] initWithTexture:[SKTexture textureWithImageNamed:@"player.png"]];
    
    return player;
}

@end