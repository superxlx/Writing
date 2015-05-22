//
//  MenuTableViewController.h
//  Writing
//
//  Created by xlx on 15/5/21.
//  Copyright (c) 2015年 xlx. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <CoreData/CoreData.h>
@interface MenuTableViewController : UITableViewController
@property (nonatomic,strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic,strong) UIView                 *Menu;
@property (nonatomic,strong) NSArray                *requests;
@property (nonatomic,strong) NSString               *secret;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,strong) UITextField *secret;


@end
