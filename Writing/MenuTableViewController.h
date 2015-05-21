//
//  MenuTableViewController.h
//  Writing
//
//  Created by xlx on 15/5/21.
//  Copyright (c) 2015年 xlx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Menu.h"
//#import <CoreData/CoreData.h>
@interface MenuTableViewController : UITableViewController
@property (nonatomic,strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic,strong) Menu                   *MenuObject;
@property (nonatomic,strong) NSArray                *requests;
@end
