//
//  
//  CarrerBlogViewController.swift
//  TiTech
//
//  Created by Apple on 18/7/24.
//
//

import UIKit

class CarrerBlogViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var presenter: CarrerBlogPresenterProtocol!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInit()
        self.presenter.onViewDidLoad()
    }
    
    // MARK: - Setup
    private func setupInit() {
        self.tableView.registerNib(ofType: CarrerBlog.self)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    // MARK: - Action
    
}

// MARK: - CarrerBlogViewProtocol
extension CarrerBlogViewController: CarrerBlogViewProtocol {
    func showHud() {
        self.showProgressHud()
    }
    
    func hideHud() {
        self.hideProgressHud()
    }
    
    func reloadContents() {
        DispatchQueue.main.async {
            self.presenter.isLoadingMore = false
            self.tableView.reloadDataSavingSelections()
        }
    }
}

//MARK: - UITableViewDataSource
extension CarrerBlogViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.blogDoc.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.presenter.tableView(tableView, cellForRowAt: indexPath)
    }
}

//MARK: - UITableViewDelegate
extension CarrerBlogViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let isReachingEnd = scrollView.contentOffset.y >= 0 && scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)
        
        if isReachingEnd && self.presenter.isLoadingMore == false {
            self.presenter.onLoadMore()
        }
    }
}
