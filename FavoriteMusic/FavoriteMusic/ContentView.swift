//
//  ContentView.swift
//  FavoriteMusic
//
//  Created by Machiel van Dorst on 08/02/2020.
//  Copyright © 2020 vmachiel. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            List(0 ..< 5) { item in
                Text("Hello, World!")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
