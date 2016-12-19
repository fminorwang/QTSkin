//
//  QTSimplePropertyRender.m
//  Pods
//
//  Created by fminor on 07/12/2016.
//
//

#import "QTSimplePropertyRender.h"
#import "NSString+QTSkin.h"

@implementation QTSimplePropertyRender

- (void)renderTarget:(id)target withPropertyName:(NSString *)name withProperty:(id)property
{
    SEL _selector = NSSelectorFromString([NSString stringWithFormat:@"set%@:", [name firstLetterUppercaseString]]);
    NSMethodSignature *_method = [target methodSignatureForSelector:_selector];
    NSInvocation *_invocation = [NSInvocation invocationWithMethodSignature:_method];
    _invocation.target = target;
    _invocation.selector = _selector;
    void *_argument = &property;
    if ( [property isKindOfClass:[NSNumber class]] ) {
        const char *_type = [_method getArgumentTypeAtIndex:2];
        switch ( *_type ) {
            case 'd': {
                double _value = [property doubleValue];
                _argument = &_value;
                break;
            }
                
            case 'B': {
                BOOL _value = [property boolValue];
                _argument = &_value;
                break;
            }
                
            default:
                break;
        }
    }
    [_invocation setArgument:_argument atIndex:2];
    [_invocation invoke];
}

@end
