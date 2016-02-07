#import "RCTBridgeModule.h"
#import <Photos/Photos.h>
#import <UIKit/UIKit.h>
#import "RCTLog.h"

@interface SaveAssetLibrary : NSObject <RCTBridgeModule>
@end

@implementation SaveAssetLibrary

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(saveImage:(NSDictionary *)obj)
{
  NSString *imagePath = obj[@"imagePath"];
  NSString *imageName = obj[@"imageName"];
  NSString *imageType = obj[@"imageType"];
  int width =  [obj[@"width"] intValue];
  int height =  [obj[@"height"] intValue];
  if (width) {
    width = 2048;
  }
  if (height) {
    height = 2048;
  }
  // Create NSURL from uri
  NSURL *url = [[NSURL alloc] initWithString:imagePath];

  PHFetchResult *result = [PHAsset fetchAssetsWithALAssetURLs:@[url] options:nil];
  PHAsset *asset = result.firstObject;

  if (asset)
  {
    PHCachingImageManager *imageManager = [[PHCachingImageManager alloc] init];

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
       NSLog(@"imageName: %@", imageNameWithExtension);
       [binaryImageData writeToFile:[basePath stringByAppendingPathComponent:imageNameWithExtension] atomically:YES];
     }
     ];
  } else {
    RCTLogWarn(@"invalid image path");
  }
}

@end