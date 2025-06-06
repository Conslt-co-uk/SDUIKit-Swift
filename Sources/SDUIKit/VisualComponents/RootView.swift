//
//  RootView.swift
//  SDUIiOS
//
//  Created by Philippe Robin on 28/05/2025.
//

import SwiftUI

public struct RootView: View {
    let root: Root
    
    public init(root: Root) {
        self.root = root
    }
    
    public var body: some View {
        AnyView(erasing: (root.app as! VisualProtocol).view())
    }
}
