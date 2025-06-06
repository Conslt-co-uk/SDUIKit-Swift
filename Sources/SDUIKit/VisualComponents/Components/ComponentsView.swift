import SwiftUI

struct ComponentsView: View {
    
    let components: [Component]
    
    init(components: [Component]) {
        self.components = components
    }
    
    var body: some View {
        ForEach(components) { aComponent in
            AnyView(erasing: VisualComponentView(aComponent))
        }
    }
}
