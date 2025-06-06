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
    
    var body: some View {
        SwiftUI.TextField(text: textField.state.stringBinding(name: textField.variable!) ?? "", prompt: Text(textField.placeholder ?? "")) { Text("") }
            .keyboardType(keyboardType)
            .textInputAutocapitalization(autocapitalization)
            .autocorrectionDisabled(textField.content != nil)
            .textContentType(contentType)
            .styledInput(inputComponent: textField)
        }
}

