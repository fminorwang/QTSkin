//
//  QTStyleRender.h
//  Pods
//
//  Created by fminor on 07/12/2016.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "QTPropertyRender.h"
#import "QTTargetParser.h"

@interface QTStyleRender : NSObject

- (void)renderView:(UIView *)aView withStyleProperties:(NSDictionary *)properties;

// 如果没有指定 target parser, 默认为 QTSimpleTargetParser
// 如果没有指定 propterty renderer，默认为 QTSimplePropertyRender

- (void)registerPropertyRender:(QTPropertyRender *)propertyRender withPropertyName:(NSString *)name;
- (void)registerPropertyRender:(QTPropertyRender *)propertyRender withPropertyNames:(NSArray *)names;

- (void)registerTargetParser:(QTTargetParser *)targetParser withPropertyName:(NSString *)name;
- (void)registerTargetParser:(QTTargetParser *)targetParser withPropertyNames:(NSArray *)names;

- (void)registerTargetParser:(QTTargetParser *)targetParser propertyRender:(QTPropertyRender *)propertyRender withPropertyName:(NSString *)name;
- (void)registerTargetParser:(QTTargetParser *)targetParser propertyRender:(QTPropertyRender *)propertyRender withPropertyNames:(NSArray *)names;

@end
