import Foundation

extension Int {
    init?(_ double: Double?) {
        guard let double = double else {
            return nil
        }
        self.init(double)
    }
}
