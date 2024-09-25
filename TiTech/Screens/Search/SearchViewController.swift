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
    
    @IBOutlet weak var hashTagCollectionView: UICollectionView!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInit()
        self.presenter.onViewDidLoad()
    }
    
    // MARK: - Setup
    private func setupInit() {
        self.hashTagCollectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        self.hashTagCollectionView.registerNib(ofType: FilterCell.self)
        self.hashTagCollectionView.delegate = self
        self.hashTagCollectionView.dataSource = self
    }
    
    // MARK: - Action
}

//MARK: - UICollectionViewDataSource
extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter.collectionView(collectionView, numberOfItemsInSection: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return self.presenter.collectionView(collectionView, cellForItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter.collectionView(collectionView, didSelectItemAt: indexPath)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.presenter.collectionView(collectionView, layout: collectionViewLayout, sizeForItemAt: indexPath)
    }
}

// MARK: - SearchViewProtocol
extension SearchViewController: SearchViewProtocol {
    func showHud() {
        self.showProgressHud()
    }
    
    func hideHud() {
        self.self.hideProgressHud()
    }
    
    func reloadHasgTagList() {
        DispatchQueue.main.async {
            self.hashTagCollectionView.reloadData()
        }
    }
}
