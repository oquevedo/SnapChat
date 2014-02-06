//
//  SABuzonViewController.m
//  SnapChat
//
//  Created by oquevedo on 04-02-14.
//  Copyright (c) 2014 SopaipillApps. All rights reserved.
//

#import "SABuzonViewController.h"
#import <Parse/Parse.h>

@interface SABuzonViewController ()

@end

@implementation SABuzonViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
//    PFUser *usuarioActual = [PFUser currentUser];
   
    
    [self performSegueWithIdentifier:@"mostrarLogin" sender:self];  //Para que la app empiece de la pagina de login
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
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

- (IBAction)cerrarSesion:(id)sender {
    [PFUser logOut];
    [self performSegueWithIdentifier:@"mostrarLogin" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"mostrarLogin"]) {
        [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
    }
}
@end
