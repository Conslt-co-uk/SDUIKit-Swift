import Foundation
import SwiftUI

@MainActor public class App: VisualComponent {
    
    var rootStack: Stack!
    weak var root: Root? = nil
    
    required init(object: JSONObject, registrar: Registrar) {
        let state = State(object: object["state"] as? JSONObject)
        let startURLString = UserDefaults.standard.url(forKey: "app_startURL")
        if let startURLString = startURLString?.absoluteString {
            state.strings["app.startURL"] = startURLString
        }
        let stylesheet = Stylesheet(object: object)
        registrar.updateComponents(stylesheet.components)
        super.init(object: object, state: state, registrar: registrar, stylesheet: stylesheet)
        var stacks = registrar.parseStacks(object: object["stacks"], state: state, app: self) ?? []
        rootStack = stacks.removeFirst()
        var stack = rootStack!
        while !stacks.isEmpty {
            let newStack = stacks.removeFirst()
            stack.presentedStack = newStack
            stack = newStack
        }
    }
    
    func present(stack: Stack) {
        var aStack = rootStack!
        while let presentedStack = aStack.presentedStack {
            aStack = presentedStack
        }
        aStack.presentedStack = stack
        updateURL()
    }
    
    func close() {
        var firstStack = rootStack
        var secondStack = firstStack!.presentedStack
        while let presentedStack = secondStack?.presentedStack {
            firstStack = secondStack
            secondStack = presentedStack
        }
        firstStack?.presentedStack = nil
        updateURL()
    }
    
    func replaceScreen(screenObject: JSONObject, registrar: Registrar) {
        var aStack = rootStack!
        while let presentedStack = aStack.presentedStack {
            aStack.replaceScreen(screenObject: screenObject, registrar: registrar)
            aStack = presentedStack
        }
        aStack.replaceScreen(screenObject: screenObject, registrar: registrar)
        updateURL()
    }
    
    func state(name: String) -> State? {
        var aStack: Stack? = rootStack
        repeat {
            if let state = aStack?.state(name: name) {
                return state
            }
            aStack = aStack?.presentedStack
        } while aStack != nil
        return nil
    }
    
    var topStack: Stack? {
        var stack: Stack? = rootStack
        while stack?.presentedStack != nil {
            stack = stack?.presentedStack
        }
        return stack
    }
    
    func updateURL() {
        if let urlString = topStack?.topScreen?.state.stringValue(name: "app.startURL") as? String {
            UserDefaults.standard.set(urlString, forKey: "app_startURL")
            UserDefaults.standard.synchronize()
        }
    }
}
