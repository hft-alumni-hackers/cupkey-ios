import Foundation
import UIKit
import RxSwift

protocol MainMenuVCDelegate {
    func bttClaimClicked()
    func bttWithdrawClicked()
}

class MainMenuVC: UIViewController {

    let TAG = "MainMenuVC"
    var delegate: MainMenuVCDelegate?
    var items = [SBBBaseCellItem]()
    var disposeBag = DisposeBag()

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

        self.rootView.cupCollectionView.reloadData()

        // Load Cups from Backend
        CupRepository
            .getAllCups()
            .subscribe({ newCupsEvent in
                if let newCups = newCupsEvent.element {
                    self.items = newCups.map {
                        CupCellItem(cup: $0)
                    }
                }
                self.rootView.cupCollectionView.reloadData()
            })
            .disposed(by: self.disposeBag)
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
