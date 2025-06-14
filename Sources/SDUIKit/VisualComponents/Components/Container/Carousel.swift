import Foundation
import SwiftUI

@MainActor @Observable class Carousel: Container, VisualProtocol {
    
    @ViewBuilder
    func view() -> any View
    {
        CarouselView(carousel: self)
    }
}
