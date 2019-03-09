import Foundation
import UIKit
import SnapKit

extension UIViewController {


    func setupSbbNavigationBar(
        title: String,
        backButtonSelector: Selector?,
        rightButtonTitle: String?,
        rightButtonSelector: Selector?
    ) {
        // Hide the NavigationBar from the NavigationController
        self.navigationController?.setNavigationBarHidden(true, animated: false)

        // Re-enable the "swipe to go back" gesture
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil

        let item = UINavigationItem()
        // Create an imageview to display image

        let navbarTitleView = UIView()
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.text = title

        let navbarTitleImage = UIImageView(image: UIImage(named: "sbb_logo"))
        navbarTitleView.addSubview(titleLabel)
        navbarTitleView.addSubview(navbarTitleImage)

        navbarTitleImage.snp.remakeConstraints { (make) in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(22)
            make.width.equalTo(126)
        }

        titleLabel.snp.remakeConstraints { (make) in
            make.left.equalTo(navbarTitleImage.snp.right)
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }

        item.titleView = navbarTitleView

        // Create navigation bar instance
        let customNavigationBar = UINavigationBar()
        customNavigationBar.tag = 1337
        view.addSubview(customNavigationBar)

        customNavigationBar.isTranslucent = false
        customNavigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        customNavigationBar.backgroundColor = .white

        customNavigationBar.translatesAutoresizingMaskIntoConstraints = false
        customNavigationBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        customNavigationBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        customNavigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true

        // Cover the status bar
        let statusBarOverlay = UIView()
        statusBarOverlay.backgroundColor = .white
        self.view.addSubview(statusBarOverlay)
        statusBarOverlay.snp.remakeConstraints { make in
            make.top.equalTo(self.view.snp.top)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.bottom.equalTo(customNavigationBar.snp.top)
        }

        // Setup Back Button
        if let backButtonSelector = backButtonSelector {
            let backButtonImage = UIImage(named: "chevron_left_aligned_left")?.withRenderingMode(.alwaysTemplate)
            let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
            backButton.setImage(backButtonImage!, for: .normal)
            backButton.addTarget(self, action: backButtonSelector, for: .touchUpInside)
            let backBarButton = UIBarButtonItem(customView: backButton)
            backButton.imageView?.tintColor = .black
            backButton.imageView?.clipsToBounds = true
            item.leftBarButtonItems = [backBarButton]
        }

        // Setup Right Butotn
        if let rightButtonTitle = rightButtonTitle {
            let rightBarButton = VLTextBarButtonIcon(title: rightButtonTitle)
            rightBarButton.button.backgroundColor = UIColor.clear
            rightBarButton.button.setTitleColor(SBBColors.SBB_COLOR_RED, for: .normal)

            item.rightBarButtonItem = rightBarButton
            if let rightButtonSelector = rightButtonSelector {
                rightBarButton.button.addTarget(self, action: rightButtonSelector, for: .touchUpInside)
            }
        }

        customNavigationBar.items = [item]
    }


    func navBarAndStatusBarOffset() -> CGFloat {
        let navigationBarHeight = navigationController?.navigationBar.frame.height ?? CGFloat(integerLiteral: 0)
        let navigationBarTopY = UIApplication.shared.statusBarFrame.height
        return navigationBarHeight + navigationBarTopY
    }
}

extension UIView {
    var safeArea: ConstraintBasicAttributesDSL {
        #if swift(>=3.2)
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.snp
        }
        return snp
        #else
        return snp
        #endif
    }
}
