import Foundation

@MainActor class OpenURL: Action {
    
    let urlExpression: StringExpression
    
    required init(object: JSONObject, registrar: Registrar) {
        urlExpression = registrar.parseStringExpression(object: object["url"])!
    }
    
    func run(screen: Screen) async throws(ActionError) {
        guard let urlString = urlExpression.compute(state: screen.state),
              let url = URL(string: urlString) else { return }
        OS.openURL(url)
    }
    
}
