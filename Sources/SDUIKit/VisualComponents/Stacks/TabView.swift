
import SwiftUI

struct TabView: View {
    
    @Bindable var tab: Tab
    
    var body: some View {
        NavigationStack(path: $tab.path) {
            VisualComponentView(tab.screens.first!)
                .navigationDestination(for: Int.self) { index in
                    if tab.screens.count > index {
                        VisualComponentView(tab.screens[index])
                    }
                }
        }
        .tabItem {
            Label(tab.title, systemImage: "list.dash")
        }
        #if !os(tvOS)
        .badge(tab.badge ?? 0)
        #endif
        .tag(tab.name)
    }
}
