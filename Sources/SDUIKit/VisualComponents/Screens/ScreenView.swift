import SwiftUI

struct ScreenView<Content: View>: View {
    
    @Bindable var screen: Screen
    @ViewBuilder let content: Content
    
    @Environment(\.colorScheme) private var colorScheme
    
    var edges: Edge.Set {
        switch screen.ignoreSafeArea {
        case "top":
            return [.top]
        case "bottom":
            return [.bottom]
        case "all":
            return [.all]
        default:
            return []
        }
    }
    
    var body: some View {
        let darkMode = colorScheme == .dark
        Group {
            if let title = screen.title {
                content
                    .styledMargin(screen.style)
                    .background {
                        Color(sduiName: screen.style.backgroundColor, darkMode: darkMode)
                            .ignoresSafeArea(edges: edges)
                    }
                    .navigationTitle(Text(title))
            } else {
                content
                    .styledMargin(screen.style)
                    .background {
                        Color(sduiName: screen.style.backgroundColor, darkMode: darkMode)
                            .ignoresSafeArea(edges: edges)
                    }
            }
        }
        .onAppear() {
            screen.onAppear()
        }
        .onDisappear {
            screen.onDisappear()
        }
        .alert(
            screen.alertViewModel?.title ?? "",
            isPresented: $screen.showAlert,
            presenting: screen.alertViewModel
        ) { details in
            ForEach(details.buttons) { aButton in
                switch aButton.role {
                case .cancel:
                    SwiftUI.Button(role: .cancel) {
                        aButton.action()
                    } label: {
                        Text(aButton.title)
                    }
                case .destructive:
                    SwiftUI.Button(role: .destructive) {
                        aButton.action()
                    } label: {
                        Text(aButton.title)
                    }
                default:
                    SwiftUI.Button {
                        aButton.action()
                    } label: {
                        Text(aButton.title)
                    }
                }
            }
        } message: { details in
            if let message = details.message {
                Text(message)
            }
        }
        
    }
}
