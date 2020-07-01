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
        // Puts contents (VIEWS!) over each other and alligns them.
        // stroke doesn't do the default fill, but just the edge.
        ZStack(content: {
            RoundedRectangle(cornerRadius: 10.0).stroke()
            Text("👻")
        })
            .foregroundColor(Color.orange) // Every view inside gets this method

    }
}





















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
