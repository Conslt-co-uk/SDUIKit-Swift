
@MainActor
struct StyleExpression {
    
    private let variantExpression: StringExpression
    private let visibilityExpression: BooleanExpression
    private let privacyExpression: BooleanExpression
    private let alignmentExpression: StringExpression
    private let boldExpression: BooleanExpression
    private let italicExpression: BooleanExpression
    private let underlinedExpression: BooleanExpression
    private let colorExpression: StringExpression
    private let sizeExpression: NumberExpression
    private let fontExpression: StringExpression
    private let innerMarginExpression: NumberExpression
    private let marginExpression: NumberExpression
    private let titleWidthExpression: NumberExpression
    private let spaceBeforeExpression: NumberExpression
    private let spaceAfterExpression: NumberExpression
    private let maxWidthExpression: NumberExpression
    private let borderRadiusExpression: NumberExpression
    private let backgroundColorExpression: StringExpression
    private let borderColorExpression: StringExpression
    private let borderWidthExpression: NumberExpression
    private let heightExpression: NumberExpression
    private let widthExpression: NumberExpression
    private let shadowExpression: NumberExpression
    
    init(object: JSONObject, registrar: Registrar, stylesheet: Stylesheet, styleName: String, prefix: String? = nil) {
        let style = stylesheet.compactedStyle(name: styleName)
        if let prefix {
            self.variantExpression = registrar.parseStringExpression(object: object[prefix + "Variant"]) ?? StringConstant(constant: style?.variant)
            self.visibilityExpression = registrar.parseBooleanExpression(object: object[prefix + "Visibility"]) ?? BooleanConstant(constant: style?.visibility)
            self.privacyExpression = registrar.parseBooleanExpression(object: object[prefix + "Privacy"]) ?? BooleanConstant(constant: style?.privacy)
            self.alignmentExpression = registrar.parseStringExpression(object: object[prefix + "Alignment"]) ?? StringConstant(constant: style?.alignment)
            self.boldExpression = registrar.parseBooleanExpression(object: object[prefix + "Bold"]) ?? BooleanConstant(constant: style?.bold)
            self.italicExpression = registrar.parseBooleanExpression(object: object[prefix + "Italic"]) ?? BooleanConstant(constant: style?.italic)
            self.underlinedExpression = registrar.parseBooleanExpression(object: object[prefix + "Underlined"]) ?? BooleanConstant(constant: style?.underlined)
            self.colorExpression = registrar.parseStringExpression(object: object[prefix + "Color"]) ?? StringConstant(constant: style?.color)
            self.sizeExpression = registrar.parseNumberExpression(object: object[prefix + "Size"]) ?? NumberConstant(constant: style?.size)
            self.fontExpression = registrar.parseStringExpression(object: object[prefix + "Font"]) ?? StringConstant(constant: style?.font)
            self.innerMarginExpression = registrar.parseNumberExpression(object: object[prefix + "InnerMargin"]) ?? NumberConstant(constant: style?.innerMargin)
            self.marginExpression = registrar.parseNumberExpression(object: object[prefix + "Margin"]) ?? NumberConstant(constant: style?.margin)
            self.titleWidthExpression = registrar.parseNumberExpression(object: object[prefix + "TitleWidth"]) ?? NumberConstant(constant: style?.titleWidth)
            self.spaceBeforeExpression = registrar.parseNumberExpression(object: object[prefix + "SpaceBefore"]) ?? NumberConstant(constant: style?.spaceBefore)
            self.spaceAfterExpression = registrar.parseNumberExpression(object: object[prefix + "SpaceAfter"]) ?? NumberConstant(constant: style?.spaceAfter)
            self.maxWidthExpression = registrar.parseNumberExpression(object: object[prefix + "MaxWidth"]) ?? NumberConstant(constant: style?.maxWidth)
            self.borderRadiusExpression = registrar.parseNumberExpression(object: object[prefix + "BorderRadius"]) ?? NumberConstant(constant: style?.borderRadius)
            self.backgroundColorExpression = registrar.parseStringExpression(object: object[prefix + "BackgroundColor"]) ?? StringConstant(constant: style?.backgroundColor)
            self.borderColorExpression = registrar.parseStringExpression(object: object[prefix + "BorderColor"]) ?? StringConstant(constant: style?.borderColor)
            self.borderWidthExpression = registrar.parseNumberExpression(object: object[prefix + "BorderWidth"]) ?? NumberConstant(constant: style?.borderWidth)
            self.heightExpression = registrar.parseNumberExpression(object: object[prefix + "Height"]) ?? NumberConstant(constant: style?.height)
            self.widthExpression = registrar.parseNumberExpression(object: object[prefix + "Width"]) ?? NumberConstant(constant: style?.width)
            self.shadowExpression = registrar.parseNumberExpression(object: object[prefix + "Shadow"]) ?? NumberConstant(constant: style?.shadow)
        } else {
            self.variantExpression = registrar.parseStringExpression(object: object["variant"]) ?? StringConstant(constant: style?.variant)
            self.visibilityExpression = registrar.parseBooleanExpression(object: object["visibility"]) ?? BooleanConstant(constant: style?.visibility)
            self.privacyExpression = registrar.parseBooleanExpression(object: object["privacy"]) ?? BooleanConstant(constant: style?.privacy)
            self.alignmentExpression = registrar.parseStringExpression(object: object["alignment"]) ?? StringConstant(constant: style?.alignment)
            self.boldExpression = registrar.parseBooleanExpression(object: object["bold"]) ?? BooleanConstant(constant: style?.bold)
            self.italicExpression = registrar.parseBooleanExpression(object: object["italic"]) ?? BooleanConstant(constant: style?.italic)
            self.underlinedExpression = registrar.parseBooleanExpression(object: object["underlined"]) ?? BooleanConstant(constant: style?.underlined)
            self.colorExpression = registrar.parseStringExpression(object: object["color"]) ?? StringConstant(constant: style?.color)
            self.sizeExpression = registrar.parseNumberExpression(object: object["size"]) ?? NumberConstant(constant: style?.size)
            self.fontExpression = registrar.parseStringExpression(object: object["font"]) ?? StringConstant(constant: style?.font)
            self.innerMarginExpression = registrar.parseNumberExpression(object: object["innerMargin"]) ?? NumberConstant(constant: style?.innerMargin)
            self.marginExpression = registrar.parseNumberExpression(object: object["margin"]) ?? NumberConstant(constant: style?.margin)
            self.titleWidthExpression = registrar.parseNumberExpression(object: object["titleWidth"]) ?? NumberConstant(constant: style?.titleWidth)
            self.spaceBeforeExpression = registrar.parseNumberExpression(object: object["spaceBefore"]) ?? NumberConstant(constant: style?.spaceBefore)
            self.spaceAfterExpression = registrar.parseNumberExpression(object: object["spaceAfter"]) ?? NumberConstant(constant: style?.spaceAfter)
            self.maxWidthExpression = registrar.parseNumberExpression(object: object["maxWidth"]) ?? NumberConstant(constant: style?.maxWidth)
            self.borderRadiusExpression = registrar.parseNumberExpression(object: object["borderRadius"]) ?? NumberConstant(constant: style?.borderRadius)
            self.backgroundColorExpression = registrar.parseStringExpression(object: object["backgroundColor"]) ?? StringConstant(constant: style?.backgroundColor)
            self.borderColorExpression = registrar.parseStringExpression(object: object["borderColor"]) ?? StringConstant(constant: style?.borderColor)
            self.borderWidthExpression = registrar.parseNumberExpression(object: object["borderWidth"]) ?? NumberConstant(constant: style?.borderWidth)
            self.heightExpression = registrar.parseNumberExpression(object: object["height"]) ?? NumberConstant(constant: style?.height)
            self.widthExpression = registrar.parseNumberExpression(object: object["width"]) ?? NumberConstant(constant: style?.width)
            self.shadowExpression = registrar.parseNumberExpression(object: object["shadow"]) ?? NumberConstant(constant: style?.shadow)
        }
    }
    
    func style(state: State, stylesheet: Stylesheet) -> Style {
        return Style(
                      variant: variantExpression.compute(state: state),
                      visibility: visibilityExpression.compute(state: state),
                      privacy: privacyExpression.compute(state: state),
                      alignment: alignmentExpression.compute(state: state),
                      bold: boldExpression.compute(state: state),
                      italic: italicExpression.compute(state: state),
                      underlined: underlinedExpression.compute(state: state),
                      color: stylesheet.color(name: colorExpression.compute(state: state)),
                      size: sizeExpression.compute(state: state),
                      font: fontExpression.compute(state: state),
                      innerMargin: innerMarginExpression.compute(state: state),
                      margin: marginExpression.compute(state: state),
                      titleWidth: titleWidthExpression.compute(state: state),
                      spaceBefore: spaceBeforeExpression.compute(state: state),
                      spaceAfter: spaceAfterExpression.compute(state: state),
                      maxWidth: maxWidthExpression.compute(state: state),
                      borderRadius: borderRadiusExpression.compute(state: state),
                      backgroundColor: stylesheet.color(name: backgroundColorExpression.compute(state: state)),
                      borderColor: stylesheet.color(name: borderColorExpression.compute(state: state)),
                      borderWidth: borderWidthExpression.compute(state: state),
                      height: heightExpression.compute(state: state),
                      width: widthExpression.compute(state: state),
                      shadow: shadowExpression.compute(state: state)
                      )
    }
    
}
