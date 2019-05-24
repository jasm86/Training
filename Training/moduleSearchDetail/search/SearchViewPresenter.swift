//
//  SearchViewPresenter.swift
//  Training
//
//  Created by Jorge Angel Sanchez Martinez on 5/25/19.
//  Copyright © 2019 Jorge Angel Sanchez Martinez. All rights reserved.
//

import Foundation

class SearchViewPresenter: SearchViewPresenterProtocol{
    weak var view: ViewableProtocol?
    var interector: InteractantProtocol?
    var router: RoutableProtocol?
    lazy var homeSections: [Sections] = {
        return [.mostPopular, .mostRated, .upcoming]
    }()
    
    func loadView() {
        view?.displayProgress()
        if let searchInteractor = interector as? SearchViewInteractorProtocol{
            searchInteractor.fetchMainScreenSections()
        }else{
            view?.dissmisProgress()
            view?.showError(error: "error_lodaing_home".localized())
        }
    }
    
    public func didResponseMostPopular(error: Error?, data: [SearchResultModel]){
        if let viewSearch = view as? SearchViewProtocol, error == nil{
            viewSearch.showMostPopular(data: data)
        }
    }
    
    public func didResponseMostRated(error: Error?, data: [SearchResultModel]){
        if let viewSearch = view as? SearchViewProtocol, error == nil{
            viewSearch.showMostRated(data: data)
        }
    }
    
    public func didResponseUpcoming(error: Error?, data: [SearchResultModel]){
        if let viewSearch = view as? SearchViewProtocol, error == nil{
            viewSearch.showMostUpcoming(data: data)
        }
    }
    
    func didFinishFetchMainScreenSections() {
        view?.updateUI()
        view?.dissmisProgress()
    }
    
    func homeCountSections() -> Int {
        return homeSections.count
    }
    
    func homeSection(for index: Int) -> Sections{
        return homeSections[index]
    }
    
    func selectedMosPopular(index: Int, section: Sections) {
        if let router = router as? RouterSearchDetailProtocol,
            let searchInteractor = interector as? SearchViewInteractorProtocol{
            let searchResult = searchInteractor.searchResult(at: index, section: section)
            router.goForwardDetail(origin: view, searchResult: searchResult)
        }
    }
    
    func selectedMosRated(index: Int, section: Sections) {
        if let router = router as? RouterSearchDetailProtocol,
            let searchInteractor = interector as? SearchViewInteractorProtocol{
            let searchResult = searchInteractor.searchResult(at: index, section: section)
            router.goForwardDetail(origin: view, searchResult: searchResult)
        }
    }
    
    func selectedUpcoming(index: Int, section: Sections) {
        if let router = router as? RouterSearchDetailProtocol,
            let searchInteractor = interector as? SearchViewInteractorProtocol{
            let searchResult = searchInteractor.searchResult(at: index, section: section)
            router.goForwardDetail(origin: view, searchResult: searchResult)
        }
    }
}
