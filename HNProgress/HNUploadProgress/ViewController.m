//
//  ViewController.m
//  HNUploadProgress
//
//  Created by xydtech on 16/4/5.
//  Copyright © 2016年 wanghn. All rights reserved.
//

#import "ViewController.h"
#import "HNRingProgerss.h"
#import "UIView+HNCircleProgress.h"

@interface ViewController ()<UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet HNRingProgerss *ringProgerss;

@property (weak, nonatomic) IBOutlet UIButton *ringProgressBtn;

@property (weak, nonatomic) IBOutlet UIButton *uploadImageBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)ringProgressBegin:(id)sender {
    __block float progress = 0;
    self.ringProgerss.leftRingColor = @[[UIColor blueColor], [UIColor yellowColor]];
    self.ringProgerss.rightRingColor = @[[UIColor cyanColor], [UIColor purpleColor]];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t time = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(time, dispatch_walltime(NULL, 0), 0.5 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(time, ^{
        if (progress > 1) {
            dispatch_source_cancel(time);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.ringProgressBtn.enabled = YES;
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                self.ringProgressBtn.enabled = NO;
                [self.ringProgerss drawProgerss:progress];
            });
            progress+=0.05;
        }
    });
    dispatch_resume(time);
}


- (IBAction)circleProgressBtn:(UIButton *)btn {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"请选择图片来源" delegate:self cancelButtonTitle:@"返回" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择",@"拍照", nil];
    [sheet showInView:[UIApplication sharedApplication].keyWindow];
}


#pragma mark -- UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //获取点击按钮的标题
//    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if (buttonIndex == 1)//拍照
    {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
            imgPicker.delegate = self;
            imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imgPicker.modalPresentationStyle = UIModalPresentationOverCurrentContext;//iOS8后需要添加这个属性设置
            [self presentViewController:imgPicker animated:YES completion:^{
            }];
        }
    }else if(buttonIndex == 0)//从相册选择
    {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
            imgPicker.delegate = self;
            imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imgPicker.modalPresentationStyle = UIModalPresentationOverCurrentContext;//iOS8后需要添加这个属性设置
            [self presentViewController:imgPicker animated:YES completion:^{
            }];
        }
    }
    
}

//完成选择图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
  
    
    [picker dismissViewControllerAnimated:YES completion:^{
#warning 此处进行图片压缩也上传功能
        //添加到集合中
        UIImage * photo = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        NSData *data = UIImageJPEGRepresentation(photo, 0.01);
        
        UIImage *newImage = [UIImage imageWithData:data];
        [self.uploadImageBtn setBackgroundImage:newImage forState:UIControlStateNormal];
        [self.uploadImageBtn addProgressView];
//        [self.uploadImageBtn setInsideCircleColor:[UIColor colorWithRed:0 green:1 blue:0 alpha:0.6]];
//        [self.uploadImageBtn setOuterRingColor:[UIColor colorWithRed:1 green:0 blue:0 alpha:0.8]];
        [self.uploadImageBtn setType:HNCircleProgressTypeAdd];
        __block float progress = 0;
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_source_t time = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_source_set_timer(time, dispatch_walltime(NULL, 0), 0.5 * NSEC_PER_SEC, 0);
        dispatch_source_set_event_handler(time, ^{
            if (progress > 1) {
                dispatch_source_cancel(time);
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.uploadImageBtn removeProgressViewAnimated:YES];
                });
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.uploadImageBtn setProgress:progress];
                });
                progress+=0.05;
            }
        });
        dispatch_resume(time);
    }];
   
    
}


@end
