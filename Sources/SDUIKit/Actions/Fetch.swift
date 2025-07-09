import Foundation

@MainActor class Fetch: Action {
    
    let methodExpression: StringExpression?
    let urlExpression: StringExpression
    let headerExpressions: [String: StringExpression]?
    let booleanExpressions: [String: BooleanExpression]?
    let numberExpresions: [String: NumberExpression]?
    let stringExpressions: [String: StringExpression]?
    let errorTitleExpression: StringExpression?
    let mustSucceedExpression: BooleanExpression?
    
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
        mustSucceedExpression = registrar.parseBooleanExpression(object: object["mustSucceed"])
    }
    
    func run(screen: Screen) async throws(ActionError) {
        guard let session = screen.stack?.app?.root?.urlSession else { return }
        screen.stack?.showOverlay(true)
        let method = methodExpression?.compute(state: screen.state)
        let urlString = urlExpression.compute(state: screen.state)!
        let headers = headerExpressions?.mapValues { $0.compute(state: screen.state) }
        let booleans = booleanExpressions?.mapValues { $0.compute(state: screen.state) }
        let numbers = numberExpresions?.mapValues { $0.compute(state: screen.state) }
        let strings = stringExpressions?.mapValues { $0.compute(state: screen.state) }
        let errorTitle = errorTitleExpression?.compute(state: screen.state)
        let mustSucceed = mustSucceedExpression?.compute(state: screen.state) ?? false
   
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = method ?? "GET"
        
        if method == "POST" {
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
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
            let (data, response) = try await session.data(for: request)
            let  statusCode = (response as! HTTPURLResponse).statusCode
            guard statusCode == 200 || statusCode == 201  else {
                throw ActionError(title: errorTitle, message: HTTPURLResponse.localizedString(forStatusCode: statusCode))
            }
            let string = String(data: data, encoding: .utf8)!
            print(string)
            let json = try JSONDecoder().decode(AnyDecodable.self, from: data).value
            screen.stack?.showOverlay(false)
            try? await Task.sleep(nanoseconds: 1_000)
            if let actions = registrar.parseActions(object: (json as? JSONObject)?["actions"]) {
                for action in actions {
                    try await action.run(screen: screen)
                }
            }
        }
        catch {
            screen.stack?.showOverlay(false)
             if let error = error as? ActionError {
                 if mustSucceed {
                     await screen.showAlert(title: error.title, message: error.message ?? "")
                     try? await Task.sleep(nanoseconds: 10_000_000)
                     try await run(screen: screen)
                     return
                 } else {
                     throw error
                 }
            } else {
                if mustSucceed {
                    await screen.showAlert(title: errorTitle, message: error.localizedDescription)
                    try? await Task.sleep(nanoseconds: 10_000_000)
                    try await run(screen: screen)
                    return
                } else {
                    throw ActionError(title: errorTitle, message: error.localizedDescription)
                }
                
            }
        }
    }
    
}
