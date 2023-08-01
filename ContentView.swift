import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool

    let percentages = Array(0..<101) // Tip percentages from 0% to 100%

    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)


        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }
    
    var totalAmount: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        return checkAmount + tipValue
    }

    var body: some View {
        NavigationView{
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD")).keyboardType(.decimalPad).focused($amountIsFocused)

                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                    
                    NavigationLink(destination: PickerScreen(selectedPercentage: $tipPercentage, percentages: percentages)) {
                        Text("Select Tip Percentage")
                    }
                    
                    Section(header: Text("Amount per person")) {
                        Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD")).keyboardType(.decimalPad)
                    }
                    
                    Section(header: Text("Total amount")) {
                        Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD")).keyboardType(.decimalPad)
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
}

struct PickerScreen: View {
    @Binding var selectedPercentage: Int
    let percentages: [Int]

    var body: some View {
        List {
            ForEach(percentages, id: \.self) { percentage in
                Button(action: {
                    self.selectedPercentage = percentage
                }) {
                    Text("\(percentage)%")
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

