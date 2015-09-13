//
//  CardGameViewController.m
//  Matchismo_2
//
//  Created by lordofming on 4/25/15.
//  Copyright (c) 2015 lordofming. All rights reserved.
//

#import "CardGameViewController.h"


@interface CardGameViewController ()
@property (nonatomic,strong) Deck *deck;


@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

//additional features:
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@end

@implementation CardGameViewController

-(CardMatchingGame*) game
{
    if (!_game)_game=[[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    
    _game.totalNumOfCardsToMatch=self.retainedTotalNumOfCardsToMatch;

    return _game;
}

-(Deck *)createDeck //abstract
{
    return nil;
}

- (IBAction)touchDealBarButton:(id)sender {
    self.game =nil;
    [self updateUI];
    
}


- (IBAction)touchCardButton:(UIButton *)sender {
    NSUInteger index=[self.cardButtons indexOfObject:sender];
        [self.game chooseCardAtIndex:index];
        [self updateUI];
}

-(void)updateUI
{
    for(UIButton *cardButton in self.cardButtons){
        NSUInteger cardIndex=[self.cardButtons indexOfObject:cardButton];
        Card *card=[self.game cardAtIndex:cardIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled=!card.isMatched;
    }
    
    [self.scoreLabel setText:[NSString stringWithFormat:@"Score: %ld",(long)self.game.score]];
  
    [self.resultLabel setText:[NSString stringWithFormat:@"Result of Last Choice: %@",self.game.resultOfLastChoice]];
}

-(NSString *) titleForCard:(Card *)card
{
    return card.isChosen ? card.contents: @"";
}

-(UIImage *) backgroundImageForCard:(Card *) card
{
    return [UIImage imageNamed:card.isChosen? @"cardfront": @"cardback"];
}
@end
