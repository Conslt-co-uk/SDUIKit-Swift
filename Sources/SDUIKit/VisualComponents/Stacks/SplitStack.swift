import Foundation
import SwiftUI

@Observable @MainActor
class SplitStack: Stack, VisualProtocol {

    var columnVisibility =  NavigationSplitViewVisibility.automatic
    
    
    func showDetails(screen: Screen) {
        screens = [screens.first!, screen]
        print("columnVisibility: \(columnVisibility)")
        columnVisibility = .detailOnly
    }
    
    @ViewBuilder
    func view() -> any View
    {
        SplitStackView(splitStack: self)
    }

}
