//
//  QTSkinLayoutParser.m
//  Pods
//
//  Created by fminor on 19/12/2016.
//
//

#import "QTSkinLayoutParser.h"

@implementation QTSkinLayoutParser

- (void)parseLayoutFile:(NSURL *)url
{
    [super parseLayoutFile:url];
    NSData *_data = [NSData dataWithContentsOfURL:url];
    NSError *_parseError = nil;
    NSDictionary *_dict = [NSJSONSerialization JSONObjectWithData:_data options:0 error:&_parseError];
    if ( _parseError ) {
        return;
    }
    
    
}

@end
