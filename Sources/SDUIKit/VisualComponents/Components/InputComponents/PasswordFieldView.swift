//
//  TextFieldView.swift
//  SDUIiOS
//
//  Created by Philippe Robin on 28/05/2025.
//

import SwiftUI

struct PasswordFieldView: View {
    
    var passwordField: PasswordField
    @ObservedObject var state: State
    @SwiftUI.State var showPassword = false
    
    init(passwordField: PasswordField) {
        self.passwordField = passwordField
        self.state = passwordField.state
    }
    
    var body: some View {
        HStack {
            if showPassword {
                ZStack {
                    SwiftUI.TextField(text: passwordField.state.stringBinding(name: passwordField.variable!) ?? "", prompt: Text(passwordField.placeholder ?? "")) { Text("") }
                        .labelsHidden()
                }
            } else {
                ZStack {
                    SwiftUI.TextField(text: passwordField.state.stringBinding(name: passwordField.variable!) ?? "", prompt: Text(passwordField.placeholder ?? "")) { Text("") }
                        .labelsHidden()
                        .opacity(0)
                    SecureField(text: passwordField.state.stringBinding(name: passwordField.variable!) ?? "", prompt: Text(passwordField.placeholder ?? "")) { Text("") }
                        .labelsHidden()
                        
                    
                }
            }
            SwiftUI.Button {
                showPassword.toggle()
            } label: {
                if showPassword {
                    Image(systemName: "eye.slash")
    
                } else {
                    ZStack {
                        Image(systemName: "eye.slash")
                            .foregroundColor(.clear)
                        Image(systemName: "eye")
                    }
                    
                }
            }

        }
        #if os(iOS)
            .textInputAutocapitalization(.never)
            .textContentType(.password)
        #endif
            .autocorrectionDisabled()
            .styledInput(inputComponent: passwordField)
        }
}

