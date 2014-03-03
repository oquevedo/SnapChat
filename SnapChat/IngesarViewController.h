//
//  IngesarViewController.h
//  SnapChat
//
//  Created by oquevedo on 05-02-14.
//  Copyright (c) 2014 SopaipillApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IngesarViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *campoUsuario;
@property (weak, nonatomic) IBOutlet UITextField *campoContraseña;
- (IBAction)validarIngreso:(id)sender;
- (IBAction)cerrar:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imagenFondo;

-(void)logearUsuario;

@end
