//
//  LoadMeasure.h
//  LoadMeasure
//
//  Created by tripleCC on 5/22/19.
//  Copyright © 2019 tripleCC. All rights reserved.
//

#ifndef LoadMeasure_h
#define LoadMeasure_h

#import <Foundation/Foundation.h>

@interface LMLoadInfo : NSObject
@property (assign, nonatomic, readonly) SEL sel;
@property (copy, nonatomic, readonly) NSString *clsname;
@property (copy, nonatomic, readonly) NSString *catname;
@property (assign, nonatomic, readonly) CFAbsoluteTime start;
@property (assign, nonatomic, readonly) CFAbsoluteTime end;
@property (assign, nonatomic, readonly) CFAbsoluteTime duration;
@end

@interface LMLoadInfoWrapper : NSObject
@property (assign, nonatomic, readonly) Class cls;
@property (copy, nonatomic, readonly) NSArray <LMLoadInfo *> *infos;
@end

extern const NSArray <LMLoadInfoWrapper *> *LMLoadInfoWappers;

#endif /* LoadMeasure_h */
