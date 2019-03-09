import Foundation
import UIKit

class CupCellItem: SBBBaseCellItem {

    let cup: SBBCup
    init(cup: SBBCup) {
        self.cup = cup
    }

    override func getHeight() -> Float {
        return 50
    }
}

class CupCell: UICollectionViewCell {

    static let cellId = "CupCell"

    lazy var cupImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_coffee")
        return imageView
    }()

    lazy var lblDate: UILabel = {
        let label = UILabel()
        label.text = "2 Hours Ago"
        return label
    }()

    lazy var lblRefundAmount: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.text = "2 CHF"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.addSubview(self.lblDate)
        self.addSubview(self.lblRefundAmount)
        self.addSubview(self.cupImage)

        self.lblDate.snp.remakeConstraints { (make) in
            make.top.equalTo(self.cupImage.snp.top)
            make.left.equalTo(self.cupImage.snp.right).offset(8)
        }

        self.lblRefundAmount.snp.remakeConstraints { (make) in
            make.bottom.equalTo(self.cupImage.snp.bottom)
            make.left.equalTo(self.cupImage.snp.right).offset(8)
        }

        self.cupImage.snp.remakeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(16)
            make.centerY.equalTo(self.snp.centerY)
            make.width.height.equalTo(40)
        }
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:)") }

    func setupWithItem(item: CupCellItem) {

    }

}
