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
    _campoContraseña.delegate = self;
    _campoUsuario.delegate = self;
    //self.navigationItem.hidesBackButton = YES;
    
    if ([UIScreen mainScreen].bounds.size.height == 568) {
        _imagenFondo.image = [UIImage imageNamed:@"fotochatFondo-568h"];
    }
	
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];  //Esconder la barra superior
}

- (IBAction)validarIngreso:(id)sender {
    
    [self logearUsuario];
}

- (IBAction)cerrar:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField //para este metodo se usa los delegate
{
    [textField resignFirstResponder];
    if( _campoUsuario.selected)
    {
        
    }
    else{
    [self logearUsuario];
    }
    return TRUE;
}

-(void)logearUsuario
{
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
