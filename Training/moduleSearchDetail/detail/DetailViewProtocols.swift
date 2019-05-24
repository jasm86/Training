//
//  DetailProtocol.swift
//  Training
//
//  Created by Jorge Angel Sanchez Martinez on 5/26/19.
//  Copyright © 2019 Jorge Angel Sanchez Martinez. All rights reserved.
//

import Foundation

protocol DetailViewPresenterProtocol:  PresentableProtocol, PresenterInteractorProtocol{
    func loadView()
}

protocol DetailViewInteractorProtocol: InteractantProtocol {
    var searchResultModel: SearchResultModel? { get set }
    func searchResult() -> SearchResultModel?
}

protocol DetailViewProtocol: ViewableProtocol {
    func showSearchResult(title: String, description:String, image: String)
}

