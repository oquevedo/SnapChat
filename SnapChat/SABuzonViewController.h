//
//  SABuzonViewController.h
//  SnapChat
//
//  Created by oquevedo on 04-02-14.
//  Copyright (c) 2014 SopaipillApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>


@interface SABuzonViewController : UITableViewController <UIGestureRecognizerDelegate>

@property(nonatomic,strong) NSArray *mensajes;
@property(nonatomic,strong) PFObject *mensajeSeleccionado;

- (IBAction)cerrarSesion:(id)sender;


@end
