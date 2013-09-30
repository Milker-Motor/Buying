//
//  ElementsViewController.m
//  Buying
//
//  Created by a.lytvynov-bogdanov on 29.08.13.
//  Copyright (c) 2013 o.lytvynov-bogdanov. All rights reserved.
//

#import "ElementsViewController.h"

@interface ElementsViewController ()

@end

@implementation ElementsViewController
@synthesize mainScrollView;

- (void)viewDidLoad
{
    dbController = [[DataBaseController alloc] init];
    ScrollViewController *scrollView = [[ScrollViewController alloc] init];

    [dbController openDatabase];
    NSArray *arr = [[dbController returnArrayFromDataBase:@"Elements" arrayObjects:[NSArray arrayWithObjects:@"model", nil] exception:@"" valueException:@""] copy];
    NSLog(@"%@", arr);
    [scrollView addButtonWithImageOnScrollView:mainScrollView selfObject:self listButtons:arr];
    [dbController closeDatabase];
    arr = nil;
    dbController = nil;
    scrollView = nil;    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setMainWindow
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"BuyingViewControllerID"];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc animated:YES completion:NULL];
    sb = nil;
    vc = nil;
}

- (IBAction)cancelButtonUpInside:(id)sender
{
    [self setMainWindow];
}

-(void) buttonImageUpInside:(id) sender
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"ArticleViewControllerID"];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc animated:YES completion:NULL];
    sb = nil;
    vc = nil;
}

- (IBAction)takePhotoButtonUpInside:(id)sender
{
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        picker = [[UIImagePickerController alloc] init];
        picker.sourceType =  UIImagePickerControllerSourceTypeCamera;
        //picker.videoQuality = UIImagePickerControllerQualityTypeHigh;
        
        picker.delegate = self;
        picker.mediaTypes = [UIImagePickerController  availableMediaTypesForSourceType:picker.sourceType];
        [self presentModalViewController:picker animated:YES];
        picker = nil;
//        [self imagePickerController:picker didFinishPickingMediaWithInfo:];
    }
    else
    {
        NSLog(@"Ваше устройство не поддерживает эту функцию");
    }
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *) info
{
    NSLog(@"didFinishPickingMediaWithInfo");
    //определить медиа тип файла
    /*NSString* mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ( [ mediaType isEqualToString:@"public.image" ]) { //если файл — изображение
        // Берем изображение из информации словаря
        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        //получить путь к файлу
        NSURL* imagePath = (NSURL *)[info valueForKey:UIImagePickerControllerReferenceURL];
        NSString* chosed_imagePath = [imagePath path];
        //формируем file-data изображения
        NSData* imageData = UIImageJPEGRepresentation(image, 1.0);
    }else if ( [ mediaType isEqualToString:@"public.movie" ])
    { // пользователь снял видео
        NSString *moviePath = [[info objectForKey:UIImagePickerControllerMediaURL] path];
    }*/
}

@end
