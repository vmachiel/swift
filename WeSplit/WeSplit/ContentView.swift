//
//  ContentView.swift
//  WeSplit
//
//  Created by Machiel van Dorst on 08/02/2023.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: State
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 0
    
    // MARK: Properties
    let tipPercentages = [0, 10, 12, 15, 20, 25]
    var totalPerPeron: Double {
        // You start with 2 people in the loop so the 0th value is 2 persons, 4 is 6 ect
        // Wrap in Double to do math
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelected = Double(tipPercentage)
        
        // The full tip, the total bill and the ammount per person
        let tipAmount = checkAmount / 100 * tipSelected
        let totalBill = checkAmount + tipAmount
        let totalPerPerson = totalBill/peopleCount
        return totalPerPerson
    }
    
    
    // MARK: Views
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Ammount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "Euro"))
                        .keyboardType(.decimalPad)
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                            // Note: you start with 2 people as minimum!
                        }
                    }
                }
                Section {
                    Picker("Choose Tip Percentage", selection: $tipPercentage){
                        ForEach(tipPercentages, id:\.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much would you like to tip?")
                }
                Section {
                    Text(totalPerPeron, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }.navigationTitle("We Split")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

