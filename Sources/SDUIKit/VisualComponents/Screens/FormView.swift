//
//  FormView.swift
//  SDUIiOS
//
//  Created by Philippe Robin on 28/05/2025.
//

import SwiftUI

struct FormView: View {
    
    let form: Form
    
    init(form: Form) {
        self.form = form
    }
    
    var body: some View {
        ScreenView(screen: form) {
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    ComponentsView(components: form.components)
                }
            }
        }
    }
}
