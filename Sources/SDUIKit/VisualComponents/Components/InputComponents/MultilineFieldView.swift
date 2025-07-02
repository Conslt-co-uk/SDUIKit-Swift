
import SwiftUI

struct MultilineFieldView: View {
    
    var textField: MultilineField
    @ObservedObject var state: SDUIKit.State
    
    init(textField: MultilineField) {
        self.textField = textField
        self.state = textField.state
    }

    var body: some View {
        TextEditor(text: textField.state.stringBinding(name: textField.variable!) ?? "")
            .frame(height: CGFloat(textField.rows * 21 + 19))
            .styledInput(inputComponent: textField)
        }
}
