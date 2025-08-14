import SwiftUI

struct ComponentsView: View {
    
    let components: [Component]
    let addSpacer: Bool
    
    init(components: [Component], addSpacer: Bool = false) {
        self.components = components
        self.addSpacer = addSpacer
    }
    
    var body: some View {
        ForEach(components) { aComponent in
            AnyView(erasing: VisualComponentView(aComponent))
        }
        if addSpacer {
            Spacer().frame(minHeight: 0)
        }
    }
}
