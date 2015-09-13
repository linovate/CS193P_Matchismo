//
//  Deck.h
//  Matchismo_2
//
//  Created by lordofming on 4/25/15.
//  Copyright (c) 2015 lordofming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

-(void)addCard:(Card*)card atTop:(BOOL)atTop;
-(void)addCard:(Card*)card;
-(Card *)drawRandomCard;

@end
