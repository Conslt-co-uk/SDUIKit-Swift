import SwiftUI

@MainActor
public protocol VisualProtocol {
    func view() -> any View
}
