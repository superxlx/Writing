
//  MenuTableViewController.m
//  Writing
//
//  Created by xlx on 15/5/21.
//  Copyright (c) 2015年 xlx. All rights reserved.
//

#import "MenuTableViewController.h"
#import "AppDelegate.h"
@interface MenuTableViewController ()

@end

@implementation MenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *appDlegate = [[UIApplication sharedApplication]delegate];
    self.managedObjectContext = [appDlegate managedObjectContext];
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Menu" inManagedObjectContext:_managedObjectContext];
//    self.MenuObject = [[Menu alloc]initWithEntity:entity insertIntoManagedObjectContext:_managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Menu"];
    NSArray *requests = [_managedObjectContext executeRequest:request error:nil];
    self.requests = [[NSArray alloc]init];
    self.requests = requests;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
   
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = @"123";
    return cell;
}

- (IBAction)addMenu:(id)sender {
    NSLog(@"add Menu");
    self.width = self.view.bounds.size.width*0.75;
    self.Menu = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.width)];
    self.Menu.layer.cornerRadius = 20;
    [self.Menu setBackgroundColor:[UIColor colorWithRed:((float) 254 / 255)
                                                green:((float) 240 / 255)
                                                 blue:((float) 195 / 255) alpha:1]];
    CGPoint cen = self.view.center;
    cen.y -= 100;
    self.Menu.center = cen;
    [[self view]addSubview:self.Menu];
    [self buildAddMenu:self.Menu];
    self.Menu.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        self.Menu.alpha = 1;
    }];
    
}
- (void)buildAddMenu:(UIView *)menu{
    self.height = menu.bounds.size.height/4;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    label.text = @"添加文集";
    label.font = [UIFont fontWithName:@"YuWeiYingBi" size:20];
    label.adjustsFontSizeToFitWidth = YES;
    label.textAlignment = NSTextAlignmentCenter;
    [menu addSubview:label];
    /**
     添加文集名称输入框
     */
    UITextField *name = [[UITextField alloc]initWithFrame:CGRectMake(10, self.height, self.width-20, self.height/2)];
    name.placeholder = @"文集名称";
    name.font = [UIFont fontWithName:@"YuWeiYingBi" size:20];
    name.borderStyle = UITextBorderStyleRoundedRect;
    [menu addSubview:name];
    /**
     加密按钮
     */
    UIButton *encript = [[UIButton alloc]initWithFrame:CGRectMake(0, 2*self.height, self.width, self.height-2)];
    [encript setTitle:@"加密" forState:normal];
    [menu addSubview:encript];
    [encript addTarget:self action:@selector(encription:) forControlEvents:UIControlEventTouchUpInside];
    [self patchSetBackground:encript];
    encript.font = [UIFont fontWithName:@"YuWeiYingBi" size:20];
    /**
     取消、保存 按钮
     */
    UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(0, 3*
                                                                 _height, _width/2-2, _height)];
    UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(_width/2+2, 3*_height, _width/2-2, _height)];
    [cancel setTitle:@"取消" forState:normal];
    [save setTitle:@"保存" forState:normal];
    [menu addSubview:cancel];
    [menu addSubview:save];
    [cancel addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [save addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    save.layer.cornerRadius = 20;
    [save setBackgroundColor:[UIColor colorWithRed:((float)183/255)
                                             green:((float)230/255)
                                              blue:((float)155/255) alpha:1]];
    cancel.layer.cornerRadius = 20;
    [cancel setBackgroundColor:[UIColor colorWithRed:((float)183/255)
                                             green:((float)230/255)
                                              blue:((float)155/255) alpha:1]];
    [self dobe:cancel number:1];
    [self dobe:save number:0];
    cancel.font = [UIFont fontWithName:@"YuWeiYingBi" size:20];
    save.font = [UIFont fontWithName:@"YuWeiYingBi" size:20];
    
    
    
}
/**
 *  一个逗比方法 补上四个小角
 *
 *  @param button <#button description#>
 *  @param namber <#namber description#>
 *  @param width  <#width description#>
 *  @param height <#height description#>
 */
- (void)dobe:(UIView *)button number:(int)namber{
    UIView *patch1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [self patchSetBackground:patch1];
    UIView *patch2 = [[UIView alloc]initWithFrame:CGRectMake(_width/2-22, 0, 20, 20)];
    [self patchSetBackground:patch2];
    UIView *patch3 = [[UIView alloc]initWithFrame:CGRectMake(namber*(_width/2-22), _height-20, 20, 20)];
    [self patchSetBackground:patch3];
    [button addSubview:patch1];
    [button addSubview:patch2];
    [button addSubview:patch3];
}
/**
 *  设置颜色
 *
 *  @param pat <#pat description#>
 */
- (void)patchSetBackground:(UIView *)pat{
    [pat setBackgroundColor:[UIColor colorWithRed:((float)183/255)
                                              green:((float)230/255)
                                               blue:((float)155/255) alpha:1]];
}
- (void)encription:(UIButton *)button{
    NSLog(@"encript");
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:nil animations:^{
        CGRect rect = CGRectMake(0, _height*2-2, _width/3, _height);
        button.frame = rect;
        [button setTitle:@"取消" forState:UIControlStateNormal];
    } completion:^(BOOL finished){
        _secret = [[UITextField alloc]initWithFrame:CGRectMake(_width/12*5, _height/4*9, 0, 0)];
        _secret.borderStyle = UITextBorderStyleRoundedRect;
        secret.placeholder = @"请输入密码";
        secret.font = [UIFont fontWithName:@"YuWeiYingBi" size:20];
        [self.Menu addSubview:secret];
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:nil animations:^{
            CGRect rect = CGRectMake(_width/12*5, _height/4*9, _width/2, _height/2);
            secret.frame = rect;
        } completion:^(BOOL finished) {
            
        }];
    }];
    [button removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(re:) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)re:(UIButton *)button{
    NSLog(@"reButton");
    CGRect rect = CGRectMake(0, 2*_height, _width, _height-2);
    [UIView animateWithDuration:0.5 animations:^{
        button.frame = rect;
        CGRect rect = CGRectMake(_width/12*5, _height/4*9, 0, 0);
        [UIView animateWithDuration:0.5 animations:^{
            _secret.frame = rect;
        }];
    } completion:^(BOOL finished) {
        [_secret removeFromSuperview];
    }];
    
    
}
- (void)cancel{
    NSLog(@"cancel");
    [UIView animateWithDuration:0.3 animations:^{
        self.Menu.alpha = 0;
    } completion:^(BOOL finished) {
        self.Menu.removeFromSuperview;
    }];
}
- (void)save{
    NSLog(@"save");
    [UIView animateWithDuration:0.3 animations:^{
        self.Menu.alpha = 0;
    } completion:^(BOOL finished) {
        self.Menu.removeFromSuperview;
    }];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
