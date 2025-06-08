import Foundation
import SwiftUI

@MainActor @Observable class Combo: Container, VisualProtocol {
    
    @ViewBuilder
    func view() -> any View
    {
        ComboView(combo: self)
    }
}

