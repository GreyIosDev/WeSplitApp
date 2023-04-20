//
//  ContentView.swift
//  WeSplit
//
//  Created by Grey  on 17.04.2023.
//

import SwiftUI

struct ContentView: View {// what we did here now was state the different components of our app and set there default values to note what would change
    @State private var checkAmount = 0.0 // always remember that the $ sign is to be accompained with whatever the variable we have to represent the Binding state relation.
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    // We are creating a computed property
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    var body: some View {
        
            NavigationStack{// This enables us to be able to add nice space at the top and doesn't allow our form to overlap pass the system view ie. the clock and other functions at the top of the screen .
               
                    Form{// This is a scrolling list of static views like texts adn images. basically just a way of grouping and arranging our app components in a list form.
                        
                        Section{// This is used when we want to group our components in different secions and make it appealing visually.
                            TextField("Amount", value:$checkAmount, format:
                                    .currency(code: Locale.current.currency?.identifier ?? "USD"))// we added the text field to be able to allow the user to enter the split amount in USD.
                            .keyboardType(.decimalPad)// This is a modifier that brings about a Pop up of numerical keyboard for the viewer so they can be able to input numbers of the split
                            .focused($amountIsFocused)
                            // HOW CREATE A PICKER IN A FORM
                            Picker("Number of people", selection: $numberOfPeople) {
                                ForEach(2..<100){
                                    Text("\($0) people")
                                }
                            }
                        }
                        
                        
                        Section{
                            Picker("Tip percentage", selection: $tipPercentage) {
                                ForEach(tipPercentages, id: \.self) {
                                    Text($0, format: .percent)
                                }
                            }
                            .pickerStyle(.segmented)
                        } header:{
                            Text("How much tip do you want to leave?")
                            .font(.subheadline)
                            .bold()
                            .foregroundColor(.black)
                            
                            
                               
                        }
                        
                        Section {
                            Text(totalPerPerson,format:
                                    .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        }
                        
                        
                    }
                    .scrollContentBackground(.hidden)
                    .background(Color.green)
                    .navigationTitle("WeSplit")// We call this inside the form because we want it to be the title of the form.
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
    
    

