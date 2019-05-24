//
//  DetailViewInteractor.swift
//  Training
//
//  Created by Jorge Angel Sanchez Martinez on 5/25/19.
//  Copyright © 2019 Jorge Angel Sanchez Martinez. All rights reserved.
//

import Foundation

class DetailViewInteractor: DetailViewInteractorProtocol{
    weak var presenter: PresenterInteractorProtocol?
    var searchResultModel: SearchResultModel?
    
    init(result: SearchResultModel?) {
        self.searchResultModel = result
    }
    
    func searchResult() -> SearchResultModel? {
        return searchResultModel
    }
}
