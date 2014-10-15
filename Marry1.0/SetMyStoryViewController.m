//
//  SetMyStoryViewController.m
//  Marry1.0
//
//  Created by Ibokan on 14-10-11.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import "SetMyStoryViewController.h"

@interface SetMyStoryViewController ()

@end

@implementation SetMyStoryViewController
@synthesize managedObjectContext;
 static BOOL isRegister =NO;
static int b = 1;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    b=1;
    self.managedObjectContext =  ((AppDelegate*)[UIApplication sharedApplication].delegate).managedObjectContext;
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    title.font =[UIFont boldSystemFontOfSize:18];//默认大小粗体字
    title.textColor = [UIColor whiteColor];
    title.text = @"我的故事";
    self.navigationItem.titleView = title;
    
    //创建故事按钮
    UIButton *storyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    storyBtn.frame = CGRectMake(0, 0, 30, 30);
    [storyBtn addTarget:self action:@selector(createStory) forControlEvents:UIControlEventTouchUpInside];
    [storyBtn setImage:[UIImage imageNamed:@"addStoryIcon"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:storyBtn];
    
    //返回按钮
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.frame = CGRectMake(0, 0, 10, 15);
    [back addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [back setImage:[UIImage imageNamed:@"back2"] forState:UIControlStateNormal];
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithCustomView:back];
    self.navigationItem.leftBarButtonItem = backBtn;
    
    //创建故事背景按钮
    UIButton *storyBacBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    storyBacBtn.tag = 111;
    [storyBacBtn setImage:[UIImage imageNamed:@"storybac3"] forState:UIControlStateNormal];
    storyBacBtn.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    [storyBacBtn addTarget:self action:@selector(createStory) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:storyBacBtn];
    
    
    titleArr = [[NSMutableArray alloc] init];
    imageArr = [[NSMutableArray alloc] init];
    timeArr = [[NSMutableArray alloc] init];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    if (b) {
        
       
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"StoryData"
                                                  inManagedObjectContext:self.managedObjectContext];
        [fetchRequest setEntity:entity];
        NSError *error=nil;
        NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
        for (StoryData *info in fetchedObjects) {
            [imageArr insertObject:[UIImage imageWithData:info.storyImage] atIndex:0];
            [titleArr insertObject:info.storyTitle atIndex:0];
            [timeArr insertObject:info.storyDate atIndex:0];
//            [imageArr addObject:[UIImage imageWithData:info.storyImage]];
//            [titleArr addObject:info.storyTitle];
//            [timeArr addObject:info.storyDate];
          //  NSLog(@"title: %@,date: %@", info.storyTitle,info.storyDate);
            
        }
        
        if (imageArr.count >0)
        {
            
            [self addStoryTableView];
            
            
            fix=0;
            isRegister = NO;
            
            
        }else
        {
            fix=1;
        }

        b=0;
    }
    
}
#pragma mark 返回上一页e
-(void)backAction
{
    MainTarBarViewController *main = [MainTarBarViewController sharedTarBarController];
    main.coustomTarBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 创建故事action
-(void)createStory
{
    storyAlertView = [[CustomIOS7AlertView alloc] init];
    
    //设置容器view
    [storyAlertView setContainerView:[self createStoryView]];
    
    [storyAlertView setButtonTitles:[NSMutableArray arrayWithObjects:@"取消", @"确定", nil]];
    [storyAlertView setDelegate:self];
    [storyAlertView setOnButtonTouchUpInside:^(CustomIOS7AlertView *alertView, int buttonIndex) {
        NSLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, (int)[alertView tag]);
        //[alertView close];
    }];
    [storyAlertView setUseMotionEffects:true];
    
    // And launch the dialog
    [storyAlertView show];
    
    

}
- (void)customIOS7dialogButtonTouchUpInside: (CustomIOS7AlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    NSLog(@"Delegate: Button at position %d is clicked on alertView %d.", (int)buttonIndex, (int)[alertView tag]);
    
    if (buttonIndex ==1)
    {
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateString=[dateFormatter stringFromDate:[NSDate date]];
        [timeArr insertObject:dateString atIndex:0];
        
        [titleArr insertObject:writeTitleTextField.text atIndex:0];
        [imageArr insertObject:alertImageView.image atIndex:0];
        
       
        StoryData *storyData = [NSEntityDescription
                                          insertNewObjectForEntityForName:@"StoryData"
                                          inManagedObjectContext:self.managedObjectContext];
        
        storyData.storyDate = [timeArr objectAtIndex:0];
        storyData.storyImage =  UIImagePNGRepresentation([imageArr objectAtIndex:0]);
        storyData.storyTitle = [titleArr objectAtIndex:0];
        NSError *error = nil;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
        
               if (titleArr.count>0 &&imageArr.count>0)
        {
            
            
            
            if (fix)
            {
                
                [self addStoryTableView];
                
                fix =0;
            }
            [storyTableView reloadData];
            [alertView close];
        }
        
}else if (buttonIndex==0)
    [alertView close];
}

#pragma mark 添加storyTableView
-(void)addStoryTableView
{
    storyTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStylePlain];
    [self.view addSubview:storyTableView];
    storyTableView.delegate =self;
    storyTableView.dataSource =self;
    [storyTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    //移除创建故事按钮
    UIButton *btn = (UIButton*)[self.view viewWithTag:111];
    [btn removeFromSuperview];
}
-(UIView*)createStoryView
{
    
   
    storyArertTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 250, 44*3)];
    storyArertTableView.layer.cornerRadius = 10;
    storyArertTableView.scrollEnabled = NO;
    storyArertTableView.delegate =self;
    storyArertTableView.dataSource =self;
   
    
    
    return storyArertTableView;
}
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == storyTableView)
    {
        return imageArr.count;
    }
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == storyTableView)
    {
        static NSString *identifier = @"CellCell";
        
        if (!isRegister)
        {
            UINib *nib = [UINib nibWithNibName:@"CreateStoryCell" bundle:[NSBundle mainBundle]];
            [tableView registerNib:nib forCellReuseIdentifier:identifier];
            isRegister = YES;
        }
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        UILabel *titleLabel = (UILabel*)[cell.contentView viewWithTag:11];
        UIImageView *imageView = (UIImageView*)[cell.contentView viewWithTag:12];
        titleLabel.text =[titleArr objectAtIndex:indexPath.row];
        
        CGSize newSize = CGSizeMake(KScreenWidth, 198);//（需要裁剪的size大小）
        UIGraphicsBeginImageContext(newSize);
        [[imageArr objectAtIndex:indexPath.row] drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
        UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        imageView.image = newImage;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
          UILabel *timeLabel = (UILabel*)[cell.contentView viewWithTag:13];
        timeLabel.text = [timeArr objectAtIndex:indexPath.row];
        
        return cell;

    }
    else
    {
        static NSString *identifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row==0)
        {
            writeTitleTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 10, 235, 30)];
            writeTitleTextField.placeholder = @"写个标题";
            [cell.contentView addSubview:writeTitleTextField];
        }
        else if (indexPath.row ==1)
        {
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(15, 20, 80, 20)];
            textField.enabled = NO;
            textField.placeholder = @"选个封面";
            [cell.contentView addSubview:textField];
            
            alertImageView = [[UIImageView alloc] initWithFrame:CGRectMake(250-90, 4, 80, 36)];
            alertImageView.image = [UIImage imageNamed:@"selectImage"];
            [cell.contentView addSubview:alertImageView];
        }
        else if (indexPath.row==2)
        {
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(15, 20, 80, 20)];
            textField.enabled = NO;
            textField.placeholder = @"是否公开";
            [cell.contentView addSubview:textField];
            
            UISwitch *Off = [[UISwitch alloc] initWithFrame:CGRectMake(250-60, 5, 60, 14)];
            [cell.contentView addSubview:Off];
            
        }
        
        return cell;

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == storyArertTableView)
    {
        return 44;
    }else
    {
        return 230;
    }
}
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == storyTableView) {
        
    }
    else
    {
        if (indexPath.row==0)
        {
            
        }
        else if (indexPath.row ==1)
        {
            
            JGActionSheetSection *section1 = [JGActionSheetSection sectionWithTitle:nil message:nil buttonTitles:@[@"图片库", @"摄像头"] buttonStyle:JGActionSheetButtonStyleDefault];
            JGActionSheetSection *cancelSection = [JGActionSheetSection sectionWithTitle:nil message:nil buttonTitles:@[@"取消"] buttonStyle:JGActionSheetButtonStyleRed];
            NSArray *sections = @[section1, cancelSection];
            
            JGActionSheet *sheet = [JGActionSheet actionSheetWithSections:sections];
            sheet.delegate = self;
            
            [section1 setButtonStyle:JGActionSheetButtonStyleGreen forButtonAtIndex:1];
            [section1 setButtonStyle:JGActionSheetButtonStyleGreen forButtonAtIndex:0];
            [sheet setButtonPressedBlock:^(JGActionSheet *sheet, NSIndexPath *indexPath) {
                [sheet dismissAnimated:YES];
            }];
            
            [sheet showInView:self.view animated:YES];
            
            storyAlertView.hidden  = YES;
            [writeTitleTextField resignFirstResponder];
            
        }
        else if (indexPath.row==2)
        {
            [writeTitleTextField resignFirstResponder];
        }

    }
}
#pragma mark JGActionSheetDelegate
- (void)actionSheet:(JGActionSheet *)actionSheet pressedButtonAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0)
    {
        if (indexPath.row==0)
        {
            UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                //pickerImage.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
                
            }
            pickerImage.delegate = self;
            pickerImage.allowsEditing = NO;
            [self presentViewController:pickerImage animated:YES completion:^{
                
            }];
            
            storyAlertView.hidden = YES;
        }//打开摄像头
        else if (indexPath.row==1)
        {
            //先设定sourceType为相机，然后判断相机是否可用（ipod）没相机，不可用将sourceType设定为相片库
            UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
                if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                }
            //sourceType = UIImagePickerControllerSourceTypeCamera; //照相机
            //sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //图片库
            //sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum; //保存的相片
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
            picker.delegate = self;
            picker.allowsEditing = YES;//设置可编辑
            picker.sourceType = sourceType;
            
            [self presentViewController:picker animated:YES completion:^{
                
            }];

            storyAlertView.hidden = YES;
        }
       
    }
}
#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [self dismissViewControllerAnimated:YES completion:^{
        storyAlertView.hidden = NO;
    }];
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo NS_DEPRECATED_IOS(2_0, 3_0)
{
    
    [self dismissViewControllerAnimated:YES completion:^{
        storyAlertView.hidden = NO;
        alertImageView.image = image;
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
