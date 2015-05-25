
//  MenuTableViewController.m
//  Writing
//
//  Created by xlx on 15/5/21.
//  Copyright (c) 2015年 xlx. All rights reserved.
//

#import "MenuTableViewController.h"
#import "AppDelegate.h"
#import "XLX.h"
#import "essayTableViewController.h"
#import "AudioToolbox/AudioToolbox.h"
@interface MenuTableViewController ()

@end

@implementation MenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.width = self.view.bounds.size.width*0.75;
    self.height = self.width/4;
    
    /**
     设置状态栏为白色
     */
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    /**
     *  设置标题
     */
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"w";
    title.textColor = [UIColor colorWithRed:((float)253/255)
                                      green:((float)231/255)
                                       blue:((float)166/255) alpha:1];
    title.font = [UIFont fontWithName:@"Baskerville-SemiBolditalic" size:50];
    title.adjustsFontSizeToFitWidth = true;
    self.navigationItem.titleView = title;

    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"a.png" ] forBarMetrics:UIBarMetricsDefault];
    /**
     *  加载Menu数据
     */
    AppDelegate *appDlegate = [[UIApplication sharedApplication]delegate];
    _managedObjectContext = [appDlegate managedObjectContext];
    [self loadMenuData];
    [self.tableView setTableFooterView:[[UIView alloc]init]];
    self.tableView.backgroundColor = [UIColor colorWithRed:((float) 176 / 255)
                                                     green:((float) 250 / 255)
                                                      blue:((float) 252 / 255) alpha:1];
    
    
    
    /**
     将返回按钮设置为白色  无title
     */
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@""
                                   style:UIBarButtonItemStylePlain target:nil action:nil];
    [backButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setBackBarButtonItem:backButton];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}
/**
 *  加载文集data
 */
-(void)loadMenuData{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"Menu" inManagedObjectContext:_managedObjectContext];
    _requests = [_managedObjectContext executeFetchRequest:request error:nil];
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
   
    return [_requests count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Menu *object = _requests[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor colorWithRed:((float) 175 / 255)
                                           green:((float) 163 / 255)
                                            blue:((float) 226 / 255) alpha:1];
    UIImageView *headImage = (UIImageView *)[cell.contentView viewWithTag:1];
    UILabel *MenuName = (UILabel *)[cell.contentView viewWithTag:2];
    UILabel *essayCount = (UILabel *)[cell.contentView viewWithTag:3];
    UIImageView *secretImage = (UIImageView *)[cell.contentView viewWithTag:4];
    headImage.image = [UIImage imageNamed:@"WritingHead.png"];
    [headImage.layer setMasksToBounds:YES];
    [headImage.layer setCornerRadius:30];
    MenuName.text = object.menuName;
    MenuName.font = [UIFont fontWithName:@"YuWeiYingBi" size:30];
    essayCount.text = @"共三篇文章";
    essayCount.font = [UIFont fontWithName:@"YuWeiYingBi" size:15];
    if ((int)object.encript == 16) {
        secretImage.image = [UIImage imageNamed:@"locked"];
    }
    
    UITapGestureRecognizer *tapSingle = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headImageChange)];
    tapSingle.numberOfTapsRequired=1;
    tapSingle.numberOfTouchesRequired=1;
    [headImage addGestureRecognizer:tapSingle];
    
    
    return cell;
}
- (void)headImageChange{
    NSLog(@"123");
}
- (IBAction)addMenu:(id)sender {
    NSLog(@"add Menu");
    /**
     *  添加遮罩层，禁止滑动，禁止点击
     */
    [XLX insertLayout:self :self.view];
    [self lockMenu];
    [self cancelEdting];
    //

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
    /**
     *  初始化密码输入框
     *
     *  @return void
     */
    _SecretString = [[UITextField alloc]init];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    label.text = @"添加文集";
    label.font = [UIFont fontWithName:@"YuWeiYingBi" size:20];
    label.adjustsFontSizeToFitWidth = YES;
    label.textAlignment = NSTextAlignmentCenter;
    [menu addSubview:label];
    /**
     添加文集名称输入框
     */
    _name = [[UITextField alloc]initWithFrame:CGRectMake(10, self.height, self.width-20, self.height/2)];
    _name.placeholder = @"文集名称";
    _name.font = [UIFont fontWithName:@"YuWeiYingBi" size:20];
    _name.borderStyle = UITextBorderStyleRoundedRect;
    [menu addSubview:_name];
    /**
     加密按钮
     */
    UIButton *encript = [[UIButton alloc]initWithFrame:CGRectMake(0, 2*self.height, self.width, self.height-1)];
    [encript setTitle:@"加密" forState:normal];
    [menu addSubview:encript];
    [encript addTarget:self action:@selector(encription:) forControlEvents:UIControlEventTouchUpInside];
    [self patchSetBackground:encript];
    encript.font = [UIFont fontWithName:@"YuWeiYingBi" size:20];
    /**
     取消、保存 按钮
     */
    UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(0, 3*
                                                                 _height, _width/2-1, _height)];
    UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(_width/2+1, 3*_height, _width/2-1, _height)];
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
- (void)dobe:(UIView *)button number:(int)number{
    UIView *patch1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    patch1.backgroundColor = button.backgroundColor;
    UIView *patch2 = [[UIView alloc]initWithFrame:CGRectMake(_width/2-21, 0, 20, 20)];
    patch2.backgroundColor = button.backgroundColor;
    UIView *patch3 = [[UIView alloc]initWithFrame:CGRectMake(number*(_width/2-21), _height-20, 20, 20)];
    patch3.backgroundColor = button.backgroundColor;
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
        _SecretString = [[UITextField alloc]initWithFrame:CGRectMake(_width/12*5, _height/4*9, 0, 0)];
        _SecretString.borderStyle = UITextBorderStyleRoundedRect;
        _SecretString.placeholder = @"请输入密码";
        _SecretString.font = [UIFont fontWithName:@"YuWeiYingBi" size:20];
        [self.Menu addSubview:_SecretString];
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:nil animations:^{
            CGRect rect = CGRectMake(_width/12*5, _height/4*9, _width/2, _height/2);
            _SecretString.frame = rect;
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
            _SecretString.frame = rect;
        }];
    } completion:^(BOOL finished) {
        [_SecretString removeFromSuperview];
        [button removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
        [button addTarget:self action:@selector(encription:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"加密" forState:UIControlStateNormal];
    }];
    
    
}
/**
 *  addMenu  取消按钮
 */
- (void)cancel{
    NSLog(@"cancel");
    [UIView animateWithDuration:0.3 animations:^{
        self.Menu.alpha = 0;
    } completion:^(BOOL finished) {
        _Menu.removeFromSuperview;
        [self reAddMenu];
    }];
}
/**
 *  addMenu 保存按钮
 */
- (void)save{
    NSLog(@"save");
    [UIView animateWithDuration:0.3 animations:^{
        _secret = _SecretString.text;
        NSLog(@"%@",_secret);
        _menuName = _name.text;
        if ([_menuName length] == 0) {
            _menuName = @"文集";
        }
        self.Menu.alpha = 0;
    } completion:^(BOOL finished) {
        self.Menu.removeFromSuperview;
        [self SaveCoreData];
        [self reAddMenu];
    }];
}
- (void)SaveCoreData{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Menu" inManagedObjectContext:_managedObjectContext];
    Menu *MenuObject = [[Menu alloc]initWithEntity:entity insertIntoManagedObjectContext:_managedObjectContext];
    if ([_secret length] == 0) {
        MenuObject.encript = [[NSNumber alloc]initWithBool:NO];
    }else{
        MenuObject.encript = [[NSNumber alloc]initWithBool:YES];
        MenuObject.secret = _secret;
    }
    MenuObject.menuName = _menuName;
    [_managedObjectContext save:nil];
    [self loadMenuData];
    [self.tableView reloadData];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [_managedObjectContext deleteObject:_requests[indexPath.row]];
        [_managedObjectContext save:nil];
        [self loadMenuData];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
/**
 *  禁止tableview滚动，禁止addMenu按钮点击
 */
-(void)lockMenu{
    self.tableView.scrollEnabled = false;
    [self.addMenuButton setEnabled:false];
}
/**
 *  恢复tableview滚动  恢复addMenu按钮点击
 */
-(void) reAddMenu{
    self.tableView.scrollEnabled = YES;
    [self.addMenuButton setEnabled:YES];
    [[self.view viewWithTag:100] removeFromSuperview];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Menu *Menuindex = self.requests[indexPath.row];
    if ((int)Menuindex.encript != 16) {
        [self performSegueWithIdentifier:@"pushEssay" sender:self];
    }else{
        [XLX insertLayout:self :self.view];
        [self lockMenu];
        [self buildEncriptView];
        [self cancelEdting];
    }
}
-(void)cancelEdting{
    UITapGestureRecognizer *tapSingle = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    tapSingle.numberOfTapsRequired=1;
    tapSingle.numberOfTouchesRequired=1;
    [[self.view viewWithTag:100] addGestureRecognizer:tapSingle];
}
-(void)tap{
    [self.view endEditing:true];
}
-(void)buildEncriptView{
    _encritView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.width/2)];
    _encritView.backgroundColor = [UIColor colorWithRed:((float)36/255)
                                                 green:((float)46/255)
                                                  blue:((float)37/255) alpha:1];
    CGPoint cen = self.view.center;
    cen.y -=  100;
    _encritView.center = cen;
    _encritView.layer.cornerRadius = 20;
    _encritView.alpha = 0;
    [self.view addSubview:_encritView];
    _encriptInput = [[UITextField alloc]initWithFrame:CGRectMake(10, self.height/4, self.width-20, self.height/2)];
    _encriptInput.borderStyle = UITextBorderStyleRoundedRect;
    _encriptInput.placeholder = @"请输入密码";
    _encriptInput.font = [UIFont fontWithName:@"YuWeiYingBi" size:20];
    [_encritView addSubview:_encriptInput];
    
    UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(0, _height, _width/2-1, _height)];
    UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(_width/2+1, _height, _width/2-1, _height)];
    [cancel setBackgroundColor:[UIColor colorWithRed:((float)75/255)
                                              green:((float)91/255)
                                                blue:((float)82/255) alpha:1]];

    [save setBackgroundColor:[UIColor colorWithRed:((float)75/255)
                                            green:((float)91/255)
                                             blue:((float)82/255) alpha:1]];

    [cancel setTitle:@"取消" forState:normal];
    [save setTitle:@"确定" forState:normal];
    [cancel.layer setCornerRadius:20];
    [save.layer setCornerRadius:20];
    [self dobe:cancel number:1];
    [self dobe:save number:0];
    [cancel addTarget:self action:@selector(encriptCancel) forControlEvents:UIControlEventTouchUpInside];
    [save addTarget:self action:@selector(encriptSave) forControlEvents:UIControlEventTouchUpInside];
    cancel.titleLabel.font = [UIFont fontWithName:@"YuWeiYingBi" size:20];
    save.titleLabel.font = [UIFont fontWithName:@"YuWeiYingBi" size:20];
    [_encritView addSubview:cancel];
    [_encritView addSubview:save];
    [UIView animateWithDuration:0.3 animations:^{
        _encritView.alpha = 1;
    }];
}
-(void)encriptCancel{
    [UIView animateWithDuration:0.3 animations:^{
        _encritView.alpha=0;
    } completion:^(BOOL finished) {
        [_encritView removeFromSuperview];
        [self reAddMenu];
        [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:true];
    }];
}
-(void)encriptSave{
    NSString *secret = _encriptInput.text;
    int index = (int)self.tableView.indexPathForSelectedRow.row;
    NSString *rightSecret = ((Menu *)_requests[index]).secret;
    if ([secret  isEqual: rightSecret]) {
        [UIView animateWithDuration:0.3 animations:^{
            _encritView.alpha=0;
        } completion:^(BOOL finished) {
            [_encritView removeFromSuperview];
            [self reAddMenu];
        }];
        [self performSegueWithIdentifier:@"pushEssay" sender:self];
    }else{
        CABasicAnimation *shark = [CABasicAnimation animationWithKeyPath:@"position.x"];
        shark.fromValue = [NSNumber numberWithDouble:_encritView.center.x - 5];
        shark.toValue = [NSNumber numberWithDouble:_encritView.center.x + 5];
        shark.duration = 0.05;
        shark.repeatCount = 10;
        [_encritView.layer addAnimation:shark forKey:nil];
        _encriptInput.text = @"";
        _encriptInput.placeholder = @"密码错误";
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
}


@end
