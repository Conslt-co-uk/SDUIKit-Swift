//
//  TextFieldView.swift
//  SDUIiOS
//
//  Created by Philippe Robin on 28/05/2025.
//

import SwiftUI

struct TickView: View {
    
    let title: String
    let style: Style
    let ticked: Bool
    @SwiftUI.State var isPressed = false
    let action: ()->()
    
    var body: some View {
        
        HStack {
            Text(title)
                .styledText(style)
            Spacer()
            Image(systemName: "checkmark")
                .padding(.vertical, 6)
                .foregroundColor(ticked ? .primary : .clear)
        }
        .background {
            if isPressed {
                Color.gray.opacity(0.2)
            }
        }
        .contentShape(Rectangle())
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    isPressed = false
                    
                }
                .onEnded { _ in
                    isPressed = false
                    action()
                    // Trigger tap or action
                }
        )
        
        
    }
}


struct RadioFieldView: View {
    
    var radioField: RadioField
    @ObservedObject var state: State
    
    init(radioField: RadioField) {
        self.radioField = radioField
        self.state = radioField.state
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(radioField.values) { aSelectValue in
                let ticked = aSelectValue.value == state.stringValue(name: radioField.variable)
                TickView(title: aSelectValue.title, style: radioField.style, ticked: ticked) {
                    state.strings[radioField.variable!] = aSelectValue.value
                }
            }
        }
        .pickerStyle(.palette)
        .frame(maxWidth: .infinity)
        .styledInput(inputComponent: radioField, verticalShrink: 3.5)
    }
}
