//
//  CourseManager.m
//  SFUPA
//
//  Created by Rylan on 2015-03-20.
//  Copyright (c) 2015 7thHeaven. All rights reserved.
//
//  Known Bugs:
//
//  Contributors: Rylan Lim
//
//  Assignment 4:
//  Edited by: | What was done?
//  Rylan      | Created

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

- (id)fetchJSONArray {
    NSString *urlString = [[NSString alloc]
                           initWithFormat:@"https://www.sfu.ca/bin/wcm/course-outlines?%@",
                           [parameters componentsJoinedByString:@"/"]];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
    if (data == nil) {
        return nil;
    }
    id jsonArray = [NSJSONSerialization JSONObjectWithData:data
                                                 options:NSJSONReadingMutableContainers
                                                   error:nil];
    return jsonArray;
}

- (id)fetchJSONArrayWithParameters:(NSArray *)params {
    parameters = [params mutableCopy];
    return [self fetchJSONArray];
}

- (id)downToLevel:(NSString *)parameter {
    [parameters addObject:parameter];
    return [self fetchJSONArray];
}

- (id)upOneLevel {
    if (parameters.count > 0) {
        [parameters removeLastObject];
    }
    return [self fetchJSONArray];
}

- (NSInteger)level {
    return [parameters count];
}

- (NSString *)query {
    return [parameters componentsJoinedByString:@"/"];
}

@end
