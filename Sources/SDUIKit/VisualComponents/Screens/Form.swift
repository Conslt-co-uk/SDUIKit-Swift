import Foundation
import SwiftUI

@Observable @MainActor
class Form: Screen, VisualProtocol {
    
    @ViewBuilder
    func view() -> any View
    {
        FormView(form: self)
    }
    
}
