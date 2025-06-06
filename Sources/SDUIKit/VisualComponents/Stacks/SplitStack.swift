import Foundation
import SwiftUI

@Observable @MainActor
class SplitStack: Stack, VisualProtocol {

    func showDetails(screen: Screen) {
        screens = [screens.first!, screen]
    }
    
    @ViewBuilder
    func view() -> any View
    {
        SplitStackView(splitStack: self)
    }

}
