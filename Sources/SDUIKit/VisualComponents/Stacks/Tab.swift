import Foundation
import SwiftUI

@Observable @MainActor
class Tab: VisualComponent, VisualProtocol {
    
    var path: [Int] = []
    {
        didSet {
            
            if oldValue != path && path.count < screens.count - 1 {
                screens = screens[0..<path.count + 1].map(\.self)
            }
        }
    }
    
    var screens: [Screen] = [] {

        didSet {
            path = screens.indices.map(\.self).dropFirst(1).map(\.self)

        }
    }
    
    var title: String = ""
    var name: String = ""
    var badge: Int?
    
    let titleExpression: StringExpression
    let badgeExpression: NumberExpression?
    let nameExpression: StringExpression
    
    init(object: JSONObject, stack: Stack, registrar: Registrar, stylesheet: Stylesheet) {
        titleExpression = registrar.parseStringExpression(object: object["title"])!
        badgeExpression = registrar.parseNumberExpression(object: object["badge"])
        nameExpression = registrar.parseStringExpression(object: object["name"])!
        super.init(object: object, state: stack.state, registrar: registrar, stylesheet: stylesheet)
        self.screens = ((object["screens"] as? [JSONValue]) ?? []).compactMap {
            registrar.parseScreen(object: $0, stack: stack, state: stack.state)
        }
    }
    
    override func updateVariables() {
        super.updateVariables()
        title = titleExpression.compute(state: state) ?? ""
        badge = Int(badgeExpression?.compute(state: state))
        name = nameExpression.compute(state: state) ?? ""
        
    }
    
    @ViewBuilder
    func view() -> any View
    {
        TabView(tab: self)
    }
    
    func push(screen: Screen) {
        screens.append(screen)
    }
    
    func back() {
        if screens.count > 1 {
            screens.removeLast()
        }
    }
    
    func replaceScreen(screenObject: JSONObject, registrar: Registrar, stack: Stack) {
        screens = screens.map { aScreen in
            if let aName = aScreen.name, aName == screenObject["name"] as? String {
                return registrar.parseScreen(object: screenObject, stack: stack, state: aScreen.state)!
            } else {
                return aScreen
            }
        }
    }
    
    func state(name: String) -> State? {
        return screens.first(where: { $0.name == name })?.state
    }

}
