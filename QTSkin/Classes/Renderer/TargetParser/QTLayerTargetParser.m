//
//  QTLayerTargetParser.m
//  Pods
//
//  Created by fminor on 08/12/2016.
//
//

#import "QTLayerTargetParser.h"

@implementation QTLayerTargetParser

- (id)parseTargetFromView:(UIView *)aView withPropertyTargetName:(NSString *)name parsedPropertyName:(NSString **)parsedName
{
    if ( ![name hasPrefix:@"layer"] ) {
        return nil;
    }
    
    NSArray *_components = [name componentsSeparatedByString:@"."];
    if ( [_components count] != 2 ) {
        return nil;
    }
    
    *parsedName = [[_components objectAtIndex:1] copy];
    return aView.layer;
}

@end
