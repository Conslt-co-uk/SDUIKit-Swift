import Foundation
import Combine

@Observable
@MainActor public class Screen: VisualComponent, ContainerProtocol {
    
    struct AlertViewModel: Identifiable {
        
        enum Role {
            case standard
            case destructive
            case cancel
        }
        
        struct Button: Identifiable {
            let id: UUID = UUID()
            let title: String
            let role: Role
            let action: () -> Void
        }
        
        let id = UUID()
        let title: String
        let message: String?
        let buttons: [Button]
        
        init(title: String?, message: String, buttons: [Button]) {
            if let title = title {
                self.title = title
                self.message = message
            } else {
                self.title = message
                self.message = nil
            }
            self.buttons = buttons
        }
    }
    
    weak var stack: Stack?
    public var components: [Component] = []
    let copyState: Bool

    var name: String?
    var title: String?
    var ignoreSafeArea: String?
    
    let nameExpression: StringExpression?
    let titleExpression: StringExpression
    let ignoreSafeAreaExpression: StringExpression?
    
    var showAlert: Bool = false
    {
        didSet {
            if !showAlert && oldValue != showAlert {
                alertViewModel = nil
            }
        }
    }
    var alertViewModel: AlertViewModel? {
        didSet {
            showAlert = alertViewModel != nil
        }
    }
    
    required init(object: JSONObject, stack: Stack, state: State, registrar: Registrar) {
        self.stack = stack
        let copyState = object["copyState"] as? Bool ?? false
        self.copyState = copyState
        let state = copyState ? state.copy() : state
        titleExpression = registrar.parseStringExpression(object: object["title"]!)!
        nameExpression = registrar.parseStringExpression(object: object["name"])
        ignoreSafeAreaExpression = registrar.parseStringExpression(object: object["ignoreSafeArea"])
        super.init(object: object, state: state, registrar: registrar, stylesheet: stack.app!.stylesheet)
        self.components = ((object["components"] as? [JSONValue]) ?? []).compactMap {
            registrar.parseComponent(object: $0, screen: self)
        }
    }
    
    override func updateVariables() {
        title = titleExpression.compute(state: state)
        name = nameExpression?.compute(state: state)
        ignoreSafeArea = ignoreSafeAreaExpression?.compute(state: state)
        super.updateVariables()
    }
    
    func run(actions: [Action]) async {
        do {
            for action in actions {
                try await action.run(screen: self)
            }
        } catch let error {
            await showAlert(title: error.title, message: error.message)
        }
    }
    
    func showAlert(title: String?, message: String) async {
        await withCheckedContinuation { continuation in
            let okButton = AlertViewModel.Button(title: "OK", role: .standard) {
                continuation.resume()
            }
            alertViewModel = .init(title: "Alert", message: message, buttons: [okButton])
        }
    }
    
    func showConfirmation(title: String?, message: String) async -> Bool {
        return await withCheckedContinuation { continuation in
            let cancelButton = AlertViewModel.Button(title: "Cancel", role: .cancel) {
                continuation.resume(returning: false)
            }
            let okButton = AlertViewModel.Button(title: "OK", role: .standard) {
                continuation.resume(returning: true)
            }
            alertViewModel = .init(title: "Alert", message: message, buttons: [cancelButton, okButton])
        }
    }
    
}
