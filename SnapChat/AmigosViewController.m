//
//  AmigosViewController.m
//  SnapChat
//
//  Created by oquevedo on 06-02-14.
//  Copyright (c) 2014 SopaipillApps. All rights reserved.
//

#import "AmigosViewController.h"
#import "EditarAmigosViewController.h"

@interface AmigosViewController ()

@end

@implementation AmigosViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
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
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"mostrarAmigos"]) {
        EditarAmigosViewController *viewController = (EditarAmigosViewController *)segue.destinationViewController;
        viewController.amigos = [NSMutableArray arrayWithArray:self.amigos];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    PFUser *usuario = [self.amigos objectAtIndex:indexPath.row];
    cell.textLabel.text = usuario.username;
    
    return cell;
}


@end
