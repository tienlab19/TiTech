//
//  NewDetailViewController.swift
//  TiTech
//
//  Created by Apple on 11/7/24.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit
import WebKit

final class NewDetailViewController: BaseViewController {

    // MARK: - Public properties -
    @IBOutlet weak var webView: WKWebView!
    
    var presenter: NewDetailPresenterInterface!

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: self.presenter.addressURL)
        let requestObj = URLRequest(url: url! as URL)
        self.webView.load(requestObj)
    }
}

// MARK: - Extensions -

extension NewDetailViewController: NewDetailViewInterface {
    
}
