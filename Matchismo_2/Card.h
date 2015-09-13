//
//  Card.h
//  Matchismo_2
//
//  Created by lordofming on 4/25/15.
//  Copyright (c) 2015 lordofming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property (strong,nonatomic) NSString *contents;

@property (nonatomic,getter=isChosen) BOOL chosen;
@property(nonatomic,getter=isMatched) BOOL matched;

-(int)match:(NSArray *)otherCards;

@end
