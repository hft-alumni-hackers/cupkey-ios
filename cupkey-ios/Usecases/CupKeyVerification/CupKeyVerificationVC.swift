import Foundation
import UIKit

protocol CupKeyVerificationVCDelegate {
    func bttDoneClicked()
}

class CupKeyVerificationVC: UIViewController {

    fileprivate unowned var rootView: CupKeyVerificationVCView { return view as! CupKeyVerificationVCView }
    var delegate: CupKeyVerificationVCDelegate?

    let scannedCupKeyCertificateHash: String

    init(scannedCupKeyCertificateHash: String) {
        self.scannedCupKeyCertificateHash = scannedCupKeyCertificateHash
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = CupKeyVerificationVCView()
    }

    override func viewDidLoad() {
        self.rootView.bttDone.addTarget(
            self,
            action: #selector(self.bttDoneClicked),
            for: .touchUpInside
        )
        self.rootView.lblSuccessDescription.text = "You successfully claimed \(self.scannedCupKeyCertificateHash)"
    }

    @objc func bttDoneClicked() {
        self.delegate?.bttDoneClicked()
    }
}
