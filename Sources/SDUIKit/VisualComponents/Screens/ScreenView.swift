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
        ZStack {
            Color(sduiName: screen.style.backgroundColor, darkMode: darkMode)
                .ignoresSafeArea(edges: edges)
            if let title = screen.title {
                content
                    .styledMargin(screen.style)
//                    .background {
//                        Color(sduiName: screen.style.backgroundColor, darkMode: darkMode)
//                            .ignoresSafeArea(edges: edges)
//                    }
                    .navigationTitle(Text(title))
                    .navigationBarTitleDisplayMode(screen.largeTitle ? .large : .inline)
            } else {
                content
                    .styledMargin(screen.style)
//                    .background {
//                        Color(sduiName: screen.style.backgroundColor, darkMode: darkMode)
//                            .ignoresSafeArea(edges: edges)
//                    }
            }
        }
        .toolbar {
            if screen.leftButtons?.count ?? 0 > 0 {
                let button = screen.leftButtons![0]
                ToolbarItem(placement: .navigationBarLeading) {
                    SwiftUI.Button {
                        button.run()
                    } label: {
                        if let image = button.image {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                        } else {
                            Text(button.title ??  "")
                        }
                    }
                    .frame(width: button.style.width ?? 38, height: button.style.height ?? 38)
                }
            }
            if screen.leftButtons?.count ?? 0 > 1 {
                ToolbarItem(placement: .navigationBarLeading) {
                    VisualComponentView(screen.leftButtons![1])
                }
            }
            if screen.leftButtons?.count ?? 0 > 2 {
                ToolbarItem(placement: .navigationBarLeading) {
                    VisualComponentView(screen.leftButtons![2])
                }
            }
            if screen.rightButtons?.count ?? 0 > 0 {
                let button = screen.rightButtons![0]
                ToolbarItem(placement: .navigationBarTrailing) {
                    SwiftUI.Button {
                        button.run()
                    } label: {
                        if let image = button.image {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                        } else {
                            Text(button.title ??  "")
                        }
                    }
                    .frame(width: button.style.width ?? 38, height: button.style.height ?? 38)
                }
            }
            if screen.rightButtons?.count ?? 0 > 1 {
                ToolbarItem(placement: .navigationBarTrailing) {
                    VisualComponentView(screen.rightButtons![1])
                }
            }
            if screen.rightButtons?.count ?? 0 > 2 {
                ToolbarItem(placement: .navigationBarTrailing) {
                    VisualComponentView(screen.rightButtons![2])
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
