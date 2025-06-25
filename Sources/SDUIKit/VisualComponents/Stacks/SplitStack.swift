import Foundation
import SwiftUI

@Observable @MainActor
class SplitStack: Stack, VisualProtocol {

    var preferredColumn = NavigationSplitViewColumn.sidebar
    
    func showDetails(screen: Screen) {
        screens = [screens.first!, screen]
        preferredColumn = .detail
    }
    
    @ViewBuilder
    func view() -> any View
    {
        SplitStackView(splitStack: self)
    }

}
