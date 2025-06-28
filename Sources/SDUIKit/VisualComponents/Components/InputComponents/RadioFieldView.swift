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
   
    var margin: CGFloat {
        if ["underlined", "inside", "outside"].contains(style.variant ?? "") {
            return style.innerMargin ?? 0
        } else {
            return (style.innerMargin ?? 0) + (style.margin ?? 0)
        }
    }

    var body: some View {
        
        SwiftUI.Button {
            action()
        } label: {
            HStack {
                Image(systemName: "checkmark")
                    .padding(.vertical, 6)
                    .foregroundColor(ticked ? .primary : .clear)
                Text(title)
                    .styledText(style)
                Spacer()
               
            }
            .contentShape(Rectangle())
            .padding(.horizontal, margin)
        }
        .buttonStyle(TickButtonStyle())
        .padding(.horizontal, -margin)
        
    }
    
    struct TickButtonStyle: ButtonStyle {
        
        func makeBody(configuration: Configuration) -> some View {
            ZStack {
                if configuration.isPressed {
                    Color.secondary.opacity(0.2)
                        
                }
                configuration.label
            }
        }
    }
}


struct RadioFieldView: View {
    
    var radioField: RadioField
    @ObservedObject var state: State
    @SwiftUI.State var isPressed = false
    
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
        .frame(maxWidth: .infinity)
        .styledInput(inputComponent: radioField, verticalShrink: 3.5)
    }
}
