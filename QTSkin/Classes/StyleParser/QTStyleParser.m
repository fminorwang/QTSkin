//
//  QTStyleParser.m
//  Pods
//
//  Created by fminor on 06/12/2016.
//
//

#import "QTStyleParser.h"

@implementation QTStyleParser

- (void)parseStyleFile:(NSURL *)path
{
    // override by subclasses
    return;
}

- (void)loadView:(UIView *)aView withStyle:(NSString *)style
{
    // override by subclasses
    return;
}

@end
