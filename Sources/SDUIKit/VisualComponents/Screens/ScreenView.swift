import SwiftUI
import UIKit

struct ScreenView<Content: View>: View {
    
    @Bindable var screen: Screen
    @ViewBuilder let content: Content
    
    init(screen: Screen, @ViewBuilder content: () -> Content) {
        self.screen = screen
        self.content = content()
    }
    
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
    
    @ViewBuilder
    fileprivate func barButton(_ button: Button) -> some View {
        if let image = button.image {
            SwiftUI.Button {
                button.run()
            } label: {
                VisualComponentView(image)
            }
            .if(button.title == nil) {
                $0.accessibilityLabel(button.title ?? "")
            }
        } else {
            SwiftUI.Button {
                button.run()
            } label: {
                Text(button.title ?? "")
                    .styledText(button.style)
            }
        }
    }
    
    var body: some View {
        let darkMode = colorScheme == .dark
        let navigationBarColor = screen.navigationBarStyle.backgroundColor
        ZStack {
            Color(sduiName: screen.style.backgroundColor, darkMode: darkMode)
                .ignoresSafeArea(edges: edges)
            if let title = screen.title {
                content
                    .styledMargin(screen.style)
                    .navigationTitle(Text(title))
                    .navigationBarTitleDisplayMode(screen.largeTitle ? .large : .inline)
            } else {
                content
                    .styledMargin(screen.style)
            }
        }
        .if(navigationBarColor != nil) {
            $0
                .toolbarBackground(Color(sduiName: navigationBarColor!, darkMode: colorScheme == .dark), for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
        }
        .scrollDismissesKeyboard(.immediately)
        .toolbar {
            if screen.leftButtons?.count ?? 0 > 0 {
                ToolbarItem(placement: .topBarLeading) { barButton(screen.leftButtons![0]) }
            }
            if screen.leftButtons?.count ?? 0 > 1 {
                ToolbarItem(placement: .topBarLeading) { barButton(screen.leftButtons![1]) }
            }
            if screen.leftButtons?.count ?? 0 > 2 {
                ToolbarItem(placement: .topBarLeading) { barButton(screen.leftButtons![2]) }
            }
            
            if let title = screen.title, screen.customBarTitle {
                ToolbarItem(placement: .principal) {
                    Text(title)
                        .styledText(screen.navigationBarStyle)
                }
            }
            
            if screen.rightButtons?.count ?? 0 > 0 {
                ToolbarItem(placement: .topBarTrailing) { barButton(screen.rightButtons![0]) }
            }
            if screen.rightButtons?.count ?? 0 > 1 {
                ToolbarItem(placement: .topBarTrailing) { barButton(screen.rightButtons![1]) }
            }
            if screen.rightButtons?.count ?? 0 > 2 {
                ToolbarItem(placement: .topBarTrailing) { barButton(screen.rightButtons![2]) }
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
