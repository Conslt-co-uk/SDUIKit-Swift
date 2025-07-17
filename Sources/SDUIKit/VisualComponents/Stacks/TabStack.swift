import Foundation
import SwiftUI

@Observable @MainActor
class TabStack: Stack, VisualProtocol {
    
    var variable: String
    var tabs: [TabItem] = []
    var tabBarStyle = Style(object: [:])
    let tabBarStyleExpression: StyleExpression?
    
    required init(object: JSONObject, app: App, state: State, registrar: Registrar) {
        let variableExpression = registrar.parseStringExpression(object: object["variable"])!
        tabBarStyleExpression = StyleExpression(object: object, registrar: registrar, stylesheet: app.stylesheet, styleName: "navigationBar")
        let variable = variableExpression.compute(state: state) ?? UUID().uuidString
        self.variable = variable
        super.init(object: object, app: app, state: state, registrar: registrar)
        tabs = (object["tabs"] as! [JSONObject]).map {
            TabItem(object: $0, stack: self, registrar: registrar, stylesheet: app.stylesheet)
        }
        
    }
    
    override func updateVariables() {
        super.updateVariables()
        tabBarStyle = tabBarStyleExpression?.style(state: state, stylesheet: app!.stylesheet) ?? Style(object: [:])
    }

    var currentTab: TabItem {
        let selectedName = state.stringValue(name: variable)
        if let tab = tabs.first(where: { $0.name == selectedName }) {
            return tab
        } else {
            return tabs[0]
        }
    }
    
    @ViewBuilder
    func view() -> any View
    {
        TabStackView(tabStack: self)
    }
    
    override func push(screen: Screen) {
        currentTab.push(screen: screen)
        app?.updateURL()
    }
    
    override func back(name: String?) {
        currentTab.back(name: name)
        app?.updateURL()
    }
    
    override func replaceScreen(screenObject: JSONObject, registrar: Registrar) {
        tabs.forEach { $0.replaceScreen(screenObject: screenObject, registrar: registrar, stack: self) }
        app?.updateURL()
    }
    
    override func state(name: String) -> State? {
        for aTap in tabs {
            if let state = aTap.state(name: name) {
                return state
            }
        }
        return nil
    }
    
    override var topScreen: Screen? {
        return currentTab.screens.last
    }

    func tabHasChanged() {
        app?.updateURL()
    }
}
