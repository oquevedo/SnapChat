//
//  EditarAmigosViewController.m
//  SnapChat
//
//  Created by oquevedo on 06-02-14.
//  Copyright (c) 2014 SopaipillApps. All rights reserved.
//

#import "EditarAmigosViewController.h"

//Gestiona las relaciones entre amigos

@interface EditarAmigosViewController ()

@end

@implementation EditarAmigosViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated  //Metodo que se llama cuando la vista aparece
{
    PFQuery *query = [PFUser query];  //Se posiciona en la tabla user en parse
    [query orderByAscending:@"username"]; //Le dice como ordenar el resultado de la consulta
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) { //Lee los objetos que estan en parse
        if (error) {
            NSLog(@"Ocurrio este error: %@ %@",error, [error userInfo]);
        }
        else{
            self.todosUsuarios = objects;  //Guarda los objetos de la tabla user en el arreglo todosUsuarios
            [self.tableView reloadData]; //Muestra los usuarios en la tabla
        }
    }];
    
    self.usuarioActual = [PFUser currentUser];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [self.todosUsuarios count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    PFUser *usuario = [self.todosUsuarios objectAtIndex:indexPath.row]; //Se guarda el PFUser en la variable usuario
    cell.textLabel.text = usuario.username;   //solo se muestra el nombre
    
    
    if ([self esAmigo:usuario]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}


 //PROBLEMA no se actualiza la vista
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath //atrapa cualquier evento que surja una ves que es apretada por el usuario
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UITableViewCell *celda = [tableView cellForRowAtIndexPath:indexPath];  //Este metodo sirve para saber que celda se apreto 
    
    PFRelation *relacionAmistad = [self.usuarioActual relationForKey:@"amistad"];   //Se crea una relacion y se agrega en la columna amistad, si no existe la inventa
    PFUser *usuario = [self.todosUsuarios objectAtIndex:indexPath.row];  //Se guarda los datos del usuario en la variable usuario

    
    if ([self esAmigo:usuario]) {
        celda.accessoryType = UITableViewCellAccessoryNone;  //Si es amigo y lo apretamos se saca la marca
        
        for (PFUser *amigo in self.amigos) {
            if([amigo.objectId isEqualToString:usuario.objectId]){
                [self.amigos removeObject:amigo];         //Se borra de la lista de amigos
                break;
            }
        }
   
        [relacionAmistad removeObject:usuario];  //Se borra de parse
        
    } else {
        
        celda.accessoryType = UITableViewCellAccessoryCheckmark;
        [self.amigos addObject:usuario];
        [relacionAmistad addObject:usuario];  //Se agrega el objeto a la amistad
        
    }
    
    [self.usuarioActual saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
    if(error){
        NSLog(@"Error %@ %@", error, [error userInfo]);
            }
    }];
    
}

-(BOOL)esAmigo:(PFUser *)usuario  //Verifica si son amigos
{
    for (PFUser *amigo in self.amigos) {
        if([amigo.objectId isEqualToString:usuario.objectId]){
            return YES;
        }
    }
    return NO;
}

@end
