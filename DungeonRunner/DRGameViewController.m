//
//  DRGameViewController.m
//  DungeonRunner
//
//  Created by Jon Como on 2/9/14.
//  Copyright (c) 2014 Jon Como. All rights reserved.
//

#import "DRGameViewController.h"

#import "DRDungeonScene.h"

@interface DRGameViewController ()
{
    DRDungeonScene *scene;
}

@end

@implementation DRGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    scene = [[DRDungeonScene alloc] initWithSize:CGSizeMake(self.view.bounds.size.height, self.view.bounds.size.width)];
    scene.scaleMode = SKSceneScaleModeAspectFit;
    
    SKView *view = (SKView *)self.view;
    
    [view presentScene:scene];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
