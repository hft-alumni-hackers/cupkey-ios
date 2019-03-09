import Foundation
import UIKit

class CupKeyVerificationVCView: UIView {

    lazy var lblSuccessIndicator: UILabel = {
        let label = UILabel()
        label.text = "✅"
        label.font = UIFont.systemFont(ofSize: 45)
        return label
    }()

    lazy var lblSuccessDescription: UILabel = {
        let label = UILabel()
        label.text = "<>"
        label.textAlignment = .center
        return label
    }()

    lazy var bttDone: SBBButton = {
        let button = SBBButton()
        button.setTitle("Done", for: .normal)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .white
        self.addSubview(lblSuccessIndicator)
        self.addSubview(lblSuccessDescription)
        self.addSubview(bttDone)

        self.lblSuccessIndicator.snp.remakeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY).multipliedBy(0.33)
        }

        self.lblSuccessDescription.snp.remakeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self.lblSuccessIndicator.snp.bottom).offset(16)
        }

        self.bttDone.snp.remakeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalTo(self.safeArea.bottom).offset(-16)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
