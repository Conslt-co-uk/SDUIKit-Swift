import Foundation

struct Stylesheet {
    
    let styles: [String: Style]
    let colors: [String: String]
    let images: [String: URL]
    let components: [String: JSONValue]
    
    init(object: JSONObject?) {
        let styleDictionary = object?["styles"] as? [String: JSONObject]
        self.styles = styleDictionary?.compactMapValues { Style(object: $0) }.reduce(into: [:]) { result, element in
            result[element.key] = element.value
        } ?? [:]
        colors = object?["colors"] as? [String: String] ?? [:]
        images = (object?["images"] as? [String: String] ?? [:]).compactMapValues { URL(string: $0) }
        components = object?["library"] as? [String: JSONObject] ?? [:]
    }
    
    func color(name: String?) -> String? {
        guard let name else { return nil }
        if name.hasPrefix("#") {
            return name
        } else {
            return colors[name] ?? name
        }
    }
    
    func compactedStyle(name: String) -> Style? {
        if name == "link" {
            print("break")
        }
        guard var currentStyle = styles[name] else { return nil }
        while let parentName = currentStyle.style, let parentStyle = styles[parentName] {
            currentStyle = currentStyle.add(style: parentStyle)
        }
        return Style(style: currentStyle.style,
                             variant: currentStyle.variant,
                             visibility: currentStyle.visibility,
                             privacy: currentStyle.privacy,
                             alignment: currentStyle.alignment,
                             bold: currentStyle.bold,
                             italic: currentStyle.italic,
                             underlined: currentStyle.underlined,
                             color: currentStyle.color,
                             size: currentStyle.size,
                             font: currentStyle.font,
                             innerMargin: currentStyle.innerMargin,
                             margin: currentStyle.margin,
                             titleWidth: currentStyle.titleWidth,
                             spaceBefore: currentStyle.spaceBefore,
                             spaceAfter: currentStyle.spaceAfter,
                             maxWidth: currentStyle.maxWidth,
                             borderRadius: currentStyle.borderRadius,
                             backgroundColor: currentStyle.backgroundColor,
                             borderColor: currentStyle.borderColor,
                             borderWidth: currentStyle.borderWidth,
                             height: currentStyle.height,
                             width: currentStyle.width,
                             shadow: currentStyle.shadow)
    }
    
    func imageFor(name: String?) -> URL? {
        guard let name else { return nil }
        if images.keys.contains(name) {
            return images[name]
        } else {
            return URL(string: name)
        }
    }
}
