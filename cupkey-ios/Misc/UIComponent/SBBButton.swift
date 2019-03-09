import Foundation
import UIKit

class SBBButton: UIButton {
    var onClick: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    func commonInit() {
        self.layer.cornerRadius = 10
        self.backgroundColor = SBBColors.SBB_COLOR_RED
        //self.titleLabel?.font = UIFont.VL_TEXT_HEADLINE_FONT
        self.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
}
