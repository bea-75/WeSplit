//
//  ContentView.swift
//  WeSplit
//
//  Created by Mobile on 9/4/24.
//

import SwiftUI

struct ContentView: View 
{
    @FocusState private var amountIsFocused: Bool
    
    @State private var checkTotal = 0.0
    @State private var numPeople = 2
    @State private var tipPercent = 20
    let tipPercents = [0, 5, 10, 15, 20, 25]
    var totalBill: Double
    {
        let tip = Double(tipPercent)
        
        let total = (checkTotal + (checkTotal * (tip / 100)))
        
        return total
    }
    var totalPerPerson: Double
    {
        let people = Double(numPeople + 2)
        let tip = Double(tipPercent)
        
        let amountPerPerson = (checkTotal + ((checkTotal / 100) * tip)) / people
        
        return amountPerPerson
    }
    
    var body: some View
    {
        NavigationStack
        {
            Form
            {
                Section
                {
                    TextField("Amount", value: $checkTotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of People", selection: $numPeople)
                    {
                        ForEach(2..<50)
                        {
                            Text("\($0)")
                        }
                    }
                }
                
                Section("Tip Percent")
                {
                    Picker("Tip Percentage", selection: $tipPercent)
                    {
                        ForEach(0..<101)
                        {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("Bill Total")
                {
                    Text(totalBill, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section("Amount Per Person")
                {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar 
            {
                if amountIsFocused 
                {
                    Button("Done") 
                    {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview 
{
    ContentView()
}
