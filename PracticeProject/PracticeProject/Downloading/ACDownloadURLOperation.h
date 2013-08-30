//
//  ACDownloadOperation.h
//  PracticeProject
//
//  Created by Anupam on 30/08/13.
//  Copyright (c) 2013 BantuLaLKiDukaan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^DownloadProgressBlock)(float progress);

@interface ACDownloadURLOperation : NSOperation

- (instancetype)initWithURL:(NSURL *)url;
- (instancetype)initWithURL:(NSURL *)url andProgress:(DownloadProgressBlock)progressBlock;

@property (nonatomic, readonly) BOOL finished;

@end
