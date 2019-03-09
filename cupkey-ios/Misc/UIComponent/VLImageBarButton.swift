import Foundation
import UIKit

class VLTextBarButtonIcon: UIBarButtonItem {
    var button: UIButton

    required init?(coder _: NSCoder) {
        fatalError("nope nope")
    }

    init(title: String) {
        self.button = UIButton()
        self.button.setTitleColor(.black, for: .normal)
        //self.button.titleLabel?.font = UIFont.vlBoldTextFontWith(size: 18)
        self.button.setTitle(title, for: .normal)
        super.init()
        customView = self.button
    }
}
