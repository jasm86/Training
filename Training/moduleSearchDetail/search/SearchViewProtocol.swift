//
//  SearchViewProtocol.swift
//  Training
//
//  Created by Jorge Angel Sanchez Martinez on 5/26/19.
//  Copyright © 2019 Jorge Angel Sanchez Martinez. All rights reserved.
//

import Foundation

protocol SearchViewProtocol: ViewableProtocol {
    func showMostPopular(data: [SearchResultModel])
    func showMostRated(data: [SearchResultModel])
    func showMostUpcoming(data: [SearchResultModel])
}

protocol SearchViewInteractorProtocol: InteractantProtocol {
    func fetchMainScreenSections()
    func fetchMostPopular()
    func fetchMostRated()
    func fetchUpcoming()
    func searchResult(at index: Int, section: Sections) -> SearchResultModel?
}

protocol SearchViewPresenterProtocol:  PresentableProtocol, PresenterInteractorProtocol{
    func loadView()
    func didFinishFetchMainScreenSections()
    func didResponseMostPopular(error: Error?, data: [SearchResultModel])
    func didResponseMostRated(error: Error?, data: [SearchResultModel])
    func didResponseUpcoming(error: Error?, data: [SearchResultModel])
    func homeCountSections() -> Int
    func homeSection(for index: Int) -> Sections
    func selectedMosPopular(index: Int, section: Sections)
    func selectedMosRated(index: Int, section: Sections)
    func selectedUpcoming(index: Int, section: Sections)
}
