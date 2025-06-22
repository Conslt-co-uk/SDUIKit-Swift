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
    var url: URL?
    var ignoreSafeArea: String?
    var actions: [Action]?
    var largeTitle = false
    var customBarTitle = false
    var leftButtons: [Button]?
    var rightButtons: [Button]?
    var navigationBarStyle: Style = Style(object: [:])
    
    let nameExpression: StringExpression?
    let titleExpression: StringExpression
    let urlExpression: StringExpression?
    let ignoreSafeAreaExpression: StringExpression?
    let activity = NSUserActivity(activityType: NSUserActivityTypeBrowsingWeb)
    let largeTitleExpression: BooleanExpression?
    let navigationBarStyleExpression: StyleExpression?
    
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
    
    required init(object: JSONObject, stack: Stack, state: State, registrar: Registrar, typeName: String? = nil) {
        self.stack = stack
        let copyState = object["copyState"] as? Bool ?? false
        self.copyState = copyState
        let state = copyState ? state.copy() : state
        titleExpression = registrar.parseStringExpression(object: object["title"]!)!
        urlExpression = registrar.parseStringExpression(object: object["url"])
        nameExpression = registrar.parseStringExpression(object: object["name"])
        largeTitleExpression = registrar.parseBooleanExpression(object: object["largeTitle"])
        ignoreSafeAreaExpression = registrar.parseStringExpression(object: object["ignoreSafeArea"])
        actions = registrar.parseActions(object: object["actions"])
        navigationBarStyleExpression = StyleExpression(object: object, registrar: registrar, stylesheet: stack.app!.stylesheet, styleName: "navigationBar")
        super.init(object: object, state: state, registrar: registrar, stylesheet: stack.app!.stylesheet, typeName: typeName)
        leftButtons = registrar.parseComponents(object: object["leftButtons"], screen: self)?.filter { $0 is Button} as? [Button]
        rightButtons = registrar.parseComponents(object: object["rightButtons"], screen: self)?.filter { $0 is Button} as? [Button]
        components = registrar.parseComponents(object: object["components"], screen: self)!
    }
    
    override func updateVariables() {
        title = titleExpression.compute(state: state)
        if let urlString = urlExpression?.compute(state: state), !urlString.isEmpty {
            url = URL(string: urlString)
        }
        name = nameExpression?.compute(state: state)
        ignoreSafeArea = ignoreSafeAreaExpression?.compute(state: state) ?? "all"
        largeTitle = largeTitleExpression?.compute(state: state) ?? false
        navigationBarStyle = navigationBarStyleExpression?.style(state: state, stylesheet: stack!.app!.stylesheet).add(style: style) ?? style
        
        if navigationBarStyle.color != nil
            || navigationBarStyle.size != nil
            || navigationBarStyle.font != nil
            || navigationBarStyle.bold != nil
            || navigationBarStyle.italic != nil
            || navigationBarStyle.underlined != nil
        {
            largeTitle = false
            customBarTitle = true
        } else {
            customBarTitle = false
        }
        
        if let url = url {
            activity.title = title
            activity.webpageURL = url
            activity.isEligibleForSearch = true
            activity.isEligibleForHandoff = true
        }
        
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
    
    func onAppear() {
        if url != nil { activity.becomeCurrent() }
    }
    
    func onDisappear() {
        if url != nil { activity.resignCurrent() }
    }
    
}
