//
//  QTTree.m
//  Pods
//
//  Created by fminor on 07/12/2016.
//
//

#import "QTTree.h"

@implementation QTTree

- (instancetype)init
{
    self = [super init];
    if ( self ) {
        
    }
    return self;
}

- (void)appendChild:(QTTree *)child
{
    if ( self.children == nil ) {
        self.children = [[NSMutableArray alloc] init];
    }
    if ( ![self.children containsObject:child] ) {
        [self.children addObject:child];
    }
}

- (void)updateChild:(QTTree *)child withCondition:(BOOL (^)(id, id))condition updateBlock:(void (^)(QTTree *, QTTree *))update
{
    if ( child == nil ) {
        return;
    }
    
    if ( condition == nil ) {
        return;
    }
    
    if ( self.children == nil ) {
        self.children = [[NSMutableArray alloc] init];
    }
    
    id _destValue = child.value;
    __block BOOL _shouldInsertNewChild = YES;
    [self.children enumerateObjectsUsingBlock:^(QTTree *_child, NSUInteger idx, BOOL * _Nonnull stop) {
        id _sourceValue = _child.value;
        if ( condition(_sourceValue, _destValue) ) {
            *stop = YES;
            _shouldInsertNewChild = NO;
            
            if ( update ) {
                update(_child, child);
            }
        }
    }];
    
    if ( _shouldInsertNewChild ) {
        [self.children addObject:child];
    }
}

- (NSString *)description
{
    NSMutableString *_result = [[NSMutableString alloc] init];
    [_result appendString:@"\n"];
    [_result appendString:[self _nodeDescriptionWithHierachyCount:0]];
    return _result;
}

- (NSString *)_nodeDescriptionWithHierachyCount:(int)count
{
    NSString *_description = @"(null)";
    if ( self.value ) {
        _description = [self.value description];
    }
    NSMutableString *_result = [[NSMutableString alloc] init];
    for ( int i = 0 ; i < count ; i++ ) {
        [_result appendString:@"   "];
    }
    [_result appendString:@"|--"];
    [_result appendString:_description];
    [_result appendString:@"\n"];
    
    for ( QTTree *_childNode in self.children ) {
        [_result appendString:[_childNode _nodeDescriptionWithHierachyCount:count + 1]];
    }
    return _result;
}

@end

@implementation QTStyleTreeValue

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@(%@)", self.styleName, self.styleProperties];
}

@end

@implementation QTStyleTree

- (void)updateStyleTree:(QTTree *)tree
{
    [self updateChild:tree withCondition:^BOOL(QTStyleTreeValue *source, QTStyleTreeValue *dest) {
        if ( [source.styleName length] == 0 || [dest.styleName length] == 0 ) {
            return NO;
        }
        return [source.styleName isEqualToString:dest.styleName];
    } updateBlock:^(QTTree *source, QTTree *dest) {
        // update properties
        [QTStyleTree _updatePropertiesFromTreeNode:dest toSourceTreeNode:source];
        
        // update children, recusively
        [QTStyleTree _updateChildrenFromTreeNode:dest toSourceTreeNode:source];
    }];
}

+ (void)_updatePropertiesFromTreeNode:(QTStyleTree *)destTree toSourceTreeNode:(QTStyleTree *)sourceTree
{
    if ( ![destTree.value.styleName isEqualToString:sourceTree.value.styleName] ) {
        return;
    }
    
    NSMutableDictionary *_properties = [[NSMutableDictionary alloc] init];
    if ( sourceTree.value.styleProperties ) {
        [_properties addEntriesFromDictionary:sourceTree.value.styleProperties];
    }
    if ( destTree.value.styleProperties ) {
        [_properties addEntriesFromDictionary:destTree.value.styleProperties];
    }
    sourceTree.value.styleProperties = _properties;
}

+ (void)_updateChildrenFromTreeNode:(QTStyleTree *)destTree toSourceTreeNode:(QTStyleTree *)sourceTree
{
    if ( destTree.children.count == 0 ) {
        return;
    }
    
    [destTree.children enumerateObjectsUsingBlock:^(QTStyleTree *childTree, NSUInteger idx, BOOL * _Nonnull stop) {
        [sourceTree updateStyleTree:childTree];
    }];
}

- (NSDictionary *)styleDictionary
{
    return [self _styleDictionaryWithSuperStyleDictionary:nil];
}

- (NSDictionary *)_styleDictionaryWithSuperStyleDictionary:(NSDictionary *)superProperties
{
    NSMutableDictionary *_results = [[NSMutableDictionary alloc] init];
    
    NSString *_styleName = self.value.styleName;
    
    // combine properties
    NSMutableDictionary *_properties = [[NSMutableDictionary alloc] init];
    if ( superProperties != nil ) {
        [_properties addEntriesFromDictionary:superProperties];
    }
    if ( self.value.styleProperties ) {
        [_properties addEntriesFromDictionary:self.value.styleProperties];
    }
    if ( self.value.styleName ) {
        [_results setObject:_properties forKey:_styleName];
    }
    
    // children styles
    [self.children enumerateObjectsUsingBlock:^(QTStyleTree *subTree, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *_chilrenStyles = [self _styleDictionaryWithSuperStyleDictionary:_properties];
        if ( _chilrenStyles ) {
            [_results addEntriesFromDictionary:_chilrenStyles];
        }
    }];
    return _results;
}

@end
