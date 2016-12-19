//
//  QTSkinManager.h
//  Pods
//
//  Created by fminor on 06/12/2016.
//
//

#import <Foundation/Foundation.h>
#import "QTStyleParser.h"
#import "QTLayoutParser.h"

#define QT_SK_MGR               [QTSkinManager sharedManager]

@interface QTSkinManager : NSObject
{
    QTStyleParser           *_iStyleParser;
    QTLayoutParser          *_iLayoutParser;
}

+ (QTSkinManager *)sharedManager;

- (BOOL)loadStyleFile:(NSURL *)filePath;
- (BOOL)loadLayoutFile:(NSURL *)filePath;

- (void)bindView:(UIView *)aView withStyle:(NSString *)style;

- (BOOL)bindController:(UIViewController *)controller withLayoutFile:(NSURL *)layoutPath;
- (BOOL)bindContainerView:(UIView *)containerView withLayoutFile:(NSURL *)layoutPath;

@end
