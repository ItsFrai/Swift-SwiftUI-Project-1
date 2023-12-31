//
//  ContentView.swift
//  BillSplit
//
//  Created by Fraidoon Pourooshasb on 6/13/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    
    @FocusState private var amountIsFocused: Bool
    
    var totalPerPerson: Double {
           let peopleCount = Double(numberOfPeople * 2)
           let tipSelection = Double(tipPercentage)

           let tipValue = checkAmount / 100 * tipSelection
           let grandTotal = checkAmount + tipValue
           let amountPerPerson = grandTotal / peopleCount

           return amountPerPerson
    }
    
    let tipPercentages = [10,15,20,25,0]
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD")).keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                }
                Section(header: Text("How much do you want to tip?")) {
                    Picker("Tip percentage", selection: $tipPercentage){
                        ForEach(0..<101) {
                            Text($0, format:.percent)
                        }
                    }

                }
                
                
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                header: {
                    Text("Amount per person")
                }
                Section(header: Text("More Info")) {
                    Text("Total bill with tip: \(checkAmount + checkAmount * Double(tipPercentage) / 100)").foregroundColor(tipPercentage == 0 ? Color.red: Color.white)
                }
                }
            }
            .navigationTitle("BillSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }

        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
