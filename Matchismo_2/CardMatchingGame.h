//
//  CardMatchingGame.h
//  Matchismo_2
//  Copyright (c) 2015 lordofming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
@interface CardMatchingGame : NSObject

//designated initializer
-(instancetype)initWithCardCount:(NSUInteger) count
                       usingDeck:(Deck*) deck;

-(void)chooseCardAtIndex: (NSUInteger)index;

-(Card *)cardAtIndex:(NSUInteger)index;



@property (nonatomic,readonly) NSInteger score;
@property (nonatomic) NSMutableString *resultOfLastChoice;
@property (nonatomic, readwrite) NSUInteger totalNumOfCardsToMatch;

@end

