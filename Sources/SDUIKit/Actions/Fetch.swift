import Foundation

@MainActor class Fetch: Action {
    
    let methodExpression: StringExpression?
    let urlExpression: StringExpression
    let headerExpressions: [String: StringExpression]?
    let booleanExpressions: [String: BooleanExpression]?
    let numberExpresions: [String: NumberExpression]?
    let stringExpressions: [String: StringExpression]?
    let errorTitleExpression: StringExpression?
    let registrar: Registrar
    
    required init(object: JSONObject, registrar: Registrar) {
        self.registrar = registrar
        methodExpression = registrar.parseStringExpression(object: object["method"])
        urlExpression = registrar.parseStringExpression(object: object["url"])!
        headerExpressions = (object["headers"] as? [String: JSONValue])?.mapValues { registrar.parseStringExpression(object: $0)! }
        booleanExpressions = (object["booleans"] as? [String: JSONValue])?.mapValues { registrar.parseBooleanExpression(object: $0)! }
        numberExpresions = (object["numbers"] as? [String: JSONValue])?.mapValues { registrar.parseNumberExpression(object: $0)! }
        stringExpressions = (object["strings"] as? [String: JSONValue])?.mapValues { registrar.parseStringExpression(object: $0)! }
        errorTitleExpression = registrar.parseStringExpression(object: object["errorTitle"])
    }
    
    func run(screen: Screen) async throws(ActionError) {
        screen.stack?.showOverlay(true)
        defer { screen.stack?.showOverlay(false) }
        let method = methodExpression?.compute(state: screen.state)
        let urlString = urlExpression.compute(state: screen.state)!
        let headers = headerExpressions?.mapValues { $0.compute(state: screen.state) }
        let booleans = booleanExpressions?.mapValues { $0.compute(state: screen.state) }
        let numbers = numberExpresions?.mapValues { $0.compute(state: screen.state) }
        let strings = stringExpressions?.mapValues { $0.compute(state: screen.state) }
        let errorTitle = errorTitleExpression?.compute(state: screen.state)
   
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = method ?? "GET"
        
        if let headers = headers {
            for (key, value) in headers {
                if let value {
                    request.addValue(value, forHTTPHeaderField: key)
                }
            }
        }
        
        if booleans != nil || numbers != nil || strings != nil {
            var json: [String: Any] = [:]
            for (key, value) in booleans ?? [:] {
                json[key] = value
            }
            for (key, value) in numbers ?? [:] {
                json[key] = value
            }
            for (key, value) in strings ?? [:] {
                json[key] = value
            }
            
            request.httpBody = try! JSONSerialization.data(withJSONObject: json, options: [])
        }

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            let  statusCode = (response as! HTTPURLResponse).statusCode
            guard statusCode == 200 || statusCode == 201  else {
                throw ActionError(title: errorTitle, message: HTTPURLResponse.localizedString(forStatusCode: statusCode))
            }
            let json = try JSONDecoder().decode(AnyDecodable.self, from: data).value
            if let actions = registrar.parseActions(object: json) {
                for action in actions {
                    try await action.run(screen: screen)
                }
            }
        }
        catch let error as ActionError {
            throw error
        }
        catch {
            throw .init(title: errorTitle, message: error.localizedDescription)
        }
    }
    
}
