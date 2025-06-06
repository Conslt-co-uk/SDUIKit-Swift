import Foundation
import SwiftUI

@Observable @MainActor
class Navigation: Stack, VisualProtocol {
    
    @ViewBuilder
    func view() -> any View
    {
        NavigationView(navigation: self)
    }

}
