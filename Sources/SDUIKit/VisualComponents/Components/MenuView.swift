
import SwiftUI

struct MenuView: View {
    
    var viewModel: Menu
    
    init(menu: Menu) {
        self.viewModel = menu
    }
    
    var body: some View {
        Group {
            if viewModel.hasActions {
                SwiftUI.Button {
                    viewModel.run()
                } label: {
                    HStack(spacing: 0) {
                        if let imageComponent = viewModel.imageComponent {
                            VisualComponentView(imageComponent)
                        }
                        VisualComponentView(viewModel.leftComponent)
                        Spacer()
                        if let rightComponent = viewModel.rightComponent {
                            VisualComponentView(rightComponent)
                        }
                        if let disclosureImageComponent = viewModel.disclosureImageComponent {
                            VisualComponentView(disclosureImageComponent)
                        } else {
                            Image(systemName: "chevron.forward")
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.vertical, viewModel.style.innerMargin ?? 0)
                    .styledMargin(viewModel.style)
                }
                .buttonStyle(MenuButtonStyle(style: viewModel.style, pressedStyle: viewModel.pressedStyle))
            } else {
                HStack(spacing: 0) {
                    if let imageComponent = viewModel.imageComponent {
                        VisualComponentView(imageComponent)
                    }
                    VisualComponentView(viewModel.leftComponent)
                    Spacer()
                    if let rightComponent = viewModel.rightComponent {
                        VisualComponentView(rightComponent)
                    }
                    if let disclosureImageComponent = viewModel.disclosureImageComponent {
                        VisualComponentView(disclosureImageComponent)
                    }
                }
                .padding(.vertical, viewModel.style.innerMargin ?? 0)
                .styledMargin(viewModel.style)
            }
        }
    }
    
    struct MenuButtonStyle: ButtonStyle {
        
        @Environment(\.colorScheme) private var colorScheme
        
        let style: Style
        let pressedStyle: Style
        
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .contentShape(Rectangle())
                .styled(configuration.isPressed ? pressedStyle : style)
        }
        
    }
}


