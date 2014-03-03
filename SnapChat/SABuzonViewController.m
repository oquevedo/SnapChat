//
//  SABuzonViewController.m
//  SnapChat
//
//  Created by oquevedo on 04-02-14.
//  Copyright (c) 2014 SopaipillApps. All rights reserved.
//

#import "SABuzonViewController.h"
#import "ImagenesViewController.h"

@interface SABuzonViewController ()

@end

@implementation SABuzonViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    PFUser *usuarioActual = [PFUser currentUser]; //Esto es para que el usurio se quede logueado
    if (usuarioActual) {
        NSLog(@"El usuario actual es %@", usuarioActual.username);
    }
    else{
    
    [self performSegueWithIdentifier:@"mostrarLogin" sender:self];  //Para que la app empiece de la pagina de login
}
}

-(void)viewWillAppear:(BOOL)animated  //Trayendo datos desde parse
{
    [super viewWillAppear:animated];  //Hacer referancia a la clase padre, siempre hay q ponerlo
 
    [self.navigationController.navigationBar setHidden:NO];
    
    PFQuery *query = [PFQuery queryWithClassName:@"mensajes"]; //Haciendo el query en la clase "mensajes"
    [query whereKey:@"destinatarioID" equalTo:[[PFUser currentUser]objectId]];//donde el destinario sea igual al usuriao actual
    [query orderByDescending:@"createdAt"]; //Me los muestra segun fueron mandados
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) { //Ejecutando el query
        if (error) {
            NSLog(@"Error: %@ %@",error, [error userInfo]);
        }
        else{
            self.mensajes = objects;
            [self.tableView reloadData];
            //NSLog(@"Mensajes recibidos : %d", [self.mensajes count]);
        }
    }]; 
     
     }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.mensajes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    PFObject *mensaje = [self.mensajes objectAtIndex:indexPath.row]; //Lo que vamos a mostar en la tabla 
    cell.textLabel.text = [mensaje objectForKey:@"nombreEnvia"];
    
    NSString *tipoArchivo = [mensaje objectForKey:@"tipoArchivo"];
    
   if([tipoArchivo isEqualToString:@"imagen"]){
        cell.imageView.image = [UIImage imageNamed:@"Photo.png"];
   }
    else{
       cell.imageView.image = [UIImage imageNamed:@"video.png"];
        }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.mensajeSeleccionado = [self.mensajes objectAtIndex:indexPath.row];
    NSString *tipoArchivo = [self.mensajeSeleccionado objectForKey:@"tipoArchivo"];  //para saber si el mensaje es video o foto
    
    if([tipoArchivo isEqualToString:@"imagen"]){
        [self performSegueWithIdentifier:@"mostrarImagenes" sender:self];
            }
    else{
        NSLog(@"lala");
            }
    
    NSMutableArray *destinatariosID = [NSMutableArray arrayWithArray:[self.mensajeSeleccionado objectForKey:@"destinatarioID"]];
    if ([destinatariosID count] == 1) {
        [self.mensajeSeleccionado deleteInBackground];
    }
    else
    {
        [destinatariosID removeObject:[[PFUser currentUser] objectId]];
        [self.mensajeSeleccionado setObject:destinatariosID forKey:@"destinatarioID"];
        [self.mensajeSeleccionado saveInBackground];
    }
    
    //Al apretar este metodo, me tiene que mostrar la foto que me mando mi amigo, por ense pasar a la vista echa para eso
    //Pedile a parse la foto
    //Cambiar de vista (viecontroller)
    //mostrar la foto en la vista
    //Sacar la foto de parse
    
}

- (IBAction)cerrarSesion:(id)sender {
    [PFUser logOut];
    [self performSegueWithIdentifier:@"mostrarLogin" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"mostrarLogin"]) {
        [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
    }
    else if ([segue.identifier isEqualToString:@"mostrarImagenes"])
    {
        [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
        ImagenesViewController *vistaImagenControlador = (ImagenesViewController *)segue.destinationViewController;
        vistaImagenControlador.mensaje = self.mensajeSeleccionado;
    }
}
@end
