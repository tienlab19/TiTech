//
//  BaseNavigationController.swift
//  TiTech
//
//  Created by Apple on 11/7/24.
//

import UIKit

class BaseNavigationController: UINavigationController {
    var listViewControllerHiddenNavBar: [UIViewController.Type] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return topViewController?.supportedInterfaceOrientations ?? .portrait
    }

    override var shouldAutorotate: Bool {
        return true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if let topVC = viewControllers.last {
            //return the status property of each VC, look at step 2
            return topVC.preferredStatusBarStyle
        }

        return .default
    }

    private func setupUI() {
        self.navigationBar.isTranslucent = false
        self.navigationBar.layer.masksToBounds = false
        self.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.navigationBar.layer.shadowOpacity = 0.8
        self.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        self.navigationBar.layer.shadowRadius = 4
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        
        self.navigationBar.update(backroundColor: .white, titleColor: .black)

        self.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.darkText,
        ]

        self.changeTintColor(to: UIColor.darkText)
        self.changeBarTintColor(to: UIColor.white)
        self.changeBackgroundColor(to: UIColor.white)
        
        self.delegate = self
    }

    func setHiddenNavigationBarViewControllers(_ viewControllers: [UIViewController.Type]) {
        self.listViewControllerHiddenNavBar = viewControllers
    }

    func addHiddenNavigationBarViewController(_ viewController: UIViewController.Type) {
        self.listViewControllerHiddenNavBar.append(viewController)
    }
}

// MARK: UINavigationControllerDelegate
extension BaseNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let isHidden = self.listViewControllerHiddenNavBar.first(where: { viewController.isKind(of: $0.self) }) != nil
        navigationController.setNavigationBarHidden(isHidden, animated: true)
    }
}

extension UINavigationBar {
    func update(backroundColor: UIColor? = nil, titleColor: UIColor? = nil) {
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.shadowColor = .clear
            
            if let backroundColor = backroundColor {
              appearance.backgroundColor = backroundColor
            }
            
            if let titleColor = titleColor {
              appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor]
            }
            
            self.standardAppearance = appearance
            self.scrollEdgeAppearance = appearance
            
        }
    }
}

extension UINavigationController {
    func changeBackgroundColor(to color: UIColor?) {
        self.navigationBar.barTintColor = color
    }

    func changeTintColor(to color: UIColor?) {
        self.navigationBar.tintColor = color
    }

    func changeBarTintColor(to color: UIColor?) {
        self.navigationBar.barTintColor = color
    }

    func changeTitleColor(to color: UIColor) {
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: color]
    }

    func setSeperatorLineHidden(_ isHidden: Bool) {
        self.navigationBar.setValue(isHidden, forKey: "hidesShadow")
    }
}
