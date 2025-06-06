struct Stylesheet {
    
    let styles: [String: Style]
    let colors: [String: String]
    
    init(object: JSONObject?) {
        let styleDictionary = object?["styles"] as? [String: JSONObject]
        self.styles = styleDictionary?.compactMapValues { Style(object: $0) }.reduce(into: [:]) { result, element in
            result[element.key] = element.value
        } ?? [:]
        colors = object?["colors"] as? [String: String] ?? [:]
    }
    
    func compactedStyle(name: String) -> Style? {
        var currentStyle = styles[name]
        while let parentName = currentStyle?.style, let parentStyle = styles[parentName] {
            currentStyle = currentStyle?.add(style: parentStyle)
        }
        return currentStyle
    }
}
