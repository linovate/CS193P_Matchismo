//
//  CardGameViewController.h
//  Matchismo_2
//
//  Created by lordofming on 4/25/15.
//  Copyright (c) 2015 lordofming. All rights reserved.
//
//Abstract class. Must implement methods as described below.

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardMatchingGame.h"
@interface CardGameViewController : UIViewController
@property (nonatomic,strong) CardMatchingGame *game;
@property (nonatomic)NSUInteger retainedTotalNumOfCardsToMatch;

//protected
//for subclasses
-(Deck *)createDeck; //abstract

@end

