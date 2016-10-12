//
//  CRItemBriefCollectionViewCell.m
//  CRAnimation
//
//  Created by Bear on 16/10/12.
//  Copyright © 2016年 BearRan. All rights reserved.
//

#import "CRItemBriefCollectionViewCell.h"
#import "FLAnimatedImage.h"

@interface CRItemBriefCollectionViewCell ()
{
    UILabel                 *_label;
    FLAnimatedImage         *_image;
    FLAnimatedImageView     *_imageView;
}

@end

@implementation CRItemBriefCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self createUI];
    }
    
    return self;
}

- (void)createUI
{
    _label = [[UILabel alloc] init];
    _label.text = @"text";
    [_label sizeToFit];
    [self addSubview:_label];
    
    _imageView = [[FLAnimatedImageView alloc] init];
    _imageView.frame = self.bounds;
    [self addSubview:_imageView];
}

- (void)loadDemoInfoModel:(CRDemoInfoModel *)demoInfoModel
{
    NSString *path = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:demoInfoModel.demoGifName];
    _image = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfFile:path]];
    _imageView.animatedImage = _image;
}

@end
