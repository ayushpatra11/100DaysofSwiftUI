//
//  ContentView.swift
//  WeSplit
//
//  Created by Ayush Patra on 1/29/25.
//

import SwiftUI

struct ContentView: View {
    @State private var totalAmount = 0.0
    @State private var numOfPeople = 2
    @State private var tipPercentage = 15
    //We are introducing a focus state to ensure that the field is in focus only if there is a value yet to be entered
    @FocusState private var amountIsFocused: Bool
    
    
    let tipPercentageRanges = [0, 10, 15, 20, 25]
    
    func calculateTipAmount() -> Double {
        let peopleCount = Double(numOfPeople+2)
        let tip = Double(tipPercentage)
        let total = totalAmount*(1.0+(tip/100))
        return Double(total/peopleCount)
    }
    
    var body: some View {
        NavigationView {
            Form{
                // The total amount
                Section{
                    TextField("Check Amount", value: $totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of People", selection: $numOfPeople){
                        ForEach(2..<16){
                            Text("\($0)")
                        }
                    }
                }header: {
                    Text("Please enter the details")
                }
                
                Section{
                    Picker("Tip", selection: $tipPercentage){
                        ForEach(tipPercentageRanges, id: \.self){
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.segmented)
                }header: {
                    Text("How much do you want to tip?")
                }
                
                Section{
                    Text("\(calculateTipAmount())")
                }header: {
                    Text("Split")
                }
                
            }
            .navigationTitle("WeSplit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
