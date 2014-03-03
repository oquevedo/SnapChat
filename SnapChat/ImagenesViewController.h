//
//  ImagenesViewController.h
//  SnapChat
//
//  Created by oquevedo on 25-02-14.
//  Copyright (c) 2014 SopaipillApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ImagenesViewController : UIViewController

@property(nonatomic,strong) PFObject *mensaje;
@property (weak, nonatomic) IBOutlet UIImageView *vistaImagen;


@end
