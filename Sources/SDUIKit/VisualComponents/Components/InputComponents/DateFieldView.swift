//
//  TextFieldView.swift
//  SDUIiOS
//
//  Created by Philippe Robin on 28/05/2025.
//
import Foundation
import SwiftUI

struct DateFieldView: View {
    
    var dateField: DateField
    @ObservedObject var state: State
    
    init(dateField: DateField) {
        self.dateField = dateField
        self.state = dateField.state
    }
    
    var body: some View {
        let range = (dateField.min ?? .distantPast) ... (dateField.max ?? .distantFuture)
        HStack {
            
            switch dateField.picker {
            case "wheel":
                DatePicker("",
                           selection: dateField.state.dateBinding(name: dateField.variable!) ?? Date(),
                           in: range,
                           displayedComponents: .date)
                .datePickerStyle(.wheel)
                .styledText(dateField.style)
            case "calendar":
                DatePicker("",
                           selection: dateField.state.dateBinding(name: dateField.variable!) ?? Date(),
                           in: range,
                           displayedComponents: .date)
                .datePickerStyle(.graphical)
                .styledText(dateField.style)
            default:
                Spacer()
                DatePicker("",
                           selection: dateField.state.dateBinding(name: dateField.variable!) ?? Date(),
                           in: range,
                           displayedComponents: .date)
                .datePickerStyle(.compact)
                .styledText(dateField.style)
            }
            
        }
        .frame(maxWidth: .infinity)
        .styledInput(inputComponent: dateField, verticalShrink: 3.5)
    }
}

