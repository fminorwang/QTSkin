//
//  QTStyleParser.h
//  Pods
//
//  Created by fminor on 06/12/2016.
//
//

#import <Foundation/Foundation.h>

@interface QTStyleParser : NSObject

- (void)parseStyleFile:(NSURL *)path;

- (void)loadView:(UIView *)aView withStyle:(NSString *)style;

@end
