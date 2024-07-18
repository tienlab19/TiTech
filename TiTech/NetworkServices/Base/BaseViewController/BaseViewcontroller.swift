//
//  BaseViewcontroller.swift
//  tinvay
//
//  Created by Apple on 18/6/24.
//

import Foundation
import UIKit
import SnapKit


public class BaseViewController: UIViewController {
    private var progressHub: UIActivityIndicatorView?
    private var viewProgressHub: UIView?

    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    public override func viewDidLoad() {
        self.hideKeyboardOnTap()
        self.setUpCommonUI()
    }
    
    func hideKeyboardOnTap() {
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(dimissKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func setUpCommonUI() {
        // set the back button
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = .black
        navigationItem.backBarButtonItem = backButton
        
        self.setInitProgressHub()
    }
    
    @objc func dimissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - Loading
extension BaseViewController {
    private func setInitProgressHub() {
        self.viewProgressHub = UIView()
        self.viewProgressHub!.backgroundColor = .clear
        self.viewProgressHub?.alpha = 0
        self.viewProgressHub?.isHidden = true
        self.view.addSubview(self.viewProgressHub!)
        self.view.bringSubviewToFront(viewProgressHub!)
        self.viewProgressHub?.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        self.progressHub = UIActivityIndicatorView(style: .large)
        
        let hudBGView = UIView()
        hudBGView.backgroundColor = R.color.black_a53()
        self.viewProgressHub?.addSubview(hudBGView)
        hudBGView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(80)
        }
        hudBGView.cornerRadius = 8
        hudBGView.addSubview(self.progressHub!)
        self.progressHub?.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(40)
        }
    }

    func showProgressHud(offsetTop: CGFloat = 0, offsetBottom: CGFloat = 0, position: ProgressPosition = .full, backgroundColor: UIColor = .clear) {
        self.viewProgressHub?.backgroundColor = backgroundColor
        self.view.bringSubviewToFront(self.viewProgressHub!)
        let navigationBarHeight = navigationController?.navigationBar.height ?? 0
        let tabbarHeight = tabBarController?.tabBar.height ?? 0
        var statusBarHeight = UIApplication.shared.statusBarFrame.height
        if #available(iOS 13, *) {
            statusBarHeight = UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        }
        var topMargin: CGFloat = 0
        var bottomMargin: CGFloat = 0
        switch position {
        case .full:
            topMargin = offsetTop
            bottomMargin = offsetBottom
        case .underStatusBar:
            topMargin = statusBarHeight + offsetTop
            bottomMargin = offsetBottom
        case .aboveTabbar:
            topMargin = offsetTop
            bottomMargin = tabbarHeight + offsetBottom
        case .underNavigationBar:
            topMargin = statusBarHeight + navigationBarHeight + offsetTop
            bottomMargin = offsetBottom
        case .aboveTabbarAndUnderNavigationBar:
            topMargin = statusBarHeight + navigationBarHeight + offsetTop
            bottomMargin = offsetBottom + tabbarHeight
        case .aboveTabbarAndUnderStatusBar:
            topMargin = statusBarHeight + offsetTop
            bottomMargin = offsetBottom + tabbarHeight
        }

        self.viewProgressHub?.snp.remakeConstraints { (make) in
            make.top.equalToSuperview().offset(topMargin)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-bottomMargin)
        }
        self.progressHub?.startAnimating()
        self.viewProgressHub?.isHidden = false
            self.viewProgressHub?.alpha = 1
            self.view.layoutIfNeeded()
    }

    func hideProgressHud() {
        self.progressHub?.stopAnimating()
        UIView.animate(withDuration: AppConstants.Number.animationTime, animations: {
            self.viewProgressHub?.alpha = 0
        }, completion: { _ in
            self.viewProgressHub?.isHidden = true
        })
    }
}
