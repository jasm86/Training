//
//  DetailViewControllerSB.swift
//  Training
//
//  Created by Jorge Angel Sanchez Martinez on 5/25/19.
//  Copyright © 2019 Jorge Angel Sanchez Martinez. All rights reserved.
//

import Foundation

class DetailViewPresenter: DetailViewPresenterProtocol{
    weak var view: ViewableProtocol?
    var interector: InteractantProtocol?
    var router: RoutableProtocol?
    
    func loadView() {
        let searchResult = (interector as? DetailViewInteractor)?.searchResult()
        guard let result = searchResult,let view = view as? DetailViewProtocol else { return }
        view.showSearchResult(title: result.title ?? "", description: result.overview ?? "", image: result.posterPath ?? "")
        
    }
}
