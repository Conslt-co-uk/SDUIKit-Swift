//
//  RootView.swift
//  SDUIiOS
//
//  Created by Philippe Robin on 28/05/2025.
//

import SwiftUI

public struct SDUIView: View {
    let root: Root
    
    public init(json: Any, callback: (([String: Any]) -> ())? = nil) {
        self.root = Root(json: json as! JSONObject, callback: callback)
    }
    
    public var body: some View {
        AnyView(erasing: (root.app as! VisualProtocol).view())
    }
}
