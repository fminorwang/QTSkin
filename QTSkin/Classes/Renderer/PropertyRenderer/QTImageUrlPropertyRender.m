//
//  QTImageUrlPropertyRender.m
//  Pods
//
//  Created by fminor on 08/12/2016.
//
//

#import "QTImageUrlPropertyRender.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation QTImageUrlPropertyRender

- (void)renderTarget:(id)target withPropertyName:(NSString *)name withProperty:(id)property
{
    if ( ![target isKindOfClass:[UIImageView class]] ) {
        return;
    }
    
    UIImageView *_target = target;
    [_target sd_setImageWithURL:[NSURL URLWithString:property]];
}

@end
