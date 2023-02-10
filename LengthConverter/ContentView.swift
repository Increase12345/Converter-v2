//
//  ContentView.swift
//  LengthConverter
//
//  Created by Nick Pavlov on 2/9/23.
//

import SwiftUI

struct ContentView: View {
    @State private var measurement = ""
    @State private var inputUnit = 0
    @State private var outputUnit = 0
    
    let unitOptions = [UnitLength.millimeters,
                       UnitLength.centimeters,
                       UnitLength.inches,
                       UnitLength.feet,
                       UnitLength.yards,
                       UnitLength.meters,
                       UnitLength.kilometers,
                       UnitLength.miles]
    
    var conversionCalc: Measurement<UnitLength> {
        let inputAmount = Measurement(value: Double(measurement) ?? 0, unit: unitOptions[inputUnit])
        let outputAmount = inputAmount.converted(to: unitOptions[outputUnit])
        return outputAmount
    }
    
    var formatter: MeasurementFormatter {
        let newFormat = MeasurementFormatter()
        newFormat.unitStyle = .long
        newFormat.unitOptions = .providedUnit
        return newFormat
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("\(formatter.string(from: unitOptions[inputUnit]))", text: $measurement)
                        .keyboardType(.decimalPad)
                    
                    Picker("Input unit", selection: $inputUnit) {
                        ForEach(0..<unitOptions.count, id: \.self) {
                            let formattedOutput = formatter.string(from: unitOptions[$0])
                            Text("\(formattedOutput)")
                        }
                    }
                    
                    Picker("Output unit", selection: $outputUnit) {
                        ForEach(0..<unitOptions.count, id: \.self) {
                            let formattedOutput = formatter.string(from: unitOptions[$0])
                            Text("\(formattedOutput)")
                        }
                    }
                }
                
                Section {
                    Text(formatter.string(from: conversionCalc))
                } header: {
                    Text("Conversion")
                }
            }
            .navigationTitle("Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
