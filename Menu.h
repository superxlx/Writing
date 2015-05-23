//
//  Menu.h
//  Writing
//
//  Created by xlx on 15/5/23.
//  Copyright (c) 2015年 xlx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Menu : NSManagedObject

@property (nonatomic, retain) NSNumber * encript;
@property (nonatomic, retain) NSString * menuName;
@property (nonatomic, retain) NSString * secret;

@end
