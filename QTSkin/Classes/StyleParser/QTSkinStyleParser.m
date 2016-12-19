//
//  QTSkinStyleParser.m
//  Pods
//
//  Created by fminor on 06/12/2016.
//
//

#import "QTSkinStyleParser.h"
#import "QTTree.h"
#import "QTStyleRender.h"

@interface QTSkinStyleParser ()
{
    NSMutableDictionary             *_styleCache;
    QTStyleTree                     *_iStyleTree;           // root node, value is always nil
    QTStyleRender                   *_iStyleRender;
}

@end

@implementation QTSkinStyleParser

- (instancetype)init
{
    self = [super init];
    if ( self ) {
        _styleCache = [[NSMutableDictionary alloc] init];
        _iStyleTree = [[QTStyleTree alloc] init];
        _iStyleRender = [[QTStyleRender alloc] init];
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
            QTStyleTree *_child = [self _parseClassName:class withRawProperties:properties];
            [_iStyleTree updateStyleTree:_child];
        }];
        
        [self _processsStyleTree:_iStyleTree];
    } @catch (NSException *exception) {
        
    }
}

/**
 解析样式名, 生成单一路径的 QTStyleTree
 */
- (QTStyleTree *)_parseClassName:(NSString *)rawClassName withRawProperties:(NSDictionary *)properties
{
    if ( [rawClassName length] == 0 ) return nil;
    
    NSArray *_classes = [rawClassName componentsSeparatedByString:@"."];
    if ( [_classes count] == 0 ) return nil;
    
    if ( [[_classes objectAtIndex:0] length] == 0 ) {
        _classes = [_classes subarrayWithRange:NSMakeRange(1, _classes.count - 1)];
    }
    
    QTStyleTree *_root = [[QTStyleTree alloc] init];
    __block QTStyleTree *_current = _root;
    NSMutableDictionary *_properties = [[NSMutableDictionary alloc] init];
    [_classes enumerateObjectsUsingBlock:^(NSString *className, NSUInteger idx, BOOL * _Nonnull stop) {
        QTStyleTreeValue *_value = [[QTStyleTreeValue alloc] init];
        _value.styleName = [className copy];
        if ( idx == _classes.count - 1 ) {
            _value.styleProperties = properties;
        }
        QTStyleTree *_super = _current;
        _current = [[QTStyleTree alloc] init];
        _current.value = _value;
        [_super appendChild:_current];
    }];
    if ( [_root.children count] > 0 ) {
        return _root.children[0];
    }
    return nil;
}

/**
 解析样式
 */
- (NSDictionary *)_parseProperties:(NSDictionary *)properties
{
    return properties;
}

/**
 处理 QTStyleTree，扁平化所有的样式 class, 存入 style cache
 */
- (void)_processsStyleTree:(QTStyleTree *)rootStyleTree
{
    [self _processStyleTree:rootStyleTree withSuperProperties:nil];
}

// recursive process
- (void)_processStyleTree:(QTStyleTree *)styleTree withSuperProperties:(NSDictionary *)properties
{
    NSMutableDictionary *_properties = nil;
    if ( styleTree.value != nil ) {
        NSString *_styleName = styleTree.value.styleName;
        _properties = [[NSMutableDictionary alloc] init];
        if ( properties ) {
            [_properties addEntriesFromDictionary:properties];
        }
        if ( styleTree.value.styleProperties ) {
            [_properties addEntriesFromDictionary:styleTree.value.styleProperties];
        }
        if ( _styleName && _properties ) {
            [_styleCache setObject:_properties forKey:_styleName];
        }
    } else {
        if ( properties ) {
            [_properties addEntriesFromDictionary:properties];
        }
    }
    
    [styleTree.children enumerateObjectsUsingBlock:^(QTStyleTree *child, NSUInteger idx, BOOL * _Nonnull stop) {
        [self _processStyleTree:child withSuperProperties:_properties];
    }];
}

- (void)loadView:(UIView *)aView withStyle:(NSString *)style
{
    NSDictionary *_properties = [_styleCache objectForKey:style];
    [_iStyleRender renderView:aView withStyleProperties:_properties];
}

@end
