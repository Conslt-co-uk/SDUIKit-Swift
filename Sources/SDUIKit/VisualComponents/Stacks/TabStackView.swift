import SwiftUI

struct TabStackView: View {
    
    var tabStack: TabStack
    @ObservedObject var state: State
    
    init(tabStack: TabStack) {
        self.tabStack = tabStack
        self.state = tabStack.state
    }
    
    var body: some View {
        StackView(stack: tabStack) {
            SwiftUI.TabView(selection: state.stringBinding(name: tabStack.variable)) {
                ForEach(tabStack.tabs) { aTab in
                    VisualComponentView(aTab)
                }
            }
        }
    }
}
