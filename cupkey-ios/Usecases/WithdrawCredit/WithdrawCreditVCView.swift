import Foundation
import UIKit

class WithdrawCreditVCView: UIView {

    lazy var billeteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "img_bilette")!
        imageView.clipsToBounds = true
        return imageView
    }()

    lazy var lblBillet: UILabel = {
        let label = UILabel()
        label.text = "Use Credit to Buy SBB Billet with 10% Discount."
        label.numberOfLines = 0
        return label
    }()

    lazy var bttBillet: SBBButton = {
        let button = SBBButton()
        button.setTitle("Buy Ticket with your Credit!", for: .normal)
        return button
    }()

    lazy var bistroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "img_croissant")!
        imageView.clipsToBounds = true
        return imageView
    }()

    lazy var lblBistro: UILabel = {
        let label = UILabel()
        label.text = "Buy Food and Drinks in the Board Bistro and in all Stores which are participating in the KeyCup Project."
        label.numberOfLines = 0
        return label
    }()

    lazy var bttBistro: SBBButton = {
        let button = SBBButton()
        button.setTitle("Buy Stuff at the Board Bistro", for: .normal)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .white

        self.addSubview(self.billeteImageView)
        self.addSubview(self.lblBillet)
        self.addSubview(bttBillet)

        self.addSubview(self.bistroImageView)
        self.addSubview(self.lblBistro)
        self.addSubview(bttBistro)

        self.billeteImageView.snp.remakeConstraints { (make) in
            make.top.equalTo(self.safeArea.top).offset(56)
            make.left.equalTo(self.snp.left).offset(16)
            make.right.equalTo(self.snp.right).offset(-16)
            make.height.equalTo(150)
        }
        self.lblBillet.snp.remakeConstraints { (make) in
            make.top.equalTo(self.billeteImageView.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        self.bttBillet.snp.remakeConstraints { (make) in
            make.top.equalTo(self.lblBillet.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }

        self.bistroImageView.snp.remakeConstraints { (make) in
            make.top.equalTo(self.bttBillet.snp.bottom).offset(40)
            make.left.equalTo(self.snp.left).offset(16)
            make.right.equalTo(self.snp.right).offset(-16)
            make.height.equalTo(150)
        }
        self.lblBistro.snp.remakeConstraints { (make) in
            make.top.equalTo(self.bistroImageView.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        self.bttBistro.snp.remakeConstraints { (make) in
            make.top.equalTo(self.lblBistro.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:)") }
}
