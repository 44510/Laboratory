//
//  LoadHook.h
//  HookFramework
//
//  Created by tripleCC on 5/22/19.
//  Copyright © 2019 tripleCC. All rights reserved.
//

#ifndef LoadHook_h
#define LoadHook_h

#import <Foundation/Foundation.h>

@interface LHLoadInfo : NSObject
@property (assign, nonatomic, readonly) SEL sel;
@property (copy, nonatomic, readonly) NSString *clsname;
@property (copy, nonatomic, readonly) NSString *catname;
@property (assign, nonatomic, readonly) CFAbsoluteTime start;
@property (assign, nonatomic, readonly) CFAbsoluteTime end;
@property (assign, nonatomic, readonly) CFAbsoluteTime duration;
@end

@interface LHLoadInfoWrapper : NSObject
@property (assign, nonatomic, readonly) Class cls;
@property (copy, nonatomic, readonly) NSArray <LHLoadInfo *> *infos;
@end

extern const NSArray <LHLoadInfoWrapper *> *LHLoadInfoWappers;

#endif /* LoadHook_h */
