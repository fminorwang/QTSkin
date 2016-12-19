//
//  QTCGColorPropertyRender.m
//  Pods
//
//  Created by fminor on 08/12/2016.
//
//

#import "QTCGColorPropertyRender.h"
#import "NSString+QTSkin.h"
#import "UIColor+CJUIKit.h"

@implementation QTCGColorPropertyRender

- (void)renderTarget:(id)target withPropertyName:(NSString *)name withProperty:(id)property
{
    SEL _selector = NSSelectorFromString([NSString stringWithFormat:@"set%@:", [name firstLetterUppercaseString]]);
    NSString *_colorStr= property;
    
    NSMethodSignature *_method = [target methodSignatureForSelector:_selector];
    NSInvocation *_invocation = [NSInvocation invocationWithMethodSignature:_method];
    _invocation.target = target;
    _invocation.selector = _selector;
    UIColor *_color = [UIColor colorWithString:property].CGColor;
    [_invocation setArgument:&_color atIndex:2];
    [_invocation invoke];
}

@end
