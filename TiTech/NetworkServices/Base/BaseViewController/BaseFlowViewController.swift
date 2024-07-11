//
//  BaseFlowViewController.swift
//  tinvay
//
//  Created by Apple on 8/7/24.
//

import Foundation
import UIKit

class BaseFlowViewController: UIViewController {
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    public override func viewDidLoad() {
        self.hideKeyboardOnTap()
        self.setupCommonUI()
    }
    
    func hideKeyboardOnTap() {
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(dimissKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func setupCommonUI() {
        self.view.backgroundColor = UIColor(hexString: "DE3507")
    }
    
    @objc func dimissKeyboard() {
        view.endEditing(true)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
}
