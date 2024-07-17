//
//  BaseViewcontroller.swift
//  tinvay
//
//  Created by Apple on 18/6/24.
//

import Foundation
import UIKit

public class BaseViewController: UIViewController {
    private let loadingView = LoadingView()

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
    }
    
    @objc func dimissKeyboard() {
        view.endEditing(true)
    }
    
    func showLoadingView() {
        self.loadingView.show(on: self.view)
    }
    
    func hideLoadingView() {
        self.loadingView.hide()
    }
}
