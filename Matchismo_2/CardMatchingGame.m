//
//  CardMatchingGame.m
//  Matchismo_2
//
//  Created by lordofming on 4/25/15.
//  Copyright (c) 2015 lordofming. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame ()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong)NSMutableArray *cards; //of Card

//addtional features:
@property (nonatomic, readwrite) NSMutableString *matchResult;

@end

static const int MINIMUM_NUM_OF_CARDS_IN_A_GAME=3;

@implementation CardMatchingGame

-(NSMutableArray *)cards
{
    if(!_cards)_cards=[[NSMutableArray alloc]init];
    return _cards;
}

-(NSUInteger)totalNumOfCardsToMatch
{
    if (_totalNumOfCardsToMatch<2) {
        _totalNumOfCardsToMatch=2;
    }
    return _totalNumOfCardsToMatch;
}

-(instancetype)initWithCardCount:(NSUInteger)count
                       usingDeck:(Deck *)deck
{
    self=[super init];
    
    if(count<MINIMUM_NUM_OF_CARDS_IN_A_GAME)
        return nil;//different from video of lecture 3.
    
    if(self){
        for (int i=0; i<count; i++) {
            Card * card=[deck drawRandomCard];
            if(card){
                [self.cards addObject:card];
            }else{
                return nil; //different from video of Lecture 3.
            }
        }
    }
    return self;
}

//In case subclass call [super init] without arguements:
-(instancetype) init
{
    return nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4 ;
static const int COST_TO_CHOOSE = 1;

//Modified method making it generic, i.e. able to match any number of cards.
-(void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card= [self cardAtIndex:index];
    
    self.resultOfLastChoice=[NSMutableString stringWithFormat:@"%@",card.contents];
    
    if (!card.isMatched)
    {
        if(card.isChosen)
        {
            card.chosen=NO;
                self.resultOfLastChoice=[NSMutableString stringWithFormat:@"unchoose %@",card.contents];
        }else
        {
            NSMutableArray *matchingPool= [[NSMutableArray alloc] init];
            
            for (Card *otherCard in self.cards)
            {
                if(otherCard.isChosen && !otherCard.isMatched)
                {
                    [matchingPool addObject:otherCard];
                }
            }
            
            if ([matchingPool count]==self.totalNumOfCardsToMatch-1) {
                int matchScore=[card match:matchingPool];
                if (matchScore) {
                    self.score+=matchScore *MATCH_BONUS;
                    card.matched=YES;
                    
                   [self.resultOfLastChoice setString:@""];
                    //Set every card in the matching array to be matched
                    for (Card *eachCard in matchingPool)
                    {
                        eachCard.matched=YES;
                        [self.resultOfLastChoice appendString:eachCard.contents];
                    }
                    
                    [self.resultOfLastChoice appendString:card.contents];
                    self.resultOfLastChoice=[[[@"Matched " stringByAppendingString:self.resultOfLastChoice ] stringByAppendingString:[NSString stringWithFormat:@" for %d",matchScore]] stringByAppendingString:@"points !"];
                }
                else
                {
                    [self.resultOfLastChoice setString:@""];
                    for (Card *eachCard in matchingPool)
                    {
                        [self.resultOfLastChoice appendString:eachCard.contents];
                    }
                    [self.resultOfLastChoice appendString:card.contents];
                    [self.resultOfLastChoice appendString:@" don't Match! "];
                    
                    [self.resultOfLastChoice appendString:[NSString stringWithFormat:@"%d point penalty!",MISMATCH_PENALTY]];
                    
                    
                    self.score -= MISMATCH_PENALTY;
                    for (Card *eachCard in matchingPool)
                    {
                        eachCard.chosen=NO;
                    }
                }
            }
            self.score-= COST_TO_CHOOSE;
            card.chosen=YES;
        }
    }
}

-(Card *)cardAtIndex:(NSUInteger)index {
    return (index<[self.cards count])? self.cards[index]:nil;
}

@end
