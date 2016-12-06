//
//  QTSkinManager.m
//  Pods
//
//  Created by fminor on 06/12/2016.
//
//

#import "QTSkinManager.h"
#import "QTSkinStyleParser.h"

@implementation QTSkinManager

+ (QTSkinManager *)sharedManager
{
    static QTSkinManager *_gManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _gManager = [[QTSkinManager alloc] init];
    });
    return _gManager;
}

- (instancetype)init
{
    self = [super init];
    if ( self ) {
        _iStyleParser = [[QTSkinStyleParser alloc] init];
    }
    return self;
}

- (BOOL)loadStyleFile:(NSURL *)filePath
{
    [_iStyleParser parseStyleFile:filePath];
}

- (BOOL)bindController:(UIViewController *)controller withLayoutFile:(NSURL *)layoutPath
{
    
}

- (BOOL)bindContainerView:(UIView *)containerView withLayoutFile:(NSURL *)layoutPath
{
    
}

@end
