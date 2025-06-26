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
        let otherScreens = splitStack.screens.dropFirst()
        StackView(stack: splitStack) {
            NavigationSplitView(preferredCompactColumn: $splitStack.preferredColumn) {
                VisualComponentView(splitStack.screens.first!)
                    .if(splitStack.screens.first?.style.width != nil) {
                        $0.navigationSplitViewColumnWidth(ideal: splitStack.screens.first?.style.width ?? 400)
                    }
                    
            } detail: {
                NavigationStack(path: $splitStack.path) {
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
