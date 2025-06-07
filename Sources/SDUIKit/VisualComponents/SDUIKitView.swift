//
//  RootView.swift
//  SDUIiOS
//
//  Created by Philippe Robin on 28/05/2025.
//

import SwiftUI

public struct SDUIKitView: View {
    @SwiftUI.State var root: Root
    
    public init(json: Any, callback: (([String: Any]) -> ())? = nil) {
        self.root = Root(json: json as! JSONObject, callback: callback)
    }
    
    public var body: some View {
        AnyView(erasing: (root.app as! VisualProtocol).view())
            .onOpenURL { [weak root] url in
                root?.openDeepLink(url: url)
            }
    }
}
