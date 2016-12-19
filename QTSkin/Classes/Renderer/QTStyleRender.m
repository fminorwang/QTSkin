//
//  QTStyleRender.m
//  Pods
//
//  Created by fminor on 07/12/2016.
//
//

#import "QTStyleRender.h"

#import "QTSimplePropertyRender.h"
#import "QTColorPropertyRender.h"
#import "QTCGColorPropertyRender.h"
#import "QTImageUrlPropertyRender.h"
#import "QTPointPropertyRender.h"

#import "QTSimpleTargetParser.h"
#import "QTLayerTargetParser.h"
#import "QTBackgroundImageTargetParser.h"

@interface QTStyleRender ()
{
    NSMutableDictionary             *_iRenders;
    NSMutableDictionary             *_iTargetParsers;
}

@end

@implementation QTStyleRender

- (instancetype)init
{
    self = [super init];
    if ( self ) {
        _iRenders = [[NSMutableDictionary alloc] init];
        _iTargetParsers = [[NSMutableDictionary alloc] init];
        
        // view
        [self registerPropertyRender:[[QTColorPropertyRender alloc] init]
                    withPropertyName:@"backgroundColor"];
        
        [self registerPropertyRender:[[QTSimplePropertyRender alloc] init]
                   withPropertyNames:@[@"alpha", @"hidden", @"contentMode", @"clipsToBounds"]];
        
        // view custom
        [self registerTargetParser:[[QTBackgroundImageTargetParser alloc] init]
                    propertyRender:[[QTImageUrlPropertyRender alloc] init]
                  withPropertyName:@"backgroundImage"];
        
        // layer
        [self registerTargetParser:[[QTLayerTargetParser alloc] init]
                 withPropertyNames:@[@"layer.borderWidth", @"layer.cornerRadius",
                                     @"layer.shadowOpacity", @"layer.shadowRadius"]];
        
        [self registerTargetParser:[[QTLayerTargetParser alloc] init]
                    propertyRender:[[QTCGColorPropertyRender alloc] init]
                 withPropertyNames:@[@"layer.borderColor", @"layer.shadowColor"]];
        
        [self registerTargetParser:[[QTLayerTargetParser alloc] init]
                    propertyRender:[[QTPointPropertyRender alloc] init]
                 withPropertyNames:@[@"layer.shadowOffset"]];
    }
    return self;
}

- (void)renderView:(UIView *)aView withStyleProperties:(NSDictionary *)properties
{
    [properties enumerateKeysAndObjectsUsingBlock:^(NSString *key, id  _Nonnull value, BOOL * _Nonnull stop) {
        QTPropertyRender *_propertyRender = [_iRenders objectForKey:key];
        QTTargetParser *_targetParser = [_iTargetParsers objectForKey:key];
        if ( _targetParser == nil || _propertyRender == nil ) return;
        
        NSString *_targetName = nil;
        id _target = [_targetParser parseTargetFromView:aView withPropertyTargetName:key parsedPropertyName:&_targetName];
        if ( _target && _targetName ) {
            [_propertyRender renderTarget:_target withPropertyName:_targetName withProperty:value];
        }
    }];
}

- (void)registerPropertyRender:(QTPropertyRender *)propertyRender withPropertyName:(NSString *)name
{
    [self registerTargetParser:nil propertyRender:propertyRender withPropertyName:name];
}

- (void)registerPropertyRender:(QTPropertyRender *)propertyRender withPropertyNames:(NSArray *)names
{
    [self registerTargetParser:nil propertyRender:propertyRender withPropertyNames:names];
}

- (void)registerTargetParser:(QTTargetParser *)targetParser withPropertyName:(NSString *)name
{
    [self registerTargetParser:targetParser propertyRender:nil withPropertyName:name];
}

- (void)registerTargetParser:(QTTargetParser *)targetParser withPropertyNames:(NSArray *)names
{
    [self registerTargetParser:targetParser propertyRender:nil withPropertyNames:names];
}

- (void)registerTargetParser:(QTTargetParser *)targetParser propertyRender:(QTPropertyRender *)propertyRender withPropertyName:(NSString *)name
{
    if ( [name length] == 0 ) {
        return;
    }
    
    QTTargetParser *_targetParser = targetParser ? targetParser : [[QTSimpleTargetParser alloc] init];
    QTPropertyRender *_renderer = propertyRender ? propertyRender : [[QTSimplePropertyRender alloc] init];
    
    [_iRenders setObject:_renderer forKey:name];
    [_iTargetParsers setObject:_targetParser forKey:name];
}

- (void)registerTargetParser:(QTTargetParser *)targetParser propertyRender:(QTPropertyRender *)propertyRender withPropertyNames:(NSArray *)names
{
    for ( NSString *_name in names ) {
        [self registerTargetParser:targetParser propertyRender:propertyRender withPropertyName:_name];
    }
}

@end
