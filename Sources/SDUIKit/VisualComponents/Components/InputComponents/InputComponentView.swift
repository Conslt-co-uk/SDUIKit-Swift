import SwiftUI

struct InputComponentViewModifier: ViewModifier {

    let title: String?
    let errorMessage: String
    let style: Style
    let errorStyle: Style
    let titleStyle: Style
    let verticalShrink: Double
    
    func body(content: Content) -> some View {
        Group {
            switch style.variant {
            case "outside":
                VStack(spacing: 0) {
                    if let title {
                        HStack(spacing: 0) {
                            Text(title)
                                .multilineTextAlignment(.leading)
                                .styledText(titleStyle)
                            Spacer()
                        }
                        .styledMargin(titleStyle)
                        .styled(titleStyle)
                    }
                    content
                        .padding(.vertical, (style.innerMargin ?? 0) - verticalShrink)
                        .styled(style)
                    HStack(spacing: 0) {
                        Text(errorMessage)
                            .multilineTextAlignment(.leading)
                            .styledText(errorStyle)
                        Spacer()
                    }
                    .styledMargin(errorStyle)
                    .styled(errorStyle)
                }
            case "inside":
                VStack(spacing: 0) {
                    if let title {
                        HStack(spacing: 0) {
                            Text(title)
                                .multilineTextAlignment(.leading)
                                .styledText(titleStyle)
                            Spacer()
                        }
                        .styledMargin(titleStyle)
                        .styled(titleStyle)
                    }
                    content
                        .padding(.bottom, style.innerMargin ?? 0)
                }
                .styled(style)
            case "underlined":
                VStack(spacing: 0) {
                    if let title {
                        HStack(spacing: 0) {
                            Text(title)
                                .multilineTextAlignment(.leading)
                                .styledText(titleStyle)
                            Spacer()
                        }
                        .styledMargin(titleStyle)
                        .styled(titleStyle)
                        
                    }
                    content
                    SwiftUI.Divider()
                        .styled(style)
                }
            default:
                HStack {
                    if let title {
                        HStack {
                            Text(title)
                                .multilineTextAlignment(.leading)
                                .styledText(titleStyle)
                            Spacer()
                        }
                        .styledMargin(titleStyle)
                        .styled(titleStyle)
                        
                    }
                    content
                }
                .styled(style)
            }
        }
        .styledMargin(style)
    }
}

extension View {
    func styledInput(inputComponent: InputComponent, verticalShrink: Double = 0) -> some View {
        self.modifier(InputComponentViewModifier(title: inputComponent.title,
                                                 errorMessage: inputComponent.errorMessage ?? "\u{00A0}",
                                                 style: inputComponent.style,
                                                 errorStyle: inputComponent.errorStyle,
                                                 titleStyle: inputComponent.titleStyle,
                                                 verticalShrink: verticalShrink))
    }
}
