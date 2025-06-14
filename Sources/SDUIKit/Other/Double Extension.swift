import Foundation

extension Double {
    init?(_ int: Int?) {
        guard let int else { return nil }
        self.init(int)
    }
}
