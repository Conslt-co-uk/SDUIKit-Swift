import SwiftUI

struct ComboView: View {
    
    var combo: Combo
    
    init(combo: Combo) {
        self.combo = combo
    }
    
    var body: some View {
        ContainerView(container: combo) {
            HStack(spacing: combo.style.innerMargin ?? 8) {
                ComponentsView(components: combo.components)
            }
        }
    }
}
