//
//  QTBackgroundImageTargetParser.m
//  Pods
//
//  Created by fminor on 08/12/2016.
//
//

#import "QTBackgroundImageTargetParser.h"

#define BACKGROUND_IMAGEVIEW_TAG            3366

@implementation QTBackgroundImageTargetParser

- (id)parseTargetFromView:(UIView *)aView withPropertyTargetName:(NSString *)name parsedPropertyName:(NSString *__autoreleasing *)parsedName
{
    for ( UIView *_subview in aView.subviews ) {
        if ( _subview.tag == BACKGROUND_IMAGEVIEW_TAG ) {
            *parsedName = [@"imageUrl" copy];
            return _subview;
        }
    }
    
    UIImageView *_imageView = [[UIImageView alloc] init];
    [_imageView setTag:BACKGROUND_IMAGEVIEW_TAG];
    [_imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [aView insertSubview:_imageView atIndex:0];
    
    NSDictionary *_views = NSDictionaryOfVariableBindings(_imageView);
    [aView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_imageView]|" options:0 metrics:nil views:_views]];
    [aView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_imageView]|" options:0 metrics:nil views:_views]];
    
    *parsedName = [@"imageUrl" copy];
    return _imageView;
}

@end
