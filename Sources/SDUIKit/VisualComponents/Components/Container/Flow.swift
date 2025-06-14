import Foundation
import SwiftUI

@MainActor @Observable class Flow: Container, VisualProtocol {
    
    @ViewBuilder
    func view() -> any View
    {
        FlowView(flow: self)
    }
}

