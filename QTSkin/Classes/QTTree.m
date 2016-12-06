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

- (void)enumerateTreeNode:(void (^)(QTTree *))action
{
    
}

@end

@implementation QTStyleTreeValue

@end

@implementation QTStyleTree

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
