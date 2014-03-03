//
//  AmigosViewController.h
//  SnapChat
//
//  Created by oquevedo on 06-02-14.
//  Copyright (c) 2014 SopaipillApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface AmigosViewController : UITableViewController
@property (nonatomic,strong) PFRelation *amistad;
@property (nonatomic,strong) NSArray *amigos;

@end

