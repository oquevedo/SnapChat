//
//  CamaraViewController.h
//  SnapChat
//
//  Created by oquevedo on 07-02-14.
//  Copyright (c) 2014 SopaipillApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface CamaraViewController : UITableViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property(nonatomic,strong) UIImagePickerController *tomarImagen; //Variabel para tomar imagen
@property(nonatomic,strong) UIImage *imagen;
@property(nonatomic,strong) NSString *video;
@property(nonatomic,strong) PFRelation *amistad;
@property(nonatomic,strong) NSArray *amigos;
@property(nonatomic,strong) NSMutableArray *destinatarios;

- (IBAction)enviar:(id)sender;
- (IBAction)cancelar:(id)sender;

-(void)subirMensaje;
-(UIImage *)redimensionarImagen:(UIImage *)imagen conAncho:(float)ancho yAlto:(float)alto;

@end
