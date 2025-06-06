//
//  VisualComponentView.swift
//  SDUIiOS
//
//  Created by Philippe Robin on 28/05/2025.
//

import SwiftUI

struct VisualComponentView: View {
    
    let visualComponent: VisualComponent
    let state: State
    
    init(_ visualComponent: VisualComponent) {
        self.visualComponent = visualComponent
        self.state = visualComponent.state
    }
    
    var body: some View {
        if visualComponent.style.visibility ?? true {
            AnyView(erasing: (visualComponent as! VisualProtocol).view())
                .privacySensitive(visualComponent.style.privacy ?? false)
        }
    }
}

