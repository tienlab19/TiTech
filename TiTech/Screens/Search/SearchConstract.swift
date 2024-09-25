//
//  
//  SearchConstract.swift
//  TiTech
//
//  Created by Tien Tran on 19/7/24.
//
//

import UIKit

// MARK: - View
protocol SearchViewProtocol: AnyObject {
    func showHud()
    func hideHud()
    
    func reloadHasgTagList()
}

// MARK: - Presenter
protocol SearchPresenterProtocol {
    var listTags: [TagDoc]? { get set }
    var listPopularArtical: [Docs]? { get set }
    
    func onViewDidLoad()
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
}

// MARK: - Interactor Input
protocol SearchInteractorInputProtocol {
    func requestGetTagsAll()
    func requestGetPopularArtical()
}

// MARK: - Interactor Output
protocol SearchInteractorOutputProtocol: AnyObject {
    func didGetTags(with result: Result<TagsModel?, APIError>)
    func didGetPopularArtical(with result: Result<CarrerBlogModel?, APIError>)
}

// MARK: - Router
protocol SearchRouterProtocol {

}
