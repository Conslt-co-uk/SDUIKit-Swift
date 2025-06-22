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
    let stylesheet: Stylesheet
    
    
    init(object: JSONObject, state: State, registrar: Registrar, stylesheet: Stylesheet, typeName: String? = nil) {
        self.state = state
        self.stylesheet = stylesheet
        self.styleExpression = StyleExpression(object: object, registrar: registrar, stylesheet: stylesheet, styleName: object["style"] as? String ?? typeName ?? "visualComponent")
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
        #if os(macOS)
        currentFontSizeMultiplier = 1
        #else
        let baseFont = UIFont.systemFont(ofSize: 17)
        let scaledFont = UIFontMetrics.default.scaledFont(for: baseFont)
        currentFontSizeMultiplier = scaledFont.pointSize / baseFont.pointSize
        #endif
    }
    
    func updateVariables() {
        style = styleExpression.style(state: state, stylesheet: stylesheet)
    }
    
}
