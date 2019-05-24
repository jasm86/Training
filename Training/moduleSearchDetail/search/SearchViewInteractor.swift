//
//  SearchViewInteractor.swift
//  Training
//
//  Created by Jorge Angel Sanchez Martinez on 5/25/19.
//  Copyright © 2019 Jorge Angel Sanchez Martinez. All rights reserved.
//

import Foundation

class SearchViewInteractor: SearchViewInteractorProtocol{
    weak var presenter: PresenterInteractorProtocol?
    let dispatchGrouop = DispatchGroup()
    var responseMostPopular: EntityMostPopular?
    var responseMostRated: EntityMostRated?
    var responseUpcoming: EntityUpcoming?
    
    public func fetchMainScreenSections(){
        fetchMostPopular()
        fetchMostRated()
        fetchUpcoming()
        dispatchGrouop.notify(queue: .main){ [weak self] in
            guard let self = self else { return }
            if let searchPresenter = self.presenter as? SearchViewPresenter{
                if let responseMostPopular = self.responseMostPopular{
                    searchPresenter.didResponseMostPopular(error: responseMostPopular.error, data: responseMostPopular.results)
                }
                if let responseMostPopular = self.responseMostRated{
                    searchPresenter.didResponseMostRated(error: responseMostPopular.error, data: responseMostPopular.results)
                }
                if let responseMostPopular = self.responseMostPopular{
                    searchPresenter.didResponseUpcoming(error: responseMostPopular.error, data: responseMostPopular.results)
                }
                
            }
        }
    }
    
    public func fetchMostPopular(){
        dispatchGrouop.enter()
        var buildParams = EntityMostPopular.buildRequest()
        buildParams.append((key: "api_key", value: Api.key))
        ConnectionManager.shared?.get(endPoint: nil, parameters: buildParams){[weak self] data, error in
            guard let self = self else { return }
            if let error = error{
                self.responseMostPopular = EntityMostPopular(error: error, results: [])
            }else{
                if let response = data {
                    let jsonDecoder = JSONDecoder()
                    guard let responseSearch = try? jsonDecoder.decode(SearchResponseModel.self, from: response) else{
                        self.responseMostPopular = EntityMostPopular(error: .connectionFail, results: [])
                        return
                    }
                    self.responseMostPopular = EntityMostPopular(error: nil, results: responseSearch.results ?? [])
                }
            }
            self.dispatchGrouop.leave()
        }
    }
    
    public func fetchMostRated(){
        dispatchGrouop.enter()
        var buildParams = EntityMostRated.buildRequest()
        buildParams.append((key: "api_key", value: Api.key))
        ConnectionManager.shared?.get(endPoint: nil, parameters: buildParams){[weak self] data, error in
            guard let self = self else { return }
            if let error = error{
                self.responseMostRated = EntityMostRated(error: error, results: [])
            }else{
                if let response = data {
                    let jsonDecoder = JSONDecoder()
                    guard let responseSearch = try? jsonDecoder.decode(SearchResponseModel.self, from: response) else{
                        self.responseMostRated = EntityMostRated(error: .connectionFail, results: [])
                        return
                    }
                    self.responseMostRated = EntityMostRated(error: nil, results: responseSearch.results ?? [])
                }
            }
            self.dispatchGrouop.leave()
        }
    }
    
    public func fetchUpcoming(){
        var buildParams = EntityUpcoming.buildRequest()
        buildParams.append((key: "api_key", value: Api.key))
        ConnectionManager.shared?.get(endPoint: nil, parameters: buildParams){[weak self] data, error in
            guard let self = self else { return }
            if let error = error{
                self.responseUpcoming = EntityUpcoming(error: error, results: [])
            }else{
                if let response = data {
                    let jsonDecoder = JSONDecoder()
                    guard let responseSearch = try? jsonDecoder.decode(SearchResponseModel.self, from: response) else{
                        self.responseUpcoming = EntityUpcoming(error: .connectionFail, results: [])
                        return
                    }
                    self.responseUpcoming = EntityUpcoming(error: nil, results: responseSearch.results ?? [])
                }
            }
            self.dispatchGrouop.leave()
        }
    }
    
    func searchResult(at index: Int, section: Sections) -> SearchResultModel? {
        switch section {
            case .mostPopular:
                return responseMostRated?.results[index]
            case .mostRated:
                return responseMostRated?.results[index]
            case .upcoming:
                return responseMostRated?.results[index]
        }
    }
}
