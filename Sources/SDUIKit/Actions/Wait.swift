import Foundation

@MainActor class Wait: Action {
    
    let secondsExpression: NumberExpression
    
    required init(object: JSONObject, registrar: Registrar) {
        secondsExpression = registrar.parseNumberExpression(object: object["seconds"])!
    }
    
    func run(screen: Screen) async throws(ActionError) {
        screen.stack?.showOverlay(true)
        defer { screen.stack?.showOverlay(false) }
        let seconds = secondsExpression.compute(state: screen.state) ?? 0
        try? await Task.sleep(nanoseconds: 1_000_000_000 * UInt64(seconds))
    }
    
}
