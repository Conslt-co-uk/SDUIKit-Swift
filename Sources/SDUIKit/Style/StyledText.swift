import SwiftUI

struct StyledTextModifier: ViewModifier {
    let style: Style
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    func body(content: Content) -> some View {
        let darkMode = colorScheme == .dark
        content
            .font(style.font != nil ? .custom(style.font!, size: style.size ?? 17) : .system(size: (style.size ?? 17) * multiplier))
            .bold(style.bold ?? false)
            .italic(style.italic ?? false)
            .foregroundColor(Color(sduiName: style.color, darkMode: darkMode, default: .primary))
    }
    
    var multiplier: CGFloat {
        switch dynamicTypeSize {
        case .xSmall: return 0.82
        case .small: return 0.88
        case .medium: return 1.0
        case .large: return 1.12
        case .xLarge: return 1.23
        case .xxLarge: return 1.35
        case .xxxLarge: return 1.47
        case .accessibility1: return 1.61
        case .accessibility2: return 1.78
        case .accessibility3: return 1.95
        case .accessibility4: return 2.11
        case .accessibility5: return 2.29
        @unknown default: return 1.0
        }
    }
    
}

extension View {
    func styledText(_ style: Style) -> some View {
        return self.modifier(StyledTextModifier(style: style))
    }
}

extension Text {
    
    func styledText(_ style: Style, darkMode: Bool, dynamicTypeSize: DynamicTypeSize) -> Text {
        return self
            .font(style.font != nil ? .custom(style.font!, size: style.size ?? 17) : .system(size: (style.size ?? 17) * dynamicTypeSize.multiplier))
            .bold(style.bold ?? false)
            .italic(style.italic ?? false)
            .underline(style.underlined ?? false)
            .foregroundColor(Color(sduiName: style.color, darkMode: darkMode, default: .primary))
    }
}



