import Foundation

class SBBCup: Codable {
    var certificateHash: String?
    var claimingTimestamp: Int?

    init() {
        
    }

    init(certificateHash: String, claimingTimestamp: Int) {
        self.certificateHash = certificateHash
        self.claimingTimestamp = claimingTimestamp
    }

}
