//
//  TextFieldView.swift
//  SDUIiOS
//
//  Created by Philippe Robin on 28/05/2025.
//

import SwiftUI

struct SelectFieldView: View {
    
    var selectField: SelectField
    @ObservedObject var state: State
    
    init(selectField: SelectField) {
        self.selectField = selectField
        self.state = selectField.state
    }
    
    var body: some View {
        HStack {
            Spacer()
            Picker(selectField.title ?? "", selection: selectField.state.stringBinding(name: selectField.variable!)) {
                ForEach(selectField.values) { aSelectValue in
                    Text(aSelectValue.title)
                        .styledText(selectField.style)
                        .tag(aSelectValue.value)
                    
                }
            }
            .styledText(selectField.style)
        }
        .frame(maxWidth: .infinity)
        .styledInput(inputComponent: selectField, verticalShrink: 3.5)
    }
}

