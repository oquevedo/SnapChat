//
//  CamaraViewController.m
//  SnapChat
//
//  Created by oquevedo on 07-02-14.
//  Copyright (c) 2014 SopaipillApps. All rights reserved.
//

#import "CamaraViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>

@interface CamaraViewController ()

@end

@implementation CamaraViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.destinatarios = [[NSMutableArray alloc]init];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];  //Para que pase siempre
    self.amistad = [[PFUser currentUser] objectForKey:@"amistad"]; //Object for key, traeme la info fr eata columna
    
    PFQuery *query = [self.amistad query];
    [query orderByAscending:@"username"];   //Es una sentnencia para utilizar informacion de parse
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"%@ %@",error,[error userInfo]); //Descripcoin detallada del error
        }
        else{
            self.amigos = objects;
            [self.tableView reloadData]; //Recarga la info de la vista amigos
        }
    }];
    
    if (self.imagen ==  nil && [self.video length] == 0) {  //Este if es para que no se suban fotos o videos sin contenido
        
    
    self.tomarImagen = [[UIImagePickerController alloc]init];   //Inicializo la variable de instancia
    self.tomarImagen.delegate =self;  //El delegate sirve para saber donde vamos a mandar al usuario dp de tomar la foto
    self.tomarImagen.allowsEditing = NO;
    self.tomarImagen.videoMaximumDuration = 6;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.tomarImagen.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else{
        self.tomarImagen.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
        
    self.tomarImagen.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:self.tomarImagen.sourceType];
    [self presentViewController:self.tomarImagen animated:NO completion:Nil];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.amigos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  //Lo que se muestar en la tabla antes de hacer cualquier accion
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    PFUser *usuario = [self.amigos objectAtIndex:indexPath.row];
    cell.textLabel.text = usuario.username;
    
    if ([self.destinatarios containsObject:usuario.objectId]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  //Nos permite acceder a cualquier informacion al momento de apretar un celda (cuando apreto la celda)
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UITableViewCell *celda = [self.tableView cellForRowAtIndexPath:indexPath]; //Con celda tenemos el control del la celda seleccionada
    PFUser *usuario = [self.amigos objectAtIndex:indexPath.row];
    
    if (celda.accessoryType == UITableViewCellAccessoryNone) {
        celda.accessoryType = UITableViewCellAccessoryCheckmark;
        [self.destinatarios addObject:usuario.objectId];  //Se llama a objectId por que asi podemos acceder a toda la info del usuario
    }
    else{
        celda.accessoryType = UITableViewCellAccessoryNone;
        [self.destinatarios removeObject:usuario.objectId];
    }
}


#pragma mark - Almacenando datos

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker  //Para que se vaya a la vista del buzon
{
    [self dismissViewControllerAnimated:NO completion:Nil];
    [self.tabBarController setSelectedIndex:0];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info //Termino de ralizar la toma de datos y lo organiza en info
{
    NSString *tipoMedia = [info objectForKey:UIImagePickerControllerMediaType]; //Nos guarda el tipo de media que apreti el usuario
    
    if ([tipoMedia isEqualToString:(NSString *)kUTTypeImage]) {  //esto lo sacamos de la libreria que imporatamos y nos sirve para comparar tipo de media
        self.imagen = [info objectForKey:UIImagePickerControllerOriginalImage]; //Guarda la imagen que el usuario tomo con la camara
       
        if (self.tomarImagen.sourceType == UIImagePickerControllerSourceTypeCamera) {
            UIImageWriteToSavedPhotosAlbum(self.imagen, Nil, Nil, Nil);
        }
        [self dismissViewControllerAnimated:YES completion:nil];  //saca el viewcontroller actual
    }
    else {
        self.video = (NSString *)[[info objectForKey:UIImagePickerControllerMediaURL]path];  //Estamos convirtiendo el directorio a string
        
        if (self.tomarImagen.sourceType == UIImagePickerControllerSourceTypeCamera) {
            if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(self.video)){
                UISaveVideoAtPathToSavedPhotosAlbum(self.video, nil, nil, nil);
            }
        }
         [self dismissViewControllerAnimated:YES completion:Nil];
    }
}


- (IBAction)enviar:(id)sender {
    
    if (self.imagen == nil && [self.video length] == 0) {  //El largo del video es = 0 por que es un string (cadena)
        UIAlertView *alerta = [[UIAlertView alloc]initWithTitle:@"Vuelvelo a intentar MFQ" message:@"No sea wn y tome una foto o video para compartir" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alerta show];
        [self presentViewController:self.tomarImagen animated:NO completion:nil];  //Para que vuelva aparecer para sacar la foto
    } else {
        [self subirMensaje];
        [self.tabBarController setSelectedIndex:0];
        
    }
}

- (IBAction)cancelar:(id)sender {
    
    [self reiniciar];
    [self.tabBarController setSelectedIndex:0]; //Lo envia a la vista deseada
}

- (void)reiniciar {  //Reinicia la imagen, el video y el arreglo de destinatarios
    [self subirMensaje];
    self.imagen =nil;
    self.video = nil;
    [self.destinatarios removeAllObjects];
}

-(void)subirMensaje{
    
    NSData *data;
    NSString *nombreArchivo;
    NSString *tipoArchivo;
    
    //Hay que asegurarse que sea una imagen o video
    if (self.imagen != nil) {
        UIImage *nuevaImagen = [self redimensionarImagen:self.imagen conAncho:160 yAlto:480];
        data = UIImagePNGRepresentation(nuevaImagen);
        nombreArchivo = @"imagen.png";
        tipoArchivo = @"imagen";
    }
    else{
        data = [NSData dataWithContentsOfFile:self.video];
        nombreArchivo = @"video.mov";
        tipoArchivo = @"video";
    }
    
    PFFile *archivo = [PFFile fileWithName:nombreArchivo data:data];  //Convertimos nuestros datos en un archivo tipo parse
    [archivo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) { //Guradar el archivo en parse
        
        if (error) {
        UIAlertView *alerta = [[UIAlertView alloc]initWithTitle:@"Vuelvelo a intentar MFQ" message:@"No se wn y tome una foto o video para compartir" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alerta show];
        }                                       //Creamos o agregamos informacion a la "tabla" mensad=je
        else{
            PFObject *mensaje = [PFObject objectWithClassName:@"mensajes"];
            [mensaje setObject:archivo forKey:@"archivo"];
            [mensaje setObject:tipoArchivo forKey:@"tipoArchivo"];
            [mensaje setObject:self.destinatarios forKey:@"destinatarioID"];
            [mensaje setObject:[[PFUser currentUser]objectId] forKey:@"envioID"];
            [mensaje setObject:[[PFUser currentUser]username] forKey:@"nombreEnvia"];
            [mensaje saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (error) {
                    UIAlertView *alerta = [[UIAlertView alloc]initWithTitle:@"Vuelvelo a intentar MFQ" message:@"Manda tu wea denuevo" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alerta show];
                }
                else{
                    [self reiniciar];
                }
            }];
        }
    }];
    
    //Si es una imagen redimensionarlo
    //Subir el archivo
    //Subir la info del mensaje
}

-(UIImage *)redimensionarImagen:(UIImage *)imagen conAncho:(float)ancho yAlto:(float)alto
{
    CGSize nuevaMedida = CGSizeMake(ancho, alto);
    CGRect nuevoRectangulo = CGRectMake(0,0, alto, ancho);
    UIGraphicsBeginImageContext(nuevaMedida);
    [self.imagen drawInRect:nuevoRectangulo];
    UIImage *nuevaImagen = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return nuevaImagen;
    
}

@end
