//
//  TextFieldView.swift
//  SDUIiOS
//
//  Created by Philippe Robin on 28/05/2025.
//

import SwiftUI

struct SwitchFieldView: View {
    
    var switchField: SwitchField
    @ObservedObject var state: State
    
    init(switchField: SwitchField) {
        self.switchField = switchField
        self.state = switchField.state
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(switchField.values) { aSelectValue in
                HStack {
                    Text(aSelectValue.title)
                        .styledText(switchField.style)
                    Spacer()
                    Toggle("", isOn: state.booleanBinding(name: aSelectValue.variable) ?? false)
                        .labelsHidden()
                        .padding(.vertical, 3)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .styledInput(inputComponent: switchField, verticalShrink: 3.5)
    }
}

