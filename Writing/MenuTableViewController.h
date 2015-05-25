//
//  MenuTableViewController.h
//  Writing
//
//  Created by xlx on 15/5/21.
//  Copyright (c) 2015年 xlx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Menu.h"


@interface MenuTableViewController : UITableViewController
@property (nonatomic,strong) NSManagedObjectContext   *managedObjectContext;
@property (nonatomic,strong) NSArray                  *requests;
/**
 *  文集名称以及密码
 */
@property (nonatomic,strong) NSString                 *secret;
@property (nonatomic,strong) NSString                 *menuName;
//


/**
 *  addMenu 组件用的宽和高
 */
@property (nonatomic,assign) CGFloat                  width;
@property (nonatomic,assign) CGFloat                  height;
//


/**
 *  addMenu 所需的UI组件
 */
@property (weak, nonatomic ) IBOutlet UIBarButtonItem          *addMenuButton;
@property (nonatomic,strong) UIView                   *Menu;
@property (nonatomic,strong) UITextField              *SecretString;
@property (nonatomic,strong) UITextField              *name;
//

/**
 *  encriptView 所需的UI组件
 */
@property (nonatomic,strong) UIView                   *encritView;
@property (nonatomic,strong) UITextField              *encriptInput;

@end
