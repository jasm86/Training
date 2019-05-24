//
//  RouterSearchDetail.swift
//  Training
//
//  Created by Jorge Angel Sanchez Martinez on 5/25/19.
//  Copyright © 2019 Jorge Angel Sanchez Martinez. All rights reserved.
//

import UIKit

protocol RouterSearchDetailProtocol: RoutableProtocol{
    func goForwardDetail(origin: ViewableProtocol?, searchResult: SearchResultModel?)
}

class RouterSearchDetail: RoutableProtocol{
    static func createMainModule() -> UIViewController {
        let view = RouterSearchDetail.getSearchViewController()
        let presenter: PresentableProtocol & PresenterInteractorProtocol = SearchViewPresenter()
        let interactor: InteractantProtocol = SearchViewInteractor()
        let router: RoutableProtocol = RouterSearchDetail()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interector = interactor
        interactor.presenter = presenter
 
        
        let navController = UINavigationController()
        navController.viewControllers = [view]
        return navController
    }
    
    public func goForwardDetail(origin: ViewableProtocol?, searchResult: SearchResultModel?){
        let view = RouterSearchDetail.getDetailViewController()
        let presenter: PresentableProtocol & PresenterInteractorProtocol = DetailViewPresenter()
        let interactor: InteractantProtocol = DetailViewInteractor(result: searchResult)
        let router: RoutableProtocol = self
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interector = interactor
        interactor.presenter = presenter
        
        if let origin = origin as? UIViewController{
            origin.navigationController?.pushViewController(view, animated: true)
        }
    }
    
    private static func getSearchViewController() -> SearchViewController{
        let storyboard = UIStoryboard(name: UIStoryboard.search, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: SearchViewController.identifier) as! SearchViewController
        return controller
    }
    
    private static func getDetailViewController() -> DetailViewController{
        let storyboard = UIStoryboard(name: UIStoryboard.detail, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: DetailViewController.identifier) as! DetailViewController
        return controller
    }
}
