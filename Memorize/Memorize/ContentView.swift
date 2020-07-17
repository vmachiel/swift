//
//  ContentView.swift
//  Memorize
//
//  Created by Machiel van Dorst on 29/05/2020.
//  Copyright © 2020 vmachiel. All rights reserved.
//  THERE WILL BE TOO MANY COMMENTS, THIS IS A LEARNING EXPERIENCE

import SwiftUI

struct ContentView: View {
    // The some is to indicate it needs to be some kind of view.
    // It can be a combination of all sorts of Views, as long as it's a View. (Lego analogy).
    // Views aren't stored but computed: everytime body is request its contents
    // get executed and returned. When type of view it is, depends on execution
    var body: some View {
        // A horizontal stack
        HStack {
            // For each makes a number of views, but doesn't do the layout
            // That's the level above. This makes a number of CardViews
            ForEach(0..<4) { index in
                CardView(isFaceUp: true)
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
    // is it faceup.
    var isFaceUp: Bool
    
    // the actual card view with different layouts for faceup/down
    var body: some View {
        ZStack{
            if isFaceUp {
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                // stroke doesn't do the default fill, but just the edge.
                // accent the edge
                RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3)
                // The actual emoji.
                Text("👻")
            } else {
                // Black back off card, with default color set in contentview.
                RoundedRectangle(cornerRadius: 10.0).fill()
            }
        }
    }
}





















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
