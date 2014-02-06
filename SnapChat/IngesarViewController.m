//
//  IngesarViewController.m
//  SnapChat
//
//  Created by oquevedo on 05-02-14.
//  Copyright (c) 2014 SopaipillApps. All rights reserved.
//

#import "IngesarViewController.h"
#import <Parse/Parse.h>

@interface IngesarViewController ()

@end

@implementation IngesarViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.navigationItem.hidesBackButton = YES;
	
}

- (IBAction)validarIngreso:(id)sender {
    
      NSString *usuario = [self.campoUsuario.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
      NSString *clave = [self.campoContraseña.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([usuario length] == 0) {
        UIAlertView *alerta = [[UIAlertView alloc]initWithTitle:@"Hey!" message:@"Ingresa el usuario correctamente" delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alerta show];
    }
    else{
        [PFUser logInWithUsernameInBackground:usuario password:clave block:^(PFUser *user, NSError *error) {  //Este es un thread que se corre paralelamente al otro codigo
            if(error) {
                UIAlertView *alertaMalCreado = [[UIAlertView alloc]initWithTitle:@"Lo sentimos!" message:[error.userInfo objectForKey:@"error"]
                                                                        delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertaMalCreado show];
            }
            else
            {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }];
        
        //Aca se ejecuta el coddigo secuencual que llevo normalmente
    }
}

@end
