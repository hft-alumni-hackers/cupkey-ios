import Foundation
import UIKit

class AppCoordinator {

    let rootNavigationController: UINavigationController
    var mainMenuVC: MainMenuVC?

    init(rootNavigationController: UINavigationController) {
        self.rootNavigationController = rootNavigationController
    }

    func start() {
        self.mainMenuVC = MainMenuVC()
        self.mainMenuVC!.delegate = self
        self.rootNavigationController.pushViewController(
            self.mainMenuVC!,
            animated: false
        )
    }
}

extension AppCoordinator: MainMenuVCDelegate {

    func bttWithdrawClicked() {
        let withdrawVC = WithdrawCreditVC()
        self.rootNavigationController.pushViewController(
            withdrawVC,
            animated: true
        )
    }

    func bttClaimClicked() {
        let qrCodeScannerVC = QRCodeScannerVC()
        qrCodeScannerVC.delegate = self
        self.rootNavigationController.pushViewController(qrCodeScannerVC, animated: true)
    }
}

extension AppCoordinator: QRCodeScannerVCDelegate {

    func bttCancelClicked() {
        self.rootNavigationController.popToViewController(
            self.mainMenuVC!,
            animated: true
        )
    }

    func didScanQrCode(scannedContent: String) {
        let verificationVC = CupKeyVerificationVC(
            scannedCupKeyCertificateHash: scannedContent
        )
        verificationVC.delegate = self
        self.rootNavigationController.pushViewController(verificationVC, animated: true)
        print(scannedContent)
    }
}

extension AppCoordinator: CupKeyVerificationVCDelegate {
    func bttDoneClicked() {
        self.rootNavigationController.popToViewController(
            self.mainMenuVC!,
            animated: true
        )
    }
}
