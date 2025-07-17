
import SwiftUI
import Foundation

@Observable @MainActor public class Stack: VisualComponent {
    
    weak var app: App?
    var presentedStack: Stack?
    var overlay: Bool = false
    
    var path: [Int] = []
    {
        didSet {
            let nbRootScreens =  (self is SplitStack) ? 2 : 1
            if oldValue != path && path.count < screens.count - nbRootScreens {
                print("didSet path: screens\(screens.count) path \(path.count)")
                screens = screens[0..<path.count + nbRootScreens].map(\.self)
                print("after path: screens\(screens.count) path \(path.count)")
            }
        }
    }
    
    var screens: [Screen] = [] {
        didSet {
            let nbRootScreens =  (self is SplitStack) ? 2 : 1
            path = screens.indices.map(\.self).dropFirst(nbRootScreens).map(\.self)
        }
    }
    
    let copyState: Bool
    
    required init(object: JSONObject, app: App, state: State, registrar: Registrar) {
        self.app = app
        let copyState = object["copyState"] as? Bool ?? false
        self.copyState = copyState
        let state = copyState ? state.copy() : state
        super.init(object: object, state: state, registrar: registrar, stylesheet: app.stylesheet)
        self.screens = registrar.parseScreens(object: object["screens"], stack: self, state: state) ?? []
    }
    
    func push(screen: Screen) {
        print("push")
        screens.append(screen)
        app?.updateURL()
    }
    
    func back(name: String?) {
        if let name {
            while screens.count > 1 && screens.last!.name != name {
                screens.removeLast()
            }
        } else if screens.count > 1 {
            screens.removeLast()
        }
        app?.updateURL()
    }
    
    func replaceScreen(screenObject: JSONObject, registrar: Registrar) {
        screens = screens.map { aScreen in
            if let aName = aScreen.name, aName == screenObject["name"] as? String {
                return registrar.parseScreen(object: screenObject, stack: self, state: aScreen.state)!
            } else {
                return aScreen
            }
        }
        app?.updateURL()
    }
    
    func state(name: String) -> State? {
        return screens.first(where: { $0.name == name })?.state
    }
    
    func showOverlay(_ newValue: Bool) {
        var transaction = Transaction()
        transaction.disablesAnimations = true
        withTransaction(transaction) {
           overlay = newValue
        }
    }
    
    var topScreen: Screen? {
        return screens.last
    }
}
