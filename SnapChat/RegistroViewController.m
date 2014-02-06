//
//  RegistroViewController.m
//  SnapChat
//
//  Created by oquevedo on 05-02-14.
//  Copyright (c) 2014 SopaipillApps. All rights reserved.
//

#import "RegistroViewController.h"
#import <Parse/Parse.h>

@interface RegistroViewController ()

@end

@implementation RegistroViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)Registro:(id)sender {
    
    NSString *usuario = [self.campoUsuario.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //Para recibir lo que el usuraio escrbe en los textfield
    NSString *clave = [self.campoClave.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *email = [self.campoEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *confirmarClave = [self.campoConfrmarClave.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([usuario length] == 0 || [email length] == 0) {
        UIAlertView *alerta = [[UIAlertView alloc]initWithTitle:@"Hey!" message:@"Ingresa usuario y email correctamente" delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
        [alerta show];
    }
    
    if (![clave isEqualToString:confirmarClave]) {
        UIAlertView *alertaContraseña = [[UIAlertView alloc]initWithTitle:@"Hey!" message:@"Ingresa contraseña correctamente" delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertaContraseña show];
    }
    else
    {
        PFUser *nuevoUsuario = [PFUser user];
        nuevoUsuario.username = usuario;
        nuevoUsuario.email = email;
        nuevoUsuario.password = clave;
        
        [nuevoUsuario signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if(error) {
                UIAlertView *alertaMalCreado = [[UIAlertView alloc]initWithTitle:@"UPS!" message:[error.userInfo objectForKey:@"error"]
                                                                        delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertaMalCreado show];
            }
            else
            {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }];
        
    }
}
@end
