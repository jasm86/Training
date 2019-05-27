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
        downloaConfig()
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
                if let responseMostPopular = self.responseUpcoming{
                    searchPresenter.didResponseUpcoming(error: responseMostPopular.error, data: responseMostPopular.results)
                }
                searchPresenter.didFinishFetchMainScreenSections()
            }
        }
    }
    
    public func fetchMostPopular(){
        var buildParams = EntityMostPopular.buildRequest()
        buildParams.append((key: "api_key", value: Api.key))
        dispatchGrouop.enter()
        ConnectionManager.shared?.get(endPoint: Api.Endpoints.discoverMovie.rawValue, parameters: buildParams){[weak self] data, error in
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
        var buildParams = EntityMostRated.buildRequest()
        buildParams.append((key: "api_key", value: Api.key))
        dispatchGrouop.enter()
        ConnectionManager.shared?.get(endPoint: Api.Endpoints.discoverMovie.rawValue, parameters: buildParams){[weak self] data, error in
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
        dispatchGrouop.enter()
        ConnectionManager.shared?.get(endPoint: Api.Endpoints.discoverMovie.rawValue, parameters: buildParams){[weak self] data, error in
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
    
    public func downloaConfig(){
        var query: [Parameter] = []
        query.append((key: "api_key", value: Api.key))
        dispatchGrouop.enter()
        ConnectionManager.shared?.get(endPoint: Api.Endpoints.config
            .rawValue, parameters: query){[weak self] data, error in
            guard let self = self else { return }
            if error == nil{
                if let response = data {
                    let jsonDecoder = JSONDecoder()
                    guard let responseConfig = try? jsonDecoder.decode(ResponseConfigModel.self, from: response) else{
                        return
                    }
                    UserDefaults.setUrlImage(url: responseConfig.images?.baseUrl)
                    UserDefaults.setImageHomeSize(size: responseConfig.images?.logoSizes?.last)
                    UserDefaults.setImageDetailSize(size: responseConfig.images?.posterSizes?.last)
                }
            }
            self.dispatchGrouop.leave()
        }
    }
    
    func searchResult(at index: Int, section: Sections) -> SearchResultModel? {
        switch section {
            case .mostPopular:
                return responseMostPopular?.results[index]
            case .mostRated:
                return responseMostRated?.results[index]
            case .upcoming:
                return responseUpcoming?.results[index]
        }
    }
}
