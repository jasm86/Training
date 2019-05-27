//
//  SearchViewController.swift
//  Training
//
//  Created by Jorge Angel Sanchez Martinez on 5/25/19.
//  Copyright © 2019 Jorge Angel Sanchez Martinez. All rights reserved.
//

import UIKit

class SearchViewController: RappiViewController, SearchViewProtocol{
    public static let identifier = "SearchViewControllerIdentifier"
    fileprivate let estimatedRowHeight:CGFloat = 180.0
    var presenter: (PresentableProtocol & PresenterInteractorProtocol)?
    private var cellsMostPopular: [DrawableCellProtocol] = []
    private var cellsMostRated: [DrawableCellProtocol] = []
    private var cellsUpcoming: [DrawableCellProtocol] = []
    @IBOutlet private weak var tableContent: UITableView!
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(SearchViewController.refresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.red
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle(title: "app_name".localized(), isLargeTitle: true)
        addSearchBar()
        setupTableView()
        presenter?.loadView()
    }
    
    @objc func refresh(_ refreshControl: UIRefreshControl) {
        presenter?.loadView()
    }
    
    private func setupTableView() {
        tableContent.rowHeight = UITableView.automaticDimension
        tableContent.estimatedRowHeight = estimatedRowHeight
        tableContent.addSubview(self.refreshControl)
    }
    
    func showError(error: String?) {
        showErrorMessage(title: "app_name".localized(), message: error ?? "default_error_message".localized())
    }
    
    func notifyMessage(mesage: String) {
        showMessage(title: "app_name".localized(), message: mesage)
    }
    
    func displayProgress() {
        refreshControl.beginRefreshing()
    }
    
    func dissmisProgress() {
        refreshControl.endRefreshing()
    }
    
    func showMostPopular(data: [SearchResultModel]){
        cellsMostPopular = []
        cellsMostPopular = data.map{ searchResult in
            return SearchResultCellModel(searchReleaseDate: searchResult.releaseDate, titleSearch: searchResult.title, searchImage: searchResult.posterPath)
        }
    }
    
    func showMostRated(data: [SearchResultModel]){
        cellsMostRated = []
        cellsMostRated = data.map{ searchResult in
            return SearchResultCellModel(searchReleaseDate: searchResult.releaseDate, titleSearch: searchResult.title, searchImage: searchResult.posterPath)
        }
    }
    
    func showMostUpcoming(data: [SearchResultModel]){
        cellsUpcoming = []
        cellsUpcoming = data.map{ searchResult in
            return SearchResultCellModel(searchReleaseDate: searchResult.releaseDate, titleSearch: searchResult.title, searchImage: searchResult.posterPath)
        }
    }
    
    func updateUI() {
        tableContent.reloadData()
    }
    
    override func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            self.cellsMostPopular = self.cellsMostPopular.map{ cellModel in
                if var model = cellModel as? SearchResultCellModel, let title = model.titleSearch {
                    if searchText.isEmpty{
                        model.isEnable = true
                        return model
                    }
                    else if title.indices(of: searchText).count > 0 {
                        model.isEnable = true
                        return model
                    }else{
                        model.isEnable = false
                        return model
                    }
                }else{
                    return cellModel
                }
            }
            self.cellsMostRated = self.cellsMostRated.map{ cellModel in
                if var model = cellModel as? SearchResultCellModel, let title = model.titleSearch {
                    if searchText.isEmpty{
                        model.isEnable = true
                        return model
                    }
                    else if title.indices(of: searchText).count > 0 {
                        model.isEnable = true
                        return model
                    }else{
                        model.isEnable = false
                        return model
                    }
                }else{
                    return cellModel
                }
            }
            self.cellsUpcoming = self.cellsUpcoming.map{ cellModel in
                if var model = cellModel as? SearchResultCellModel, let title = model.titleSearch {
                    if searchText.isEmpty{
                        model.isEnable = true
                        return model
                    }
                    else if title.indices(of: searchText).count > 0 {
                        model.isEnable = true
                        return model
                    }else{
                        model.isEnable = false
                        return model
                    }
                }else{
                    return cellModel
                }
            }
            self.tableContent.reloadData()
        }
    }
}

extension SearchViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return (presenter as? SearchViewPresenterProtocol)?.homeCountSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (presenter as? SearchViewPresenterProtocol)?.homeSection(for: section).description
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = (presenter as? SearchViewPresenterProtocol)?.homeSection(for: section)
        if let section = section{
            switch section {
                case .mostPopular:
                    return cellsMostPopular.filter({
                        ($0 as? SearchResultCellModel)?.isEnable ?? true
                    }).count
                case .mostRated:
                    return cellsMostRated.filter({
                        ($0 as? SearchResultCellModel)?.isEnable ?? true
                    }).count
                case .upcoming:
                    return cellsUpcoming.filter({
                        ($0 as? SearchResultCellModel)?.isEnable ?? true
                    }).count
                }
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let presenter = presenter as? SearchViewPresenterProtocol{
            let section = presenter.homeSection(for: indexPath.section)
            switch section {
                case .mostPopular:
                    let cellModel = cellsMostPopular.filter({
                        ($0 as? SearchResultCellModel)?.isEnable ?? true
                    })[indexPath.row]
                    let cell = cellModel.cellForTableView(tableView, atIndexPath: indexPath)
                    cellModel.drawCell(cell)
                    return cell
                case .mostRated:
                    let cellModel = cellsMostRated.filter({
                        ($0 as? SearchResultCellModel)?.isEnable ?? true
                    })[indexPath.row]
                    let cell = cellModel.cellForTableView(tableView, atIndexPath: indexPath)
                    cellModel.drawCell(cell)
                    return cell
                case .upcoming:
                    let cellModel = cellsUpcoming.filter({
                        ($0 as? SearchResultCellModel)?.isEnable ?? true
                    })[indexPath.row]
                    let cell = cellModel.cellForTableView(tableView, atIndexPath: indexPath)
                    cellModel.drawCell(cell)
                    return cell
            }
        }
        return UITableViewCell()
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let presenter = presenter as? SearchViewPresenterProtocol{
            let section = presenter.homeSection(for: indexPath.section)
            switch section {
            case .mostPopular:
                let cellModelFiltered = cellsMostPopular.filter({
                    ($0 as? SearchResultCellModel)?.isEnable ?? true
                })[indexPath.row]
                var indexUnfiltered = 0
                for (index, model) in cellsMostPopular.enumerated(){
                    if let model = model as? SearchResultCellModel,
                        let cellModelFiltered = cellModelFiltered as? SearchResultCellModel{
                        if model.isEnable && model.titleSearch == cellModelFiltered.titleSearch{
                            indexUnfiltered = index
                        }
                    }
                }
                presenter.selectedMosPopular(index: indexUnfiltered, section: .mostPopular)
            case .mostRated:
                let cellModelFiltered = cellsMostRated.filter({
                    ($0 as? SearchResultCellModel)?.isEnable ?? true
                })[indexPath.row]
                var indexUnfiltered = 0
                for (index, model) in cellsMostRated.enumerated(){
                    if let model = model as? SearchResultCellModel,
                        let cellModelFiltered = cellModelFiltered as? SearchResultCellModel{
                        if model.isEnable && model.titleSearch == cellModelFiltered.titleSearch{
                            indexUnfiltered = index
                        }
                    }
                }
                presenter.selectedMosRated(index: indexUnfiltered, section: .mostRated)
            case .upcoming:
                let cellModelFiltered = cellsUpcoming.filter({
                    ($0 as? SearchResultCellModel)?.isEnable ?? true
                })[indexPath.row]
                var indexUnfiltered = 0
                for (index, model) in cellsUpcoming.enumerated(){
                    if let model = model as? SearchResultCellModel,
                        let cellModelFiltered = cellModelFiltered as? SearchResultCellModel{
                        if model.isEnable && model.titleSearch == cellModelFiltered.titleSearch{
                            indexUnfiltered = index
                        }
                    }
                }
                presenter.selectedUpcoming(index: indexUnfiltered, section: .upcoming)
            }
        }
    }
}
