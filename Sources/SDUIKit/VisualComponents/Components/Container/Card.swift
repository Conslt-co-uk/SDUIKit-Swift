import Foundation
import SwiftUI

@MainActor @Observable class Card: Container, VisualProtocol {
    
    @ViewBuilder
    func view() -> any View
    {
        CardView(card: self)
    }
}

