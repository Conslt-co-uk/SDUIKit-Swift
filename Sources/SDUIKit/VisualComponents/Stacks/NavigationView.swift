//
//  NavigationView.swift
//  SDUIiOS
//
//  Created by Philippe Robin on 28/05/2025.
//

import SwiftUI

struct NavigationView: View {
    
    @Bindable var navigation: Navigation
    
    var body: some View {
        StackView(stack: navigation) {
            NavigationStack(path: $navigation.path) {
                VisualComponentView(navigation.screens.first!)
                    .navigationDestination(for: Int.self) { index in
                        if navigation.screens.count > index {
                            VisualComponentView(navigation.screens[index])
                        }
                        
                    }
            }
        }
    }
    

}
