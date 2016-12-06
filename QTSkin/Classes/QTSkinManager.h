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

@interface QTSkinManager : NSObject
{
    QTStyleParser           *_iStyleParser;
    QTLayoutParser          *_iLayoutParser;
}

+ (QTSkinManager *)sharedManager;

- (BOOL)loadStyleFile:(NSURL *)filePath;

- (BOOL)bindController:(UIViewController *)controller withLayoutFile:(NSURL *)layoutPath;
- (BOOL)bindContainerView:(UIView *)containerView withLayoutFile:(NSURL *)layoutPath;

@end
