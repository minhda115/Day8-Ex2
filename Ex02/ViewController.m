//
//  ViewController.m
//  Ex02
//
//  Created by Anh Minh on 3/24/13.
//  Copyright (c) 2013 FPT. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    CIImage *aCIImage;    
    CIFilter *filter;
    CIFilter *brightnessFilter;
    CIContext *context;
    CIImage *outputImage;
    UIImage *newUIImage;
    UIImage *currentUIImage;
}
@end

@implementation ViewController
@synthesize mySegment;
@synthesize mySlider;
@synthesize imagePlayer;

int seg = 0;
- (void)viewDidLoad
{
    mySegment.selectedSegmentIndex = 0;
    imagePlayer.image = [UIImage imageNamed:@"messi.JPG"];
    currentUIImage = [imagePlayer image];
   
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
- (void)viewDidUnload
{
    [self setImagePlayer:nil];
    [self setMySlider:nil];
    [self setMySegment:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
- (IBAction)changePlayer:(id)sender {
    seg = mySegment.selectedSegmentIndex;
    if (seg == 0){
        mySlider.value = 0;
        imagePlayer.image = [UIImage imageNamed:@"messi.JPG"];
        currentUIImage = [imagePlayer image];

    }else{
        mySlider.value = 0;
        imagePlayer.image = [UIImage imageNamed:@"ronaldo.JPG"];
        currentUIImage = [imagePlayer image];
    }
}
- (IBAction)changeBrightness:(id)sender {
    //Create CIImage
    CGImageRef aCGImage = currentUIImage.CGImage;
    aCIImage = [CIImage imageWithCGImage:aCGImage];
    
    //Create context
    context = [CIContext contextWithOptions:nil];
    
    //Create filters
    filter = [CIFilter filterWithName: @"CIExposureAdjust" keysAndValues: @"inputImage", aCIImage, nil];
    
    brightnessFilter = [CIFilter filterWithName:@"CIColorControls" keysAndValues: @"inputImage", aCIImage, nil];
    [brightnessFilter setValue:[NSNumber numberWithFloat:mySlider.value] forKey: @"inputBrightness"];
    outputImage = [brightnessFilter outputImage];
    CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
    newUIImage = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);
    [imagePlayer setImage:newUIImage];
    
   }

@end
