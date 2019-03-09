import Foundation
import UIKit

class WithdrawCreditVC: UIViewController {

    override func loadView() {
        self.view = WithdrawCreditVCView()
    }

    override func viewDidLoad() {
        self.setupSbbNavigationBar(
            title: "Withdraw Credit",
            backButtonSelector: #selector(bttBackClicked),
            rightButtonTitle: nil,
            rightButtonSelector: nil
        )
    }

    @objc func bttBackClicked() {
        self.navigationController?.popViewController(animated: true)
    }
}
