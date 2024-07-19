//
//  ContentView.swift
//  UnitConverter
//
//  Created by Danut Popa on 18.07.2024.
//

import SwiftUI

enum Units: String, CaseIterable {
  case km, mi, m, ft, yd
}

struct ContentView: View {
  @State private var number = 0.0
  @State private var inputUnits = Units.m
  @State private var outputUnits = Units.ft
  @FocusState private var isVisible: Bool

  let units = Units.allCases

  var conversionResult: Double {

    var conversionResult = number

    switch inputUnits {
    case .km:
      conversionResult *= 3281
    case .mi:
      conversionResult *= 5280
    case .m:
      conversionResult *= 3.281
    case .yd:
      conversionResult *= 3
    default:
      print("It's feet unit")
    }

    switch outputUnits {
    case .km:
      conversionResult /= 3281
    case .mi:
      conversionResult /= 5280
    case .m:
      conversionResult /= 3.281
    case .yd:
      conversionResult /= 3
    default:
      print("It's feet unit")
    }

    return conversionResult
  }

  var body: some View {
    NavigationStack {
      Form {
        Section("Input") {
          Picker("Unit", selection: $inputUnits) {
            ForEach(units, id: \.self) {
              Text($0.rawValue)
            }
          }
          .pickerStyle(.segmented)
        }

        Section("Output") {
          Picker("Unit", selection: $outputUnits) {
            ForEach(units, id: \.self) {
              Text($0.rawValue)
            }
          }
          .pickerStyle(.segmented)
        }

        Section("Value") {
          TextField("Enter a number", value: $number, format: .number)
            .keyboardType(.decimalPad)
            .focused($isVisible)
        }

        Section("Result") {
          Text(conversionResult.formatted())
        }
      }
      .navigationTitle("Unit Converter")
      .toolbar {
        Button("Done") {
          if isVisible {
            isVisible = false
          }
        }
      }
    }
  }
}

#Preview {
  ContentView()
}
