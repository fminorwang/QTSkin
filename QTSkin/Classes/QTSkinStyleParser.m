//
//  QTSkinStyleParser.m
//  Pods
//
//  Created by fminor on 06/12/2016.
//
//

#import "QTSkinStyleParser.h"
#import "QTTree.h"

@interface QTSkinStyleParser ()
{
    NSMutableDictionary             *_styleCache;
    QTStyleTree                     *_iStyleTree;           // root node, value is always nil
}

@end

@implementation QTSkinStyleParser

- (instancetype)init
{
    self = [super init];
    if ( self ) {
        _styleCache = [[NSMutableDictionary alloc] init];
        _iStyleTree = [[QTStyleTree alloc] init];
    }
    return self;
}

- (void)parseStyleFile:(NSURL *)path
{
    [self parseStyleFile:path error:nil];
}

- (void)parseStyleFile:(NSURL *)path error:(NSError **)error
{
    @try {
        NSData *_fileData = [NSData dataWithContentsOfURL:path];
        NSError *_parseError = nil;
        NSDictionary *_dict = [NSJSONSerialization JSONObjectWithData:_fileData options:0 error:&_parseError];
        if ( _parseError ) {
            *error = _parseError;
            return;
        }
        
        [_dict enumerateKeysAndObjectsUsingBlock:^(NSString *class, NSDictionary *properties, BOOL * _Nonnull stop) {
            NSMutableDictionary *_properties = nil;
            NSString *_className = [self _parseClassName:class properties:&_properties];
            NSDictionary *_classProperties = [self _parseProperties:properties];
            [_properties addEntriesFromDictionary:_classProperties];
            [_styleCache setObject:_properties forKey:_className];
        }];
    } @catch (NSException *exception) {
        
    }
}

/**
 解析样式名
 主要问题：解决 ".superClass.subClass" 的继承问题
 */
- (NSString *)_parseClassName:(NSString *)rawClassName properties:(NSMutableDictionary **)properties
{
    if ( [rawClassName length] == 0 ) return nil;
    
    NSArray *_classes = [rawClassName componentsSeparatedByString:@"."];
    if ( [_classes count] == 0 ) return nil;
    
    if ( [[_classes objectAtIndex:0] length] == 0 ) {
        _classes = [_classes subarrayWithRange:NSMakeRange(1, _classes.count - 1)];
    }
    
    NSMutableDictionary *_properties = [[NSMutableDictionary alloc] init];
    [_classes enumerateObjectsUsingBlock:^(NSString *className, NSUInteger idx, BOOL * _Nonnull stop) {
        if ( idx == _classes.count - 1 ) {
            return;
        }
        NSDictionary *_superProperties = [_styleCache objectForKey:className];
        if ( _superProperties ) {
            [_properties addEntriesFromDictionary:_superProperties];
        }
    }];
    *properties = _properties;
    return [_classes lastObject];
}

/**
 解析样式
 */
- (NSDictionary *)_parseProperties:(NSDictionary *)properties
{
    return properties;
}

- (void)loadView:(UIView *)aView
{
    
}

@end
