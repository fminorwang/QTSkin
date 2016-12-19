//
//  QTTargetParser.h
//  Pods
//
//  Created by fminor on 08/12/2016.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QTTargetParser : NSObject

- (id)parseTargetFromView:(UIView *)aView withPropertyTargetName:(NSString *)name parsedPropertyName:(NSString **)parsedName;

@end
