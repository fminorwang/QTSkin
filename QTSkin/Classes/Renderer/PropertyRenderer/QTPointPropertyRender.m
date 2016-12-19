//
//  QTPointPropertyRender.m
//  Pods
//
//  Created by fminor on 08/12/2016.
//
//

#import "QTPointPropertyRender.h"
#import "NSString+QTSkin.h"

@implementation QTPointPropertyRender

- (void)renderTarget:(id)target withPropertyName:(NSString *)name withProperty:(id)property
{
    NSDictionary *_pointDict = property;
    if ( ![_pointDict isKindOfClass:[NSDictionary class]] ) {
        return;
    }
    
    CGFloat _x = [[_pointDict objectForKey:@"x"] floatValue];
    CGFloat _y = [[_pointDict objectForKey:@"y"] floatValue];
    CGPoint _point = CGPointMake(_x, _y);
    
    SEL _selector = NSSelectorFromString([NSString stringWithFormat:@"set%@:", [name firstLetterUppercaseString]]);
    NSString *_colorStr= property;
    
    NSMethodSignature *_method = [target methodSignatureForSelector:_selector];
    NSInvocation *_invocation = [NSInvocation invocationWithMethodSignature:_method];
    _invocation.target = target;
    _invocation.selector = _selector;
    [_invocation setArgument:&_point atIndex:2];
    [_invocation invoke];
}

@end
