import Foundation
import SwiftUI
import Combine

@MainActor @Observable public class VisualComponent: Identifiable{
    
    public let id: UUID = UUID()
    let state: State

    var style: Style = Style(object: [:])
    var currentFontSizeMultiplier: CGFloat = 1
    
    private let styleExpression: StyleExpression
    
    var cancellables = Set<AnyCancellable>()
    
    static let typeName: String = "visual"
    
    init(object: JSONObject, state: State, registrar: Registrar, stylesheet: Stylesheet) {
        self.state = state
        self.styleExpression = StyleExpression(object: object, registrar: registrar, stylesheet: stylesheet, styleName: object["style"] as? String ?? Self.typeName)
        
        state.$booleans
            .dropFirst()
            .sink { _ in
                Task {
                    self.updateVariables()
                }
            }
            .store(in: &cancellables)
        state.$numbers
            .dropFirst()
            .sink { _ in
                Task {
                    self.updateVariables()
                }
            }
            .store(in: &cancellables)
        state.$strings
            .dropFirst()
            .sink { _ in
                Task {
                    self.updateVariables()
                }
            }
            .store(in: &cancellables)
        updateVariables()
    }
    
    func updateFontSizeMultiplier() {
        let baseFont = UIFont.systemFont(ofSize: 17)
        let scaledFont = UIFontMetrics.default.scaledFont(for: baseFont)
        currentFontSizeMultiplier = scaledFont.pointSize / baseFont.pointSize
    }
    
    func updateVariables() {
        style = styleExpression.style(state: state)
    }
    
}
