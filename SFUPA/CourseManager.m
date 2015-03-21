//
//  CourseManager.m
//  SFUPA
//
//  Created by Rylan on 2015-03-20.
//  Copyright (c) 2015 7thHeaven. All rights reserved.
//

#import "CourseManager.h"

@implementation CourseManager {
    NSMutableArray *parameters;
}

- init {
    self = [super init];
    if (!self) {
        return nil;
    }
    parameters = [[NSMutableArray alloc] init];
    return self;
}

- (id) fetchOutline {
    NSString *urlString = [[NSString alloc]
                           initWithFormat:@"https://www.sfu.ca/bin/wcm/course-outlines?%@",
                           [parameters componentsJoinedByString:@"/"]];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
    if (data == nil) {
        return nil;
    }
    id outline = [NSJSONSerialization JSONObjectWithData:data
                                                 options:NSJSONReadingMutableContainers
                                                   error:nil];
    return outline;
}

- (id) fetchOutlineWithParameters:(NSArray *)params {
    parameters = [params mutableCopy];
    return [self fetchOutline];
}

- (id) downToLevel:(NSString *)parameter {
    [parameters addObject:parameter];
    return [self fetchOutline];
}

- (void) upOneLevel {
    if (parameters.count > 0) {
        [parameters removeLastObject];
    }
}

- (NSInteger) level {
    return [parameters count];
}

@end
