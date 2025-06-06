//
//  TextFieldView.swift
//  SDUIiOS
//
//  Created by Philippe Robin on 28/05/2025.
//
import Foundation
import SwiftUI

struct TimeFieldView: View {
    
    var timeField: TimeField
    @ObservedObject var state: State
    
    init(dateField: TimeField) {
        self.timeField = dateField
        self.state = dateField.state
    }
    
    var body: some View {
        let range = (timeField.min ?? .distantPast) ... (timeField.max ?? .distantFuture)
        HStack {
            
            switch timeField.picker {
            case "wheel":
                DatePicker("",
                           selection: timeField.state.timeBinding(name: timeField.variable!) ?? Date(),
                           in: range,
                           displayedComponents: .hourAndMinute)
                .datePickerStyle(.wheel)
                .styledText(timeField.style)
            case "calendar":
                DatePicker("",
                           selection: timeField.state.timeBinding(name: timeField.variable!) ?? Date(),
                           in: range,
                           displayedComponents: .hourAndMinute)
                .datePickerStyle(.graphical)
                .styledText(timeField.style)
            default:
                Spacer()
                DatePicker("",
                           selection: timeField.state.timeBinding(name: timeField.variable!) ?? Date(),
                           in: range,
                           displayedComponents: .hourAndMinute)
                .datePickerStyle(.compact)
                .styledText(timeField.style)
            }
            
        }
        .frame(maxWidth: .infinity)
        .styledInput(inputComponent: timeField, verticalShrink: 3.5)
    }
}

