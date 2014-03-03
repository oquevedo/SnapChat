//
//  SAMenuPrincipal.m
//  SnapChat
//
//  Created by oquevedo on 06-02-14.
//  Copyright (c) 2014 SopaipillApps. All rights reserved.
//

#import "SAMenuPrincipal.h"

@interface SAMenuPrincipal ()

@end

@implementation SAMenuPrincipal


- (void)viewDidLoad
{
    [super viewDidLoad];

    if ([UIScreen mainScreen].bounds.size.height == 568) {
        _imagenFondo.image = [UIImage imageNamed:@"fotochatFondo-568h"];
    }

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}


@end
