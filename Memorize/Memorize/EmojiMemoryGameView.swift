//
//  EmojieMemoryGameView.swift
//  Memorize
//
//  Created by Machiel van Dorst on 29/05/2020.
//  Copyright © 2020 vmachiel. All rights reserved.
//  THERE WILL BE TOO MANY COMMENTS, THIS IS A LEARNING EXPERIENCE

import SwiftUI

struct EmojiMemoryGameView: View {
    // The some is to indicate it needs to be some kind of view.
    // It can be a combination of all sorts of Views, as long as it's a View. (Lego analogy).
    // Views aren't stored but computed: everytime body is request its contents
    // get executed and returned. When type of view it is, depends on execution
    
    // The viewmodel: the connection to the model!!  Pointer to the EmojiMemoryGame
    // The actual game is inited in SceneDelegate!!!!
    // ObservedObject property wrapper says: this contains an observableobject (view of type: EmojiMemoryGame)
    // So keep track of that observableoject and redraw when it calls a objectWillChange.send()
    // ONLY the changed card is redrawn: it's Identifiable, so swiftUI knows which one has
    // changed. 
    @ObservedObject var viewModel: EmojiMemoryGame
    // MARK: Constants of the EmojieMemoryGameView
    let aspectRatio: CGFloat = 2/3
    
    var body: some View {
        // A horizontal stack
        HStack {
            // For each makes a number of views, but doesn't do the layout
            // That's the level above. This makes a number of CardViews
            // cards need to be made indenfiable 
            ForEach(viewModel.cards) { card in
                // ontap makes the choose method run for each card.
                CardView(card: card).onTapGesture {
                     viewModel.choose(card: card)}
            }
        }
            
            // Every view inside all of the stracks get these methods
            .padding()  // Space between the edge and object.
            .foregroundColor(Color.orange) // default color.
        .aspectRatio(aspectRatio, contentMode: .fit)
    }
}

// The Card. Redrawn when needed by the EmojiMemoryGameView that contains these cards.
struct CardView: View {
    // MARK: - Drawing constants of the CardView
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3
    let fontScaleFactor: CGFloat = 0.75
    // MARK: - The card
    var card: MemoryGame<String>.Card
    
    // the actual card view with different layouts for faceup/down
    var body: some View {
        // Geometry reader. You wrap this around the cards so you can set things
        // like font size based on system parameters.
        GeometryReader {geometry in
            ZStack{
                if card.isFaceUp {
                    RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                    // stroke doesn't do the default fill, but just the edge.
                    // accent the edge
                    RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                    // The actual emoji. Type string because card is defined as
                    // MemoryGame<String>.Card
                    Text(card.content)
                } else {
                    // Black back off card, with default color set in contentview.
                    RoundedRectangle(cornerRadius: cornerRadius).fill()
                }
            }
            // Set font of the cards (emojis) based on the system.
            .font(Font.system(size: min(geometry.size.width, geometry.size.height) * fontScaleFactor))
        }
    }
}





















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // Create one on the fly for testing
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
