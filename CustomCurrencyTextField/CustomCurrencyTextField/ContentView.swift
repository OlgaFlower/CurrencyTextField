//
//  ContentView.swift
//  CustomCurrencyTextField
//
//  Created by Olha Bereziuk on 07.05.24.
//

import SwiftUI

import SwiftUI
import Combine

struct ContentView: View {
    
    // MARK: - State -
    @FocusState var isKeyboardFocused: Bool
    @State private var inputAmount = ""
    @State private var displyedNumber = "0,00"
    
    // MARK: - Properties -
    let currency: String = "UAH"
    
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
                                // Format the input amount as currency
                                if inputAmount.count > 2 {
                                    displyedNumber = TextFormatter.textToCurrency(inputAmount)
                                }
                                if inputAmount.isEmpty {
                                    displyedNumber = "0\(Constants.decimalSeparator)00"
                                }
                                if inputAmount.count == 1 {
                                    displyedNumber = "0\(Constants.decimalSeparator)0\(inputAmount)"
                                }
                                if inputAmount.count == 2 {
                                    displyedNumber = "0\(Constants.decimalSeparator)\(inputAmount)"
                                }
                            }
                    }
                }
            }
            
        }
        .onTapGesture {
            self.isKeyboardFocused = false
        }
    }
}

#Preview {
    ContentView()
}
