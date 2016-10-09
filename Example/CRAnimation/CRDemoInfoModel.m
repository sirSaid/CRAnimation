//
//  CRDemoInfoModel.m
//  CRAnimation
//
//  Created by Bear on 16/10/7.
//  Copyright © 2016年 BearRan. All rights reserved.
//

#import "CRDemoInfoModel.h"

@implementation CRDemoInfoModel

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        _demoName = @"";
        _demoSummary = @"";
    }
    
    return self;
}

@end
