
struct Style {

    let style: String?
    let variant: String?
    let visibility: Bool?
    let privacy: Bool?
    let alignment: String?
    let bold: Bool?
    let italic: Bool?
    let underlined: Bool?
    let color: String?
    let size: Double?
    let font: String?
    let innerMargin: Double?
    let margin: Double?
    let titleWidth: Double?
    let spaceBefore: Double?
    let spaceAfter: Double?
    let maxWidth: Double?
    let borderRadius: Double?
    let backgroundColor: String?
    let borderColor: String?
    let borderWidth: Double?
    let height: Double?
    let width: Double?
    let shadow: Double?
    
    init(style: String? = nil, variant: String? = nil, visibility: Bool? = nil, privacy: Bool? = nil, alignment: String? = nil, bold: Bool? = nil, italic: Bool? = nil, underlined: Bool? = nil, color: String? = nil, size: Double? = nil, font: String? = nil, innerMargin: Double? = nil, margin: Double? = nil, titleWidth: Double? = nil, spaceBefore: Double? = nil, spaceAfter: Double? = nil, maxWidth: Double? = nil, borderRadius: Double? = nil, backgroundColor: String? = nil, borderColor: String? = nil, borderWidth: Double? = nil, height: Double? = nil, width: Double? = nil, shadow: Double? = nil) {
        self.style = style
        self.variant = variant
        self.visibility = visibility
        self.privacy = privacy
        self.alignment = alignment
        self.bold = bold
        self.italic = italic
        self.underlined = underlined
        self.color = color
        self.size = size
        self.font = font
        self.innerMargin = innerMargin
        self.margin = margin
        self.titleWidth = titleWidth
        self.spaceBefore = spaceBefore
        self.spaceAfter = spaceAfter
        self.maxWidth = maxWidth
        self.borderRadius = borderRadius
        self.backgroundColor = backgroundColor
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.height = height
        self.width = width
        self.shadow = shadow
    }
    
    init(object: JSONObject) {
        style = object["style"] as? String
        variant = object["variant"] as? String
        visibility = object["visibility"] as? Bool
        privacy = object["privacy"] as? Bool
        alignment = object["alignment"] as? String
        bold = object["bold"] as? Bool
        italic = object["italic"] as? Bool
        underlined = object["underlined"] as? Bool
        color = object["color"] as? String
        size = object["size"] as? Double
        font = object["font"] as? String
        innerMargin = object["innerMargin"] as? Double
        margin = object["margin"] as? Double
        titleWidth = object["titleWidth"] as? Double
        spaceBefore = object["spaceBefore"] as? Double
        spaceAfter = object["spaceAfter"] as? Double
        maxWidth = object["maxWidth"] as? Double
        borderRadius = object["borderRadius"] as? Double
        backgroundColor = object["backgroundColor"] as? String
        borderColor = object["borderColor"] as? String
        borderWidth = object["borderWidth"] as? Double
        height = object["height"] as? Double
        width = object["width"] as? Double
        shadow = object["shadow"] as? Double
    }
    
    func add(style: Style) -> Style {
        return Style(style: self.style ?? style.style,
                     variant: variant ?? style.variant,
                     visibility: visibility ?? style.visibility,
                     privacy: privacy ?? style.privacy,
                     alignment: alignment ?? style.alignment,
                     bold: bold ?? style.bold,
                     italic: italic ?? style.italic,
                     underlined: underlined ?? style.underlined,
                     color: color ?? style.color,
                     size: size ?? style.size,
                     font: font ?? style.font,
                     innerMargin: innerMargin ?? style.innerMargin,
                     margin: margin ?? style.margin,
                     spaceBefore: spaceBefore ?? style.spaceBefore,
                     spaceAfter: spaceAfter ?? style.spaceAfter,
                     maxWidth: maxWidth ?? style.maxWidth,
                     borderRadius: borderRadius ?? style.borderRadius,
                     backgroundColor: backgroundColor ?? style.backgroundColor,
                     borderColor: borderColor ?? style.borderColor,
                     borderWidth: borderWidth ?? style.borderWidth,
                     height: height ?? style.height,
                     width: width ?? style.width,
                     shadow: shadow ?? style.shadow)
    }
    
}
