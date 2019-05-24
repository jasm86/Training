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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle(title: "app_name".localized(), isLargeTitle: true)
        addSearchBar()
        presenter?.loadView()
    }
    
    private func setupTableView() {
        tableContent.rowHeight = UITableView.automaticDimension
        tableContent.estimatedRowHeight = estimatedRowHeight
    }
    
    func showError(error: String?) {
        showErrorMessage(title: "app_name".localized(), message: error ?? "default_error_message".localized())
    }
    
    func notifyMessage(mesage: String) {
        showMessage(title: "app_name".localized(), message: mesage)
    }
    
    func displayProgress() {
        showProgress()
    }
    
    func dissmisProgress() {
        dismissProgress()
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
}

extension SearchViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return (presenter as? SearchViewPresenterProtocol)?.homeCountSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (presenter as? SearchViewPresenterProtocol)?.homeSection(for: section).rawValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = (presenter as? SearchViewPresenterProtocol)?.homeSection(for: section)
        if let section = section{
            switch section {
                case .mostPopular:
                    return cellsMostPopular.count
                case .mostRated:
                    return cellsMostRated.count
                case .upcoming:
                    return cellsUpcoming.count
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
                    let cellModel = cellsMostPopular[indexPath.row]
                    let cell = cellModel.cellForTableView(tableView, atIndexPath: indexPath)
                    cellModel.drawCell(cell)
                    return cell
                case .mostRated:
                    let cellModel = cellsMostRated[indexPath.row]
                    let cell = cellModel.cellForTableView(tableView, atIndexPath: indexPath)
                    cellModel.drawCell(cell)
                    return cell
                case .upcoming:
                    let cellModel = cellsUpcoming[indexPath.row]
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
                presenter.selectedMosPopular(index: indexPath.row, section: .mostPopular)
            case .mostRated:
                presenter.selectedMosRated(index: indexPath.row, section: .mostRated)
            case .upcoming:
                presenter.selectedUpcoming(index: indexPath.row, section: .upcoming)
            }
        }
    }
}
