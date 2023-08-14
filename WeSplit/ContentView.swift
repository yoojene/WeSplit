//
//  ContentView.swift
//  WeSplit
//
//  Created by Eugene on 08/08/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 20

    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var checkTotal: Double {
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        return checkAmount + tipValue
    }
    
    // Custom currency formatter https://www.hackingwithswift.com/forums/100-days-of-swiftui/day-18-project-1-wrap-up-extra-challenge/11099
    var gbpCurrencyCode: FloatingPointFormatStyle<Double>.Currency {
        FloatingPointFormatStyle<Double>.Currency(code: "GBP")
    }
    
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format:
                        .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink) // This reverts to pre iOS 16 behaviour with new page nav
                }
                
                Section {
                    
//                    Text("How much tip do you want to leave")
                    Picker("Tip percentage", selection: $tipPercentage){
                        
        
//                        ForEach(0..<101, id: \.self) {
                         ForEach(tipPercentages, id: \.self) {

                             Text($0, format: .percent)
                                 
                        }
                    }
                    
                    .pickerStyle(.segmented) // like ion-segment
                } header: { // second trailing closure on Section, producing a list header on the Section
                    Text("How much tip do you want to leave")
                }
                
                
                Section {
                    Text(totalPerPerson, format: gbpCurrencyCode)
                } header : {
                    Text("Amount per person")
                }
                
                Section {
                    Text(checkTotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
//                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .foregroundColor(tipPercentage == 0 ? .red : .black) // Views and Modifiers challenge 1
                } header: {
                    Text("Check Total")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
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
