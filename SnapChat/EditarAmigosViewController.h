//
//  EditarAmigosViewController.h
//  SnapChat
//
//  Created by oquevedo on 06-02-14.
//  Copyright (c) 2014 SopaipillApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface EditarAmigosViewController : UITableViewController
@property(nonatomic,strong) NSArray *todosUsuarios;
@property(nonatomic,strong) PFUser *usuarioActual;
@property(nonatomic, strong) NSMutableArray *amigos;

-(BOOL) esAmigo:(PFUser *) usuario;

@end
