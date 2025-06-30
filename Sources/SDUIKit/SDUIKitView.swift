//
//  RootView.swift
//  SDUIiOS
//
//  Created by Philippe Robin on 28/05/2025.
//

import SwiftUI

public struct SDUIKitView: View {
    
    @SwiftUI.State var root: Root
    
    public init(root: Root) {
        self.root = root
    }
    
    public var body: some View {
        AnyView(erasing: (root.app as! VisualProtocol).view())
            .onOpenURL { [weak root] url in
                root?.openDeepLink(url: url)
            }
    }
}
