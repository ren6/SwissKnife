//
//  SecondViewController.m
//  SwissKnife2
//
//  Created by renat on 05.11.13.
//  Copyright (c) 2013 renat. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()<UIActionSheetDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *button;
@end

@implementation SecondViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    for (UIView *view in self.view.subviews){
        [view removeFromSuperview];
    }
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 280, 280)];
    [self.view addSubview:self.imageView];
    self.imageView.backgroundColor = [UIColor colorWithRed:160/255.0f green:0 blue:0 alpha:1.0f];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    
    self.button = [UIButton buttonWithType:UIButtonTypeSystem];
    self.button.frame = CGRectMake(20, 20, 180, 20);
    [self.view addSubview:self.button];
    [self.button setTitle:@"Выбрать фотку" forState:UIControlStateNormal];
    [self.button setTitle:@"Выбрать фоточку" forState:UIControlStateHighlighted];
    self.button.center = CGPointMake(160, 350);
    // 3.5" - 320*480pt (640*960), 4.0" - 320*568 (640*1136)
    [self.button addTarget:self action:@selector(buttonTapped) forControlEvents:UIControlEventTouchUpInside];
    
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.imageView.image = image;
    
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex<=1){
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.sourceType = buttonIndex==0? UIImagePickerControllerSourceTypePhotoLibrary:UIImagePickerControllerSourceTypeCamera;
        
        controller.delegate = self;
        
        [self presentViewController:controller animated:YES completion:^{
        }];
        
        
        
    } else {
        
    }
}

-(void) buttonTapped{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Отмена" destructiveButtonTitle:nil
                                              otherButtonTitles:@"Выбрать из библиотеки",
                            @"Сфотографировать", nil];
    [sheet showInView:self.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
