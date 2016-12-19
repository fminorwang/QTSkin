//
//  QTTree.h
//  Pods
//
//  Created by fminor on 07/12/2016.
//
//

#import <Foundation/Foundation.h>

@interface QTTree<ObjectType> : NSObject

@property (nonatomic, strong) NSMutableArray *children;
@property (nonatomic, strong) ObjectType value;

// append child without comparison
- (void)appendChild:(QTTree<ObjectType> *)child;

- (void)updateChild:(QTTree<ObjectType> *)child withCondition:(BOOL (^)(ObjectType source, ObjectType dest))condition updateBlock:(void (^)(QTTree *source, QTTree *dest))update;

// search
//- (QTTree *)findNodeWithCondition:(BOOL (^)(ObjectType node, ObjectType dest))condition;

// enumerate
//- (void)enumerateTreeNodeUsingBlock:(void (^)(QTTree *node))block;

@end

@interface QTStyleTreeValue : NSObject

@property (nonatomic, copy) NSString *styleName;
@property (nonatomic, strong) NSDictionary *styleProperties;

@end

@interface QTStyleTree : QTTree<QTStyleTreeValue *>

- (void)updateStyleTree:(QTTree *)tree;

- (NSDictionary *)styleDictionary;

@end
