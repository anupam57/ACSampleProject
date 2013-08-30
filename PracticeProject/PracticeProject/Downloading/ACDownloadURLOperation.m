//
//  ACDownloadOperation.m
//  PracticeProject
//
//  Created by Anupam on 30/08/13.
//  Copyright (c) 2013 BantuLaLKiDukaan. All rights reserved.
//

#import "ACDownloadURLOperation.h"
@interface ACDownloadURLOperation()
@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, assign) BOOL executing;
@property (nonatomic, strong) NSError *error;
@property (nonatomic, strong) NSMutableData *data;
@property (nonatomic, strong) DownloadProgressBlock progressBlock;
@property (nonatomic, assign) NSUInteger totalResponseSize;
@end

@implementation ACDownloadURLOperation

- (instancetype)initWithURL:(NSURL *)url andProgress:(DownloadProgressBlock)progressBlock {
  if (self = [super init]) {
    _url = [url copy];
  }
  self.progressBlock = progressBlock;
  return self;
}

- (instancetype)initWithURL:(NSURL *)url {
  if (self = [super init]) {
    _url = [url copy];
  }
  return self;
}

- (void)start {
  if (![NSThread isMainThread]) {
    [self performSelectorOnMainThread:@selector(start)
                           withObject:nil
                        waitUntilDone:NO];
    return;
  }

  if (self.finished) {
    return;
  }
  self.executing = YES;
  self.connection = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:self.url]
                                                    delegate:self
                                            startImmediately:YES];
  
}

- (void)canceled {
  self.error = [NSError errorWithDomain:@"DownloadUrlOperation"
                                   code:123
                               userInfo:nil];
  [self done];
}

- (void)done {
  [self.connection cancel];
  self.connection = nil;
  self.executing = NO;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
  if ([self isCancelled]) {
    [self canceled];
  } else {
    self.data = nil;
    [self done];
  }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
  if([self isCancelled]) {
    [self canceled];
		return;
  }
  
  NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)response;
  NSUInteger responseCode = [urlResponse statusCode];
  if (responseCode == 200) {
    self.totalResponseSize = [urlResponse expectedContentLength] > 0 ? [urlResponse expectedContentLength] : 0;
    self.data = [[NSMutableData alloc] initWithCapacity:self.totalResponseSize];
  } else {
    self.error = [[NSError alloc] initWithDomain:@"DownloadUrlOperation"
                                            code:102
                                        userInfo:nil];
    [self done];
  }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
  if ([self isCancelled]) {
    [self canceled];
    return;
  }
  [self.data appendData:data];
  NSLog(@"Data Length ...%d ..%d",[self.data length] , self.totalResponseSize);
  self.progressBlock(((float)[self.data length]/(float)self.totalResponseSize));
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
  // Check if the operation has been cancelled
  if([self isCancelled]) {
    [self canceled];
		return;
  }
	else {
		[self done];
	}
}

@end
