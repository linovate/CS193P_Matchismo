//
//  Card.m
//  Matchismo_2
//
//  Created by lordofming on 4/25/15.
//  Copyright (c) 2015 lordofming. All rights reserved.
//

#import "Card.h"

@interface Card ()

@end

@implementation Card
- (int)match:(NSArray *)otherCards
{
    int score=0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score=1;
        }
    }
    
    return score;
}
@end
