import SwiftUI

struct StyledModifier: ViewModifier {
    let style: Style
    @Environment(\.colorScheme) private var colorScheme
    
    func body(content: Content) -> some View {
        let darkMode = colorScheme == .dark
        content
            .overlay {
                RoundedRectangle(cornerRadius: style.borderRadius ?? 0)
                    .stroke(lineWidth: style.borderWidth ?? 1)
                    .foregroundColor(Color(sduiName: style.borderColor, darkMode: darkMode))
                    .padding((style.borderWidth ?? 1) / 2)
            }
            .background {
                BackgroundView(string: style.backgroundColor)
                    .clipShape(RoundedRectangle(cornerRadius: style.borderRadius ?? 0))
            }
            .clipShape(RoundedRectangle(cornerRadius: style.borderRadius ?? 0))
    }
}

extension View {
    func styled(_ style: Style) -> some View {
        self.modifier(StyledModifier(style: style))
    }
}
