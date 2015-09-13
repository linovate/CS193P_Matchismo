//
//  PlayingCard.m
//  Matchismo_2
//
//  Created by lordofming on 4/25/15.
//  Copyright (c) 2015 lordofming. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

-(NSString *) contents
{
    NSArray *rankStrings= [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit=_suit;//because we provide both setter and getter.

+(NSArray *) validSuits
{
    return @[@"♥︎",@"♦︎",@"♠︎",@"♣︎"];
}

-(void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit=suit;
    }
}

-(NSString *)suit
{
    return _suit? _suit:@"?";
}

+(NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+(NSUInteger)maxRank
{
    return [[self rankStrings] count]-1;
}

-(void)setRank:(NSUInteger)rank
{
    if(rank<=[PlayingCard maxRank]){
        _rank=rank;
    }
}

//Able to match scoring scheme of both 2 cards and 3 cards.
-(int)match:(NSArray *)otherCards
{
    int score=0;
    if ([otherCards count]==1) {
        PlayingCard *otherCard= [otherCards firstObject];
        if (self.rank==otherCard.rank) {
            score=4;
        }else if([self.suit isEqualToString:otherCard.suit]){
            score=1;
        }
    }
    
    else if ([otherCards count]==2) {

        int countOfRankMatch=0;
        int countOfSuitMatch=0;
        
        for(PlayingCard *eachCard in otherCards)
        {
           if (self.rank==eachCard.rank)
           {
            countOfRankMatch++;
            score+=4;
           }else if([self.suit isEqualToString:eachCard.suit])
           {
            countOfSuitMatch++;
            score+=1;
           }
        }

        if (((PlayingCard*)otherCards[0]).rank==((PlayingCard*)otherCards[1]).rank)
        {
            countOfRankMatch++;
            score+=4;
        }
        if ([((PlayingCard*)otherCards[0]).suit isEqualToString:((PlayingCard*)otherCards[1]).suit])
        {
            countOfSuitMatch++;
            score+=1;
        }
        
        if (countOfRankMatch==1 && countOfSuitMatch==1)
        {
            score +=2;
        }else if (countOfRankMatch==2 ||countOfSuitMatch==2)
        {
            score+=5;
        }else
        {
            score=0;
        }
    }
    
    return score;
}

@end
