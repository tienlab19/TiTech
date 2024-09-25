//
//  
//  SearchPresenter.swift
//  TiTech
//
//  Created by Tien Tran on 19/7/24.
//
//

import UIKit

class SearchPresenter {

    weak var view: SearchViewProtocol?
    private var interactor: SearchInteractorInputProtocol
    private var router: SearchRouterProtocol
    
    var listTags: [TagDoc]? = []
    var listPopularArtical: [Docs]? = []

    init(interactor: SearchInteractorInputProtocol,
         router: SearchRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }

}

// MARK: - SearchPresenterProtocol
extension SearchPresenter: SearchPresenterProtocol {
    func onViewDidLoad() {
        self.view?.showHud()
        self.interactor.requestGetTagsAll()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listTags?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeuCell(ofType: FilterCell.self, for: indexPath)
        cell.title = self.listTags?[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight: CGFloat = 32
        let padding: CGFloat = 10
        let item = self.listTags?[indexPath.item].name ?? ""
        return CGSize(width: item.width(withConstrainedHeight: padding * 2, font: UIFont.systemFont(ofSize: 14)), height: cellHeight)
    }
}

// MARK: - SearchInteractorOutput 
extension SearchPresenter: SearchInteractorOutputProtocol {
    func didGetTags(with result: Result<TagsModel?, APIError>) {
        switch result {
        case .success(let model):
            guard let responseData = model?.data?.docs else { return }
            self.listTags = responseData
            self.view?.reloadHasgTagList()
            self.interactor.requestGetPopularArtical()
            
        case .failure(let failure):
            print(failure.message)
            self.view?.hideHud()
        }
    }
    
    func didGetPopularArtical(with result: Result<CarrerBlogModel?, APIError>) {
        switch result {
        case .success(let model):
            guard let responseData = model?.data?.docs else { return }
            self.listPopularArtical = responseData
            
        case .failure(let failure):
            print(failure.message)
        }
        
        self.view?.hideHud()
    }
}
