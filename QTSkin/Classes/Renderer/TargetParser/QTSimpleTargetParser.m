//
//  QTSimpleTargetParser.m
//  Pods
//
//  Created by fminor on 08/12/2016.
//
//

#import "QTSimpleTargetParser.h"

@implementation QTSimpleTargetParser

- (id)parseTargetFromView:(UIView *)aView withPropertyTargetName:(NSString *)name parsedPropertyName:(NSString **)parsedName
{
    *parsedName = [name copy];
    return aView;
}

@end
