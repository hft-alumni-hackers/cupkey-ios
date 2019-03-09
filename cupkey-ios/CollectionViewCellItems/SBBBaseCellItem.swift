import Foundation
import UIKit

class SBBBaseCellItem: Hashable {

    var uuid = UUID().uuidString

    var hashValue: Int {
        return self.uuid.hashValue
    }

    func getHeight() -> Float {
        preconditionFailure("must be overriden")
    }

    static func == (lhs: SBBBaseCellItem, rhs: SBBBaseCellItem) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
