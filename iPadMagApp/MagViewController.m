//
//  MagViewController.m
//  iPadMagApp
//
//  Created by preet dhillon on 18/12/11.
//  Copyright (c) 2011 dhillon. All rights reserved.
//

#import "MagViewController.h"

@implementation MagViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


/*
 NSURL* pdfFileUrl = [NSURL fileURLWithPath:finalPath];
 CGPDFDocumentRef pdf = CGPDFDocumentCreateWithURL((CFURLRef)pdfFileUrl);
 CGPDFPageRef page;
 
 CGRect aRect = CGRectMake(0, 0, 70, 100); // thumbnail size
 UIGraphicsBeginImageContext(aRect.size);
 CGContextRef context = UIGraphicsGetCurrentContext();
 UIImage* thumbnailImage;
 
 
 NSUInteger totalNum = CGPDFDocumentGetNumberOfPages(pdf);
 
 for(int i = 0; i < totalNum; i++ ) {
 
 
 CGContextSaveGState(context);
 CGContextTranslateCTM(context, 0.0, aRect.size.height);
 CGContextScaleCTM(context, 1.0, -1.0);
 
 CGContextSetGrayFillColor(context, 1.0, 1.0);
 CGContextFillRect(context, aRect);
 
 
 // Grab the first PDF page
 page = CGPDFDocumentGetPage(pdf, i + 1);
 CGAffineTransform pdfTransform = CGPDFPageGetDrawingTransform(page, kCGPDFMediaBox, aRect, 0, true);
 // And apply the transform.
 CGContextConcatCTM(context, pdfTransform);
 
 CGContextDrawPDFPage(context, page);
 
 // Create the new UIImage from the context
 thumbnailImage = UIGraphicsGetImageFromCurrentImageContext();
 
 //Use thumbnailImage (e.g. drawing, saving it to a file, etc)
 
 CGContextRestoreGState(context);
 
 }
 
 
 UIGraphicsEndImageContext();    
 CGPDFDocumentRelease(pdf);
 */



-(UIImage *)thumbNailImageFromPdfWithName:(NSString *)stringName
{
//    NSURL* pdfFileUrl = [[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"%@.pdf",stringName] withExtension:nil];
//    CGPDFDocumentRef pdf = CGPDFDocumentCreateWithURL((CFURLRef)pdfFileUrl);
//    CGPDFPageRef pageRef = CGPDFDocumentGetPage(pdf, 1);
//    CGRect pageRect = CGPDFPageGetBoxRect(pageRef, kCGPDFCropBox);
//    
//    UIGraphicsBeginImageContext(pageRect.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextTranslateCTM(context, CGRectGetMinX(pageRect),CGRectGetMaxY(pageRect));
//    CGContextScaleCTM(context, 1, -1);  
//    CGContextTranslateCTM(context, -(pageRect.origin.x), -(pageRect.origin.y));
//    CGContextDrawPDFPage(context, pageRef);
//    
//    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return finalImage;
//    
    
    NSURL *pdfURL = [[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"%@.pdf",stringName] withExtension:nil];
    pdf = CGPDFDocumentCreateWithURL((CFURLRef)pdfURL);
    
    // Get the PDF Page that we will be drawing
    page = CGPDFDocumentGetPage(pdf, 1);
    CGPDFPageRetain(page);
    
    // determine the size of the PDF page
    CGRect pageRect = CGPDFPageGetBoxRect(page, kCGPDFMediaBox);
    pdfScale = 1;
    pageRect.size = CGSizeMake(pageRect.size.width*pdfScale, pageRect.size.height*pdfScale);
    
    
    // Create a low res image representation of the PDF page to display before the TiledPDFView
    // renders its content.
    UIGraphicsBeginImageContext(pageRect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // First fill the background with white.
    CGContextSetRGBFillColor(context, 1.0,1.0,1.0,1.0);
    CGContextFillRect(context,pageRect);
    
    CGContextSaveGState(context);
    // Flip the context so that the PDF page is rendered
    // right side up.
    CGContextTranslateCTM(context, 0.0, pageRect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    // Scale the context so that the PDF page is rendered 
    // at the correct size for the zoom level.
    CGContextScaleCTM(context, pdfScale,pdfScale);	
    CGContextDrawPDFPage(context, page);
    CGContextRestoreGState(context);
    
    UIImage *backgroundImage = UIGraphicsGetImageFromCurrentImageContext();

    return backgroundImage;
    //    CGPDFPageRef page;
//    
//    CGRect aRect = CGRectMake(0, 0, 200, 368); // thumbnail size
//    UIGraphicsBeginImageContext(aRect.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    UIImage* thumbnailImage;
//    
//    
//    NSUInteger totalNum = CGPDFDocumentGetNumberOfPages(pdf);
//    
//    for(int i = 0; i < totalNum; i++ ) {
//        
//        
//        CGContextSaveGState(context);
//        CGContextTranslateCTM(context, 0.0, aRect.size.height);
//        CGContextScaleCTM(context, 1.0, -1.0);
//        
//        CGContextSetGrayFillColor(context, 1.0, 1.0);
//        CGContextFillRect(context, aRect);
//        
//        
//        // Grab the first PDF page
//        page = CGPDFDocumentGetPage(pdf, i + 1);
//        CGAffineTransform pdfTransform = CGPDFPageGetDrawingTransform(page, kCGPDFMediaBox, aRect, 0, true);
//        // And apply the transform.
//        CGContextConcatCTM(context, pdfTransform);
//        
//        CGContextDrawPDFPage(context, page);
//        
//        // Create the new UIImage from the context
//        thumbnailImage = UIGraphicsGetImageFromCurrentImageContext();
//        
//        //Use thumbnailImage (e.g. drawing, saving it to a file, etc)
//        
//        CGContextRestoreGState(context);
//        
//    }
//    
//    
//    UIGraphicsEndImageContext();    
//    CGPDFDocumentRelease(pdf);
    
    //return thumbnailImage;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    self.navigationController.navigationBarHidden = YES;
    
    self.view.backgroundColor    = [UIColor blackColor];
    
    arrayPDFName = [[NSMutableArray alloc] initWithArray:[[NSArray alloc]initWithObjects:@"19_C",@"19_D",@"19_E",@"20_A",@"20_B",@"21_A",@"21_B",@"21_C",nil]];
    
    
    
    [scrllViewMag setContentSize:CGSizeMake(320+[arrayPDFName count]*210, 748)];
    
    scrllViewMag.pagingEnabled = YES;
    int incX = 320;
    for(int i=0;i<[arrayPDFName count];i++)
    {
        UIImageView *imageViewPdf = [[UIImageView alloc] initWithFrame:CGRectMake(incX, 200, 200, 368)];
        imageViewPdf.image = [self thumbNailImageFromPdfWithName:[arrayPDFName objectAtIndex:i]];
        [scrllViewMag addSubview:imageViewPdf];
        incX += 210;
//        PDFScrollView *sv = [[PDFScrollView alloc] initWithFrame:CGRectMake(incX, 0, 1024, 768) withName:@"testJacob-3"];
//        [scrllViewMag addSubview:sv];
//        incX += 1024;
    }
	
    //[[self view] addSubview:sv];
        [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

@end
