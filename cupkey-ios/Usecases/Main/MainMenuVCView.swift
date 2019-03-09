import UIKit
import Foundation

class MainMenuVCView: UIView {

    lazy var lblWelcome: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: "Welcome, Max Mustermann.")
        let boldFont = UIFont.boldSystemFont(ofSize: 18)
        attributedString.addAttribute(.font, value: boldFont, range: NSRange(location: 9, length: 14))
        label.attributedText = attributedString
        return label
    }()

    lazy var environmentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_green_leaf")
        return imageView
    }()

    lazy var lblEnvironmentHint: UILabel = {
        let label = UILabel()
        label.text = "Thanks for saving the Environment by using CupKey!"
        label.numberOfLines = 0
        return label
    }()

    lazy var bttClaim: SBBButton = {
        let button = SBBButton()
        button.backgroundColor = .white
        button.layer.borderColor = SBBColors.SBB_COLOR_RED.cgColor
        button.layer.borderWidth = 1
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.setTitle("Claim Cup!", for: .normal)
        return button
    }()

    lazy var cupCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.alwaysBounceVertical = true
        SBBCollectionViewUtilities.registerDefaultCells(collectionView: collectionView)
        return collectionView
    }()



    lazy var totalCreditView: UIView = {
        let view = UIView()
        view.backgroundColor = SBBColors.SBB_COLOR_RED
        return view
    }()

    lazy var lblTotalCredit: UILabel = {
        let label = UILabel()
        label.text = "7,60CHF Total"
        label.textColor = .white
        return label
    }()

    lazy var bttWithdraw: SBBButton = {
        let button = SBBButton()
        button.setTitle("Withdraw", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(SBBColors.SBB_COLOR_RED, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = UIColor.white

        self.addSubview(self.lblWelcome)
        self.addSubview(self.environmentImageView)
        self.addSubview(self.lblEnvironmentHint)
        self.addSubview(self.bttClaim)
        self.addSubview(self.cupCollectionView)
        self.addSubview(self.totalCreditView)
        self.addSubview(self.lblTotalCredit)
        self.addSubview(self.bttWithdraw)

        self.lblWelcome.snp.remakeConstraints { (make) in
            make.top.equalTo(self.safeArea.top).offset(56)
            make.left.equalTo(self.lblEnvironmentHint.snp.left)
            make.right.equalTo(self.snp.right)
        }

        self.lblEnvironmentHint.snp.remakeConstraints { (make) in
            make.left.equalTo(self.environmentImageView.snp.right).offset(8)
            make.top.equalTo(self.lblWelcome.snp.bottom).offset(16)
            make.right.equalToSuperview().offset(-16)
        }

        self.environmentImageView.snp.remakeConstraints { (make) in
            make.centerY.equalTo(self.lblEnvironmentHint.snp.centerY)
            make.left.equalToSuperview().offset(16)
            make.width.height.equalTo(60)
        }

        self.bttClaim.snp.remakeConstraints { (make) in
            make.top.equalTo(self.lblEnvironmentHint.snp.bottom).offset(32)
            make.left.equalTo(self.snp.left).offset(16)
            make.right.equalTo(self.snp.right).offset(-16)
            //make.height.equalTo(20)
        }

        self.cupCollectionView.snp.remakeConstraints { (make) in
            make.top.equalTo(self.bttClaim.snp.bottom).offset(16)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.bottom.equalTo(self.snp.bottom)
        }

        self.totalCreditView.snp.remakeConstraints { (make) in
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.top.equalTo(self.safeArea.bottom).offset(-56)
            make.bottom.equalTo(self.snp.bottom)
        }

        self.lblTotalCredit.snp.remakeConstraints { (make) in
            make.left.equalTo(self.totalCreditView.snp.left).offset(16)
            make.top.equalTo(self.totalCreditView.snp.top).offset(16)
        }

        self.bttWithdraw.snp.remakeConstraints { (make) in
            make.right.equalTo(self.totalCreditView.snp.right).offset(-8)
            make.centerY.equalTo(self.lblTotalCredit.snp.centerY)
        }
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:)") }

}
