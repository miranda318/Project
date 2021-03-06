//
//  ScanBarcodeViewController.m
//  Beauty
//
//  Created by Yingyi Yang on 7/23/15.
//  Copyright (c) 2015 QueensMan. All rights reserved.
//

#import "ScanBarcodeViewController.h"
#import "PlayerView.h"
#import "AmazonAPI.h"
#import "ProductReviewTableViewController.h"


@interface ScanBarcodeViewController () <AVCaptureMetadataOutputObjectsDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *rescanButton;
@property (weak, nonatomic) IBOutlet PlayerView *playerView;
// The following items will appear when scan barcode success
@property IBOutlet UIView *scanResultView;
@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *brandLabel;
@property (weak, nonatomic) IBOutlet PlayerView *ratingView;
@property (weak, nonatomic) IBOutlet PlayerView *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *reviewNumLabel;

@property AVCaptureSession* session;
@property AVCaptureDevice* device;
@property AVCaptureInput* input;
@property AVCaptureMetadataOutput* output;
@property AVCaptureVideoPreviewLayer* prevLayer;
@property UIView* highlightView;
@property UILabel* label;

@property NSString* upc;
@property NSDictionary * upcDic;
@property NSDictionary* viewDic;// this is the dic that passed to the next
@property BOOL finished;
@end

@implementation ScanBarcodeViewController

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    _highlightView = [[UIView alloc] init];
    _highlightView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _highlightView.layer.borderColor = [UIColor greenColor].CGColor;
    _highlightView.layer.borderWidth = 3;
    [self.view addSubview:_highlightView];
    
    _label = [[UILabel alloc] init];
    _label.frame = CGRectMake(0, self.view.bounds.size.height - 40, self.view.bounds.size.width, 40);
    _label.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    _label.backgroundColor = [UIColor colorWithWhite:0.15 alpha:0.65];
    _label.textColor = [UIColor whiteColor];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.text = @"(none)";
    [self.view addSubview:_label];
    
    _session = [[AVCaptureSession alloc] init];
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    
    _input = [AVCaptureDeviceInput deviceInputWithDevice:_device error:&error];
    if (_input) {
        [_session addInput:_input];
    } else {
        NSLog(@"Error: %@", error);
    }
    
    _output = [[AVCaptureMetadataOutput alloc] init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [_session addOutput:_output];
    
    _output.metadataObjectTypes = [_output availableMetadataObjectTypes];
    
    _prevLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _prevLayer.frame = self.view.bounds;
    _prevLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:_prevLayer];
    
    [_session startRunning];
    
    [self.view bringSubviewToFront:_highlightView];
    [self.view bringSubviewToFront:_label];
    
    
    
    
    //search on amazon
    
    //[self searchOnAmazon:nil];
}

-(void)viewDidAppear:(BOOL)animated{
    _finished = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Scan
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if(_finished){
        return;
    }
    
    CGRect highlightViewRect = CGRectZero;
    AVMetadataMachineReadableCodeObject *barCodeObject;
    NSString *detectionString = nil;
    NSArray *barCodeTypes = @[AVMetadataObjectTypeUPCECode, AVMetadataObjectTypeCode39Code, AVMetadataObjectTypeCode39Mod43Code,
                              AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode93Code, AVMetadataObjectTypeCode128Code,
                              AVMetadataObjectTypePDF417Code, AVMetadataObjectTypeQRCode, AVMetadataObjectTypeAztecCode];
    
    for (AVMetadataObject *metadata in metadataObjects) {
        for (NSString *type in barCodeTypes) {
            if ([metadata.type isEqualToString:type])
            {
                barCodeObject = (AVMetadataMachineReadableCodeObject *)[_prevLayer transformedMetadataObjectForMetadataObject:(AVMetadataMachineReadableCodeObject *)metadata];
                highlightViewRect = barCodeObject.bounds;
                detectionString = [(AVMetadataMachineReadableCodeObject *)metadata stringValue];
                break;
            }
        }
        
        if (detectionString != nil)
        {
            _upc = detectionString;
            _label.text = detectionString;
            
            //search on amazon
            [self searchOnAmazon:_upc];
            
            
            _finished = YES;
            break;
        }
        else{
            _label.text = @"(none)";
            _upc = @"none";
        }
        
    }
   // NSLog(@"%@",_upc);
    _highlightView.frame = highlightViewRect;
    
}


-(void)searchOnAmazon:(NSString*)upc{
    
    upc = [upc substringFromIndex:1];
    _upcDic = [AmazonAPI getProductInfoFromUPC:upc];
    
    _viewDic = [self readDic];
    
    if(_viewDic == nil){
        //did not find it
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Unable to find the product. Please try again later." preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        _finished = NO;
    }else{
    
        [self performSegueWithIdentifier:@"toProductDetailbyScan" sender:self];
    }
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"toProductDetailbyScan"]){
        
        ProductReviewTableViewController* mvc = [segue destinationViewController];
        
        mvc.upcDic = _upcDic;
        mvc.viewDic = _viewDic;
    }


}

-(NSDictionary*)readDic{
    NSLog(@"%@",_upcDic);
    
    if(_upcDic == nil){
        NSLog(@"the _upcDic is nil");
        return nil;
    }

    
    //check error
    
    if(_upcDic[@"ItemLookupResponse"][@"Items"][@"Item"] == nil){
        
        NSLog(@"error");
        return nil;
    }
    
    
 
    
    NSString* title = _upcDic[@"ItemLookupResponse"][@"Items"][@"Item"][0][@"ItemAttributes"][@"Title"][@"text"];
    
    NSString* brand = _upcDic[@"ItemLookupResponse"][@"Items"][@"Item"][0][@"ItemAttributes"][@"Brand"][@"text"];
    
    
    NSDictionary* imageSet = _upcDic[@"ItemLookupResponse"][@"Items"][@"Item"][0][@"ImageSets"][@"ImageSet"][0];
    
    NSString* imageURL = imageSet[@"SmallImage"][@"URL"][@"text"];
    
    
    NSString* webURL =_upcDic[@"ItemLookupResponse"][@"Items"][@"Item"][0][@"DetailPageURL"][@"text"];
    
    NSArray* valueArray = @[title,brand,imageURL,webURL];
    NSArray* keyArray = @[@"title",@"brand",@"imageURL",@"webURL"];
    
    NSDictionary* viewDic = [[NSDictionary alloc] initWithObjects:valueArray forKeys:keyArray];
    
    return viewDic;
   
}


-(NSDictionary*)getDicItem:(NSArray*)array dic:(NSDictionary*)dic {

    NSDictionary* resultDic = [[NSDictionary alloc] initWithDictionary:dic];
    
    for(int i = 0;i < array.count; i++){
        if(resultDic == nil){
            return nil;
        }
        
        NSString* key = array[i];
        if([dic valueForKey:key] == nil){
            NSLog(@"key: %@ is null",key);
            return nil;
        }else{
            resultDic = [resultDic valueForKey:key];
        }
    
    }
    
    return resultDic;
}

#pragma Navigation
- (IBAction)cancelButtonDidPush:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
