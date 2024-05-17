//
//  ContentView.swift
//  CustomCurrencyTextField
//
//  Created by Olha Bereziuk on 07.05.24.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    // MARK: - State -
    @FocusState var isKeyboardFocused: Bool
    @State private var inputAmount = ""
    @State private var displyedNumber = "0,00"
    
    // MARK: - Properties -
    let currency: String = "EUR"
    let decimalSeparator = Locale.current.decimalSeparator ?? "."
    
    // MARK: - Body -
    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
                .foregroundStyle(.blue.opacity(0.1))
            VStack {
                ZStack {
                    /// Background
                    Rectangle()
                        .foregroundStyle(.blue.opacity(0.8))
                        .ignoresSafeArea()
                        .frame(height: 70)
                        .onTapGesture {
                            self.isKeyboardFocused = true
                        }
                    
                    /// Displayed Number
                    Text("\(displyedNumber) \(currency)")
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .foregroundStyle(Color.white)
                    
                    /// User Input Amount of Money
                    HStack {
                        Spacer()
                        TextField("", text: $inputAmount)
                            .frame(width: 1)
                            .font(.title)
                            .foregroundStyle(Color.clear)
                            .tint(.clear)
                            .keyboardType(.decimalPad)
                            .focused(self.$isKeyboardFocused)
                            .background(.clear)
                            .padding(.vertical)
                            .onReceive(Just(inputAmount)) { _ in /// Input Length restriction
                                if inputAmount.count > 15 {
                                    inputAmount = String(inputAmount.prefix(15))
                                }
                            }
                            .onChange(of: inputAmount) {
                                /// Option 1
//                                self.displyedNumber = self.stringFormatter1(inputAmount)
                                
                                /// Option 2
                                self.displyedNumber = self.stringFormatter2(inputAmount)
                            }
                    }
                }
            }
        }
        .onTapGesture {
            self.isKeyboardFocused = false
        }
    }
    
    // MARK: - Option 1
    private func stringFormatter1(_ input: String) -> String {
        if input.count > 2 {
            return TextFormatter.textToCurrency(inputAmount)
        }
        if input.isEmpty {
            return "0\(self.decimalSeparator)00"
        }
        if input.count == 1 {
            return "0\(self.decimalSeparator)0\(inputAmount)"
        }
        if input.count == 2 {
            return "0\(self.decimalSeparator)\(inputAmount)"
        }
        return "0,00"
    }
    
    // MARK: - Oprion 2
    private func stringFormatter2(_ input: String) -> String {
        if let num = Int(input) {
            return String(describing: Double(num)/100).formatAsCurrency()
        }
        return "0,00"
    }
}

#Preview {
    ContentView()
}
