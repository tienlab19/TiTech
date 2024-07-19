//
//  
//  SearchViewController.swift
//  TiTech
//
//  Created by Tien Tran on 19/7/24.
//
//

import UIKit

class SearchViewController: BaseViewController {

    var presenter: SearchPresenterProtocol!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInit()
        self.presenter.onViewDidLoad()
    }
    
    // MARK: - Setup
    private func setupInit() {

    }
    
    // MARK: - Action
    
}

// MARK: - SearchViewProtocol
extension SearchViewController: SearchViewProtocol {
    func showHud() {
        self.showProgressHud()
    }
    
    func hideHud() {
        self.self.hideProgressHud()
    }
}
