//
//  ImagenesViewController.m
//  SnapChat
//
//  Created by oquevedo on 25-02-14.
//  Copyright (c) 2014 SopaipillApps. All rights reserved.
//

#import "ImagenesViewController.h"

@interface ImagenesViewController ()

@end

@implementation ImagenesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    PFFile *archivoImagen = [self.mensaje objectForKey:@"archivo"];  //Con esto descargamos el archivo (foto o video) desde parse, en mensaje esta guardado el mensaje que el usuruio quiere ver
    NSURL *URLimagen = [[NSURL alloc]initWithString:archivoImagen.url]; //Se crea una direccion de la imagen
    NSData *dataImegen = [NSData dataWithContentsOfURL:URLimagen]; //Creamos una variable que guarda toda la info de la imagen
    self.vistaImagen.image = [UIImage imageWithData:dataImegen];  //Lo mostramos en la vista
    
    NSString *enviaNombre = [self.mensaje objectForKey:@"nombreEnvia"];
    NSString *titulo = [NSString stringWithFormat:@"Mensaje enviado por %@",enviaNombre];
    self.navigationItem.title = titulo;
	
}



@end
