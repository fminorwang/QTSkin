//
//  NSString+QTSkin.m
//  Pods
//
//  Created by fminor on 07/12/2016.
//
//

#import "NSString+QTSkin.h"

@implementation NSString (QTSkin)

- (NSString *)firstLetterUppercaseString
{
    if ( [self length] == 0 ) return self;
    
    char _ch = [self characterAtIndex:0];
    if ( _ch < 'a' || _ch > 'z' ) {
        return self;
    }
    
    _ch = _ch + 'A' - 'a';
    NSString *_subString = [self substringFromIndex:1];
    
    if ( _subString ) {
        return [NSString stringWithFormat:@"%c%@", _ch, _subString];
    } else {
        return [NSString stringWithFormat:@"%c", _ch];
    }
}

@end
