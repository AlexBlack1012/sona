#import <Flutter/Flutter.h>
#import "GTSDK/GeTuiSdk.h"
#import <PushKit/PushKit.h>
#import "StringUtil.h"

@interface SonaPlugin : UIResponder <FlutterPlugin,UIApplicationDelegate, PKPushRegistryDelegate, GeTuiSdkDelegate>
@end
