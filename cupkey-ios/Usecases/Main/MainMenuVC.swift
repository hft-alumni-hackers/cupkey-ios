import Foundation
import UIKit

protocol MainMenuVCDelegate {
    func bttClaimClicked()
    func bttWithdrawClicked()
}

class MainMenuVC: UIViewController {

    let TAG = "MainMenuVC"
    var delegate: MainMenuVCDelegate?
    var items = [SBBBaseCellItem]()

    fileprivate unowned var rootView: MainMenuVCView { return view as! MainMenuVCView }

    override func loadView() {
        self.view = MainMenuVCView()
    }

    override func viewDidLoad() {
        print(TAG, "viewDidLoad()")
        self.setupSbbNavigationBar(
            title: "CupKey App",
            backButtonSelector: nil,
            rightButtonTitle: nil,
            rightButtonSelector: nil
        )

        self.rootView.bttClaim.addTarget(
            self,
            action: #selector(bttClaimClicked),
            for: .touchUpInside
        )

        self.rootView.bttWithdraw.addTarget(
            self,
            action: #selector(bttWithdrawClicked),
            for: .touchUpInside
        )

        self.rootView.cupCollectionView.delegate = self
        self.rootView.cupCollectionView.dataSource = self

        self.items.append(CupCellItem(cup: SBBCup()))
        self.items.append(CupCellItem(cup: SBBCup()))
        self.items.append(CupCellItem(cup: SBBCup()))
        self.items.append(CupCellItem(cup: SBBCup()))

        self.rootView.cupCollectionView.reloadData()
    }

    @objc func bttClaimClicked() {
        self.delegate?.bttClaimClicked()
    }

    @objc func bttWithdrawClicked() {
        self.delegate?.bttWithdrawClicked()
    }
}

extension MainMenuVC: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let item = self.items[indexPath.row]
        return CGSize(
            width: self.rootView.bounds.width,
            height: CGFloat(item.getHeight())
        )
    }
}

extension MainMenuVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = self.items[indexPath.row]
        return SBBCollectionViewUtilities.getDefaultCellFor(
            collectionView: collectionView,
            indexPath: indexPath,
            item: item
        )!
    }
}
