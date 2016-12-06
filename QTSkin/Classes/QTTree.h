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

- (void)appendChild:(QTTree<ObjectType> *)child;

// search
- (QTTree *)findNodeWithCondition:(BOOL (^)(ObjectType node, ObjectType dest))condition;

// enumerate
- (void)enumerateTreeNodeUsingBlock:(void (^)(QTTree *node))block;

@end

@interface QTStyleTreeValue : NSObject

@property (nonatomic, copy) NSString *styleName;
@property (nonatomic, strong) NSDictionary *styleProperties;

@end

@interface QTStyleTree : QTTree<QTStyleTreeValue *>

- (NSDictionary *)styleDictionary;

@end
