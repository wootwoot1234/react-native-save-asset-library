#import "RCTBridgeModule.h"
#import <Photos/Photos.h>
#import <UIKit/UIKit.h>
#import "RCTLog.h"

@interface SaveAssetLibrary : NSObject <RCTBridgeModule>
@end

@implementation SaveAssetLibrary

NSMapTable *_successCallbacks;

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(saveImage:(NSDictionary *)obj successCallback:(RCTResponseSenderBlock)successCallback errorCallback:(RCTResponseErrorBlock)errorCallback)
{
  if (!_successCallbacks) {
    _successCallbacks = [NSMapTable strongToStrongObjectsMapTable];
  }

  NSString *imagePath = obj[@"imagePath"];
  NSString *imageName = obj[@"imageName"];
  NSString *imageType = obj[@"imageType"];
  int width =  [obj[@"width"] intValue];
  int height =  [obj[@"height"] intValue];

  // Create NSURL from uri
  NSURL *url = [[NSURL alloc] initWithString:imagePath];

  PHFetchResult *result = [PHAsset fetchAssetsWithALAssetURLs:@[url] options:nil];
  PHAsset *asset = result.firstObject;

  if (asset) {
    PHCachingImageManager *imageManager = [[PHCachingImageManager alloc] init];

    [_successCallbacks setObject:successCallback forKey:imageManager];
    // Request an image for the asset from the PHCachingImageManager.
    [imageManager requestImageForAsset:asset targetSize:CGSizeMake(width, height) contentMode:PHImageContentModeAspectFit options:nil
                         resultHandler:^(UIImage *image, NSDictionary *info)
     {
       NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
       NSString * basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;

       NSData * binaryImageData;
       if([imageType isEqualToString:@"png"]) {
         binaryImageData = UIImagePNGRepresentation(image);
       } else {
         binaryImageData = UIImageJPEGRepresentation(image, 1.0);
       }
       NSString *imageNameWithExtension = [NSString stringWithFormat:@"%@.%@", imageName, imageType];
       [binaryImageData writeToFile:[basePath stringByAppendingPathComponent:imageNameWithExtension] atomically:YES];

       // Call the callback
       RCTResponseSenderBlock successCallback = [_successCallbacks objectForKey:imageManager];
       if (successCallback) {
         successCallback(@[@"Success"]);
         [_successCallbacks removeObjectForKey:imageManager];
       } else {
         RCTLogWarn(@"No callback registered for success");
       }
     }
     ];
  } else {
    NSMutableDictionary* details = [NSMutableDictionary dictionary];
    [details setValue:@"Invalid image Path.  Asset not found." forKey:NSLocalizedDescriptionKey];
    errorCallback([NSError errorWithDomain:@"SaveAssetLibrary" code:1 userInfo:details]);
    RCTLogWarn(@"Invalid image Path.  asset not found.");
  }
}

@end