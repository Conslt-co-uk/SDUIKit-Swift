import SwiftUI

struct StyledMarginModifier: ViewModifier {
    let style: Style

    func body(content: Content) -> some View {
            content
            .frame(width: CGFloat(style.width), height:CGFloat(style.height))
            .padding(.top, style.spaceBefore ?? 0)
            .padding(.bottom, style.spaceAfter ?? 0)
            .padding(.horizontal, style.margin ?? 0)
            .frame(maxWidth: style.maxWidth ?? .infinity)
    }
}

extension View {
    func styledMargin(_ style: Style) -> some View {
        self.modifier(StyledMarginModifier(style: style))
    }
}
