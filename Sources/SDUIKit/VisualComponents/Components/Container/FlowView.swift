import SwiftUI

struct FlowView: View {
    
    var flow: Flow
    
    init(flow: Flow) {
        self.flow = flow
    }
    
    var body: some View {
        ContainerView(container: flow) {
            HStack {
                FlowLayout(verticalSpacing: flow.style.verticalSpacing ?? 0, horizontalSpacing: flow.style.horizontalSpacing ?? 0) {
                    ComponentsView(components: flow.components)
                }
                Spacer()
            }
        }
    }
}

struct FlowLayout: Layout {
    
    let verticalSpacing: CGFloat
    let horizontalSpacing: CGFloat
    
    init(verticalSpacing: CGFloat, horizontalSpacing: CGFloat) {
        self.verticalSpacing = verticalSpacing
        self.horizontalSpacing = horizontalSpacing
    }
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        var size = CGSize.zero
        var rowWidth: CGFloat = 0
        var rowHeight: CGFloat = 0
        let maxWidth = proposal.width ?? .infinity
        
        for view in subviews {
            let viewSize = view.sizeThatFits(.unspecified)
            if rowWidth + viewSize.width + horizontalSpacing > maxWidth {
                size.height += rowHeight + verticalSpacing
                size.width = max(size.width, rowWidth)
                rowWidth = viewSize.width
                rowHeight = viewSize.height
            } else {
                rowWidth += viewSize.width + horizontalSpacing
                rowHeight = max(rowHeight, viewSize.height)
            }
        }
        size.height += rowHeight
        size.width = max(size.width, rowWidth)
        return size
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var x = bounds.minX
        var y = bounds.minY
        var rowHeight: CGFloat = 0

        for view in subviews {
            let size = view.sizeThatFits(.unspecified)
            if x + size.width + horizontalSpacing > bounds.maxX {
                x = bounds.minX
                y += rowHeight + verticalSpacing
                rowHeight = 0
            }
            view.place(at: CGPoint(x: x, y: y), proposal: ProposedViewSize(width: size.width, height: size.height))
            x += size.width + horizontalSpacing
            rowHeight = max(rowHeight, size.height)
        }
    }
}
