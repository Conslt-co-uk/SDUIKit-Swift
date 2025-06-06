//
//  AppView.swift
//  SDUIiOS
//
//  Created by Philippe Robin on 28/05/2025.
//

import SwiftUI

struct ClassicAppView: View {
    
    let app: App
    
    init(app: App) {
        self.app = app
    }
    
    var body: some View {
        VisualComponentView(app.rootStack)
    }
}
