//
//  EmojieMemoryGameView.swift
//  Memorize
//
//  Created by Machiel van Dorst on 29/05/2020.
//  Copyright © 2020 vmachiel. All rights reserved.
//  THERE WILL BE TOO MANY COMMENTS, THIS IS A LEARNING EXPERIENCE

import SwiftUI

struct EmojieMemoryGameView: View {
    // The some is to indicate it needs to be some kind of view.
    // It can be a combination of all sorts of Views, as long as it's a View. (Lego analogy).
    // Views aren't stored but computed: everytime body is request its contents
    // get executed and returned. When type of view it is, depends on execution
    
    // The viewmodel: the connection to the model!!  Pointer to the EmojiMemoryGame
    // The actual game is inited in SceneDelegate!!!!
    var viewModel: EmojiMemoryGame
    
    var body: some View {
        // A horizontal stack
        HStack {
            // For each makes a number of views, but doesn't do the layout
            // That's the level above. This makes a number of CardViews
            // cards need to be made indenfiable 
            ForEach(viewModel.cards) { card in
                // ontap makes the choose method run for each card.
                CardView(card: card).onTapGesture {
                    self.viewModel.choose(card: card)}
            }
        }
            
            // Every view inside all of the stracks get these methods
            .padding()  // Space between the edge and object.
            .foregroundColor(Color.orange) // default color.
            .font(Font.largeTitle)  // default font size by using largeTitle
    }
}

// The Card.
struct CardView: View {
    // The card
    var card: MemoryGame<String>.Card
    
    // the actual card view with different layouts for faceup/down
    var body: some View {
        ZStack{
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                // stroke doesn't do the default fill, but just the edge.
                // accent the edge
                RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3)
                // The actual emoji. Type string because card is defined as
                // MemoryGame<String>.Card
                Text(card.content)
            } else {
                // Black back off card, with default color set in contentview.
                RoundedRectangle(cornerRadius: 10.0).fill()
            }
        }
    }
}





















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // Create one on the fly for testing
        EmojieMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
