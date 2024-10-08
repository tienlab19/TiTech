//
//  LoginInterfaces.swift
//  TiTech
//
//  Created by Apple on 9/7/24.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

protocol LoginWireframeInterface: WireframeInterface {
    func hanleLoginTask(userInput: String, passwordInput: String)
    func hanleShowAlert(alertVC: UIAlertController)
}

protocol LoginViewInterface: ViewInterface { }

protocol LoginPresenterInterface: PresenterInterface {
    func sendLoginRequest(username: String, password: String)
    func showAlert(_ message: String, actionTitle: String, action: (() -> Void)?) 
}
