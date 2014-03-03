//
//  RegistroViewController.h
//  SnapChat
//
//  Created by oquevedo on 05-02-14.
//  Copyright (c) 2014 SopaipillApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistroViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *campoUsuario;
@property (weak, nonatomic) IBOutlet UITextField *campoEmail;
@property (weak, nonatomic) IBOutlet UITextField *campoClave;
@property (weak, nonatomic) IBOutlet UITextField *campoConfrmarClave;
- (IBAction)Registro:(id)sender;
- (IBAction)cerrar:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imagenFondo;

@end
