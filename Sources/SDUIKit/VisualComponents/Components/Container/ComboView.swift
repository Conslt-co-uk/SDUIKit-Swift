import SwiftUI

struct ComboView: View {
    
    var combo: Combo
    
    init(combo: Combo) {
        self.combo = combo
    }
    
    var body: some View {
        ContainerView(container: combo) {
            HStack(spacing: combo.style.horizontalSpacing ?? 0) {
                ComponentsView(components: combo.components)
            }
        }
    }
}
