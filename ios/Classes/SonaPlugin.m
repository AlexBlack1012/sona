#import "SonaPlugin.h"

@implementation SonaPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"com.jarvanmo/sona"
            binaryMessenger:[registrar messenger]];
  SonaPlugin* instance = [[SonaPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

BOOL  isRgisterGetuiBySona = YES;

+ (BOOL) registerGetuiPushBySona{
  return isRgisterGetuiBySona;
}

+ (void) setRegisterGetuiPushBySona:(BOOL) registerGetuiPushBySona{
  isRgisterGetuiBySona = registerGetuiPushBySona;
}



- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
