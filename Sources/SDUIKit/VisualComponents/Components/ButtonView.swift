
import SwiftUI

struct ButtonView: View {
    
    var viewModel: Button
    
    init(button: Button) {
        self.viewModel = button
    }
    
    var body: some View {
        SwiftUI.Button {
            viewModel.run()
        } label: {
            if let image = viewModel.image, let title = viewModel.title {
                switch viewModel.position {
                case "top":
                    VStack(alignment: .center, spacing: 0) {
                        VisualComponentView(image)
                        Text(title)
                    }
                case "right":
                    HStack(spacing: 0) {
                        Text(title)
                        VisualComponentView(image)
                    }
                case "bottom":
                    VStack(alignment: .center, spacing: 0) {
                        Text(title)
                        VisualComponentView(image)
                    }
                default:
                    HStack(spacing: 0) {
                        VisualComponentView(image)
                        Text(title)
                    }
                }
            } else if let image = viewModel.image {
                VisualComponentView(image)
            } else if let title = viewModel.title {
                Text(title)
            }
        }
        .buttonStyle(SDUIButtonStyle(style: viewModel.style, pressedStyle: viewModel.pressedStyle))
        .disabled(!(viewModel.enabled ?? true))
        .opacity((viewModel.enabled ?? true) ? 1 : 0.2)
        .frame(width: CGFloat(viewModel.style.width), height: CGFloat(viewModel.style.height))
        .styledMargin(viewModel.style)
        
    }
    
    struct SDUIButtonStyle: ButtonStyle {
        
        @Environment(\.colorScheme) private var colorScheme
        @Environment(\.dynamicTypeSize) var dynamicTypeSize
        
        let style: Style
        let pressedStyle: Style
        
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .padding(.vertical, style.innerMargin ?? 0)
                .frame(maxWidth: .infinity)
                .styledText(configuration.isPressed ? pressedStyle : style)
                .styled(configuration.isPressed ? pressedStyle : style)
        }
        
    }
}


