//
//  TextFieldView.swift
//  SDUIiOS
//
//  Created by Philippe Robin on 28/05/2025.
//

import SwiftUI

struct TextFieldView: View {
    
    var textField: SDUITextField
    @ObservedObject var state: State
    
    init(textField: SDUITextField) {
        self.textField = textField
        self.state = textField.state
    }
    
    // only on iOS
    #if os(iOS)
    
    var keyboardType: UIKeyboardType {
        switch textField.content {
        case "email": return .emailAddress
        case "tel": return .phonePad
        default: return .default
        }
    }
    
    var autocapitalization: TextInputAutocapitalization {
        switch textField.content {
        case "email":
            return .never
        case "tel":
            return .never
        default:
            return .sentences
        }
    }
    
    var contentType: UITextContentType? {
        switch textField.content {
        case "email":
            return .emailAddress
        case "tel":
            return .telephoneNumber
        default:
            return nil
        }
    }
    
    #endif
    
    var body: some View {
        SwiftUI.TextField(text: textField.state.stringBinding(name: textField.variable!) ?? "", prompt: Text(textField.placeholder ?? "")) { Text("") }
            .autocorrectionDisabled(textField.content != nil)
        #if os(iOS)
            .keyboardType(keyboardType)
            .textInputAutocapitalization(autocapitalization)
            .textContentType(contentType)
        #endif
            .styledInput(inputComponent: textField)
        }
}

