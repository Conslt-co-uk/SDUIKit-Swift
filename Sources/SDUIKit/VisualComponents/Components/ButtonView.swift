
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
            Text(viewModel.title ?? "")
                
        }
        .buttonStyle(SDUIButtonStyle(style: viewModel.style, pressedStyle: viewModel.pressedStyle))
        .disabled(!(viewModel.enabled ?? true))
        .opacity((viewModel.enabled ?? true) ? 1 : 0.2)
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


