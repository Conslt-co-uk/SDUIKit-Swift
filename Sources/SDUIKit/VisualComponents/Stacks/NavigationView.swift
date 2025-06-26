//
//  NavigationView.swift
//  SDUIiOS
//
//  Created by Philippe Robin on 28/05/2025.
//

import SwiftUI

struct NavigationView: View {
    
    @Bindable var navigation: Navigation
    
    @Environment(\.colorScheme) private var colorScheme
    
    var stack: some View {
        NavigationStack(path: $navigation.path) {
            VisualComponentView(navigation.screens.first!)
                .navigationDestination(for: Int.self) { index in
                    if navigation.screens.count > index {
                        VisualComponentView(navigation.screens[index])
                    }
                }
        }
    }
    
    var body: some View {
        StackView(stack: navigation) {
            if let color = navigation.style.backgroundColor {
                stack
                    .toolbarBackground(Color(sduiName: color, darkMode: colorScheme == .dark), for: .navigationBar)
                    .toolbarBackground(.visible, for: .navigationBar)
            } else {
                stack
            }
        }
    }
    

}
