//
//  ContentView.swift
//  WeSplit
//
//  Created by Adam Sayer on 19/7/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocussed: Bool
    
    let tipPercentages = [0, 5, 10, 15, 20, 25]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPeson = grandTotal / peopleCount
        
        return amountPerPeson
    }
    
    var totalTipValue: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        
        return tipValue
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    LabeledContent("Total Bill")  {
                        TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            .keyboardType(.decimalPad)
                            .focused($amountIsFocussed)
                    }
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section("How much do you want to tip?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                            ForEach(tipPercentages, id: \.self) {
                                Text($0, format: .percent)
                            }
                        }
                        .pickerStyle(.segmented)
                }
                
                Section ("Total amount payable per person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section ("Bill breakdown") {
                    LabeledContent("Total Bill")  {
                        Text(checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    }
                    LabeledContent("Total Tip")  {
                        Text(totalTipValue, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    }
                    .foregroundStyle(tipPercentage == 0 ? .red : .black)
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocussed {
                    Button("Done") {
                        amountIsFocussed = false
                    }
                }
            }
        }
    }

}

#Preview {
    ContentView()
}
