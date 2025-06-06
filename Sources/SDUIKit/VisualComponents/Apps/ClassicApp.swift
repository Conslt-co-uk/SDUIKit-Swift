import Foundation
import SwiftUI

class ClassicApp: App, VisualProtocol {
    
    @ViewBuilder
    func view() -> any View
    {
       ClassicAppView(app: self)
    }
    
}
