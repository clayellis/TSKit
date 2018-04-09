//
//  This file is part of Tequila Apps SDK.
//  See the file LICENSE.txt for copying permission.
//

#import "ChannelViewController.h"
#import <TSKit/TSKit.h>


@interface ChannelViewController()

@property (nonatomic, strong) NSArray<TSUser*> *users;

@end

@implementation ChannelViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.client listUsersIn:self.client.currentChannel completion:^(NSArray<TSUser*> *users, NSError *error) {

        self.users = users;
        [self.tableView reloadData];

    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.users.count;
}

#pragma mark - UITAbleViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    TSUser *user = self.users[(NSUInteger) indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@%@", user.name, user.isMuted ? @" (muted)" : @""];
    return cell;
}

#pragma mark - UITAbleViewDataDelegate

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TSUser *user = self.users[indexPath.row];
    NSError *error;
    NSLog(@"Muting user: %@ mute: %@", user.name, @(!user.isMuted));
    BOOL success = [self.client muteUser:user mute:!user.isMuted error:&error];
    [self.tableView reloadData];
    if(!success) {
        NSLog(@"Failed to mute user: %@", user);
    }
}

#pragma mark - Public
-(void) addUser:(TSUser*) user
{
    NSLog(@"Adding user %@", user.name);
    self.users = [self.users arrayByAddingObject:user];
    [self.tableView reloadData];
}

-(void) removeUser:(TSUser *) user
{
    NSLog(@"Removing user %@", user.name);
    self.users = [self.users filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(TSUser *currentUser, NSDictionary *bindings) {
        return currentUser.uid != user.uid;
    }]];
    [self.tableView reloadData];
}

#pragma mark - Overrides

- (NSString *)title
{
    return self.client.currentChannel.name;
}


@end
