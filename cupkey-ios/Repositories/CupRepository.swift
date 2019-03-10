import Foundation
import Alamofire
import RxAlamofire
import RxSwift
import SwiftDate

class CupRepository {

    static let API_BASE_URL = "https://api-cupkey.benleb.de/v1"

    class func postCupClaim(certificateHash: String) -> Observable<SBBCup>  {
        let requestBodyObject = SBBCup()
        requestBodyObject.certificateHash = certificateHash
        requestBodyObject.claimingTimestamp = Int(NSDate().timeIntervalSince1970)
        let apiUrl = CupRepository.API_BASE_URL + "/cups"
        var request = URLRequest(url: URL(string: apiUrl)!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(requestBodyObject)
        print("POST \(apiUrl)")

        return RxAlamofire
            .requestData(request)
            .map { (arg0) -> SBBCup in
                let (_ /*httpUrlResponse*/, data) = arg0
                return try! JSONDecoder().decode(SBBCup.self, from: data)
            }
    }

    class func getAllCups() -> Observable<[SBBCup]> {

        let dummyCups = (1...200).map { _ in
            SBBCup(
                certificateHash: "asd",
                claimingTimestamp: Int(DateInRegion.randomDate(withinDaysBeforeToday: 5).timeIntervalSince1970)
            )
        }

        return Observable
            .just(dummyCups)
            .delay(5, scheduler: MainScheduler.instance)
    }

}


