//
//  LoginPresenter.swift
//  TiTech
//
//  Created by Apple on 9/7/24.
//
//  This file was generated by the 🐍 VIPER generator
//

import Foundation
import UIKit

final class LoginPresenter {
    
    // MARK: - Private properties -
    
    private unowned let view: LoginViewInterface
    private let wireframe: LoginWireframeInterface
    
    // MARK: - Lifecycle -
    
    init(view: LoginViewInterface, wireframe: LoginWireframeInterface) {
        self.view = view
        self.wireframe = wireframe
    }
}

// MARK: - Extensions -

extension LoginPresenter: LoginPresenterInterface {
    func sendLoginRequest(username: String, password: String) {
        self.wireframe.hanleLoginTask(userInput: username, passwordInput: password)
    }
    
    func showAlert(_ message: String, actionTitle: String, action: (() -> Void)?) {
        let alertVC = UIAlertController.init(title: "Thông báo", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction.init(title: actionTitle, style: .default, handler: { _ in
            action?()
        }))
        self.wireframe.hanleShowAlert(alertVC: alertVC)
    }
}
