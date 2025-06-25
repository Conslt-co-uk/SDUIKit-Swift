//
//  NavigationView.swift
//  SDUIiOS
//
//  Created by Philippe Robin on 28/05/2025.
//

import SwiftUI

struct SplitStackView: View {
    
    @Bindable var splitStack: SplitStack
    
    var body: some View {
        StackView(stack: splitStack) {
            NavigationSplitView(preferredCompactColumn: $splitStack.preferredColumn) {
                VisualComponentView(splitStack.screens.first!)
            } detail: {
                NavigationStack(path: $splitStack.path) {
                    let otherScreens = splitStack.screens.dropFirst()
                    if let firstScreen = otherScreens.first {
                        VisualComponentView(firstScreen)
                            .navigationDestination(for: Int.self) { index in
                                VisualComponentView(otherScreens[index])
                            }
                    }
                }
            }
        }
    }
}
