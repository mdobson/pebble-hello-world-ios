//
//  MSDViewController.m
//  PebbleHelloWorldMessage
//
//  Created by Matthew Dobson on 4/1/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import "MSDViewController.h"
#import <PebbleKit/PebbleKit.h>


@interface MSDViewController ()

@end

@implementation MSDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    PBWatch *watch = [[PBPebbleCentral defaultCentral] lastConnectedWatch];
    
    uuid_t myAppUUIDbytes;
    NSUUID *myAppUUID = [[NSUUID alloc] initWithUUIDString:@"53214973-072e-4828-837a-1382ad61cbc5"];
    [myAppUUID getUUIDBytes:myAppUUIDbytes];
    
    [[PBPebbleCentral defaultCentral] setAppUUID:[NSData dataWithBytes:myAppUUIDbytes length:16]];
    NSLog(@"Last connected watch: %@", watch);
    
    [watch appMessagesAddReceiveUpdateHandler:^BOOL(PBWatch *watch, NSDictionary *update){
        NSLog(@"Received message:%@", update);
        
        NSDictionary *reply = @{ @(0): @"Chat you back!" };
        [watch appMessagesPushUpdate:reply onSent:^(PBWatch *watch, NSDictionary *update, NSError *error){
            if (!error) {
                NSLog(@"Sent a reply successfully");
            } else {
                NSLog(@"Error sending messageL %@", error);
            }
        }];
        
        return YES;
    }];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendMsg:(id)sender {
    PBWatch *watch = [[PBPebbleCentral defaultCentral] lastConnectedWatch];
    uuid_t myAppUUIDbytes;
    NSUUID *myAppUUID = [[NSUUID alloc] initWithUUIDString:@"53214973-072e-4828-837a-1382ad61cbc5"];
    [myAppUUID getUUIDBytes:myAppUUIDbytes];
    
    [[PBPebbleCentral defaultCentral] setAppUUID:[NSData dataWithBytes:myAppUUIDbytes length:16]];
    NSLog(@"Last connected watch: %@", watch);
    NSDictionary *reply = @{ @(0): @(42) };
    [watch appMessagesPushUpdate:reply onSent:^(PBWatch *watch, NSDictionary *update, NSError *error){
        if (!error) {
            NSLog(@"Sent a reply successfully");
        } else {
            NSLog(@"Error sending messageL %@", error);
        }
    }];
}

@end
