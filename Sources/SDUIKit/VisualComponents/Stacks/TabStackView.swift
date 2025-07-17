import SwiftUI

struct TabStackView: View {
    
    var tabStack: TabStack
    @ObservedObject var state: State
    @Environment(\.colorScheme) private var colorScheme
    
    init(tabStack: TabStack) {
        self.tabStack = tabStack
        self.state = tabStack.state
    }
    
    var body: some View {
        let binding = state.stringBinding(name: tabStack.variable)
        StackView(stack: tabStack) {
            SwiftUI.TabView(selection: binding) {
                ForEach(tabStack.tabs) { aTab in
                    VisualComponentView(aTab)
                        .if( aTab.stylesheet.color(name: "accent") != nil ) {
                            $0.accentColor(Color(sduiName: aTab.stylesheet.color(name: "accent"), darkMode: colorScheme == .dark))
                        }
                }
                .if(tabStack.tabBarStyle.backgroundColor != nil) {
                    $0
                        .toolbarBackground(.visible, for: .tabBar)
                        .toolbarBackground(
                            Color(sduiName: tabStack.tabBarStyle.backgroundColor, darkMode: colorScheme == .dark),
                            for: .tabBar)
                }
                
            }
            .if(tabStack.tabBarStyle.color != nil) {
                $0.accentColor(Color(sduiName: tabStack.tabBarStyle.color, darkMode: colorScheme == .dark))
            }

        }
        .onChange(of: binding.wrappedValue) { oldValue, newValue in
            tabStack.tabHasChanged()
        }
    }
}
