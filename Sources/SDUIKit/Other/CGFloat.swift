import Foundation

extension CGFloat {
    init?(_ double: Double?) {
        guard let double = double else {
            return nil
        }
        self.init(double)
    }
}
