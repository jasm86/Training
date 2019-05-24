//
//  RappiViewController.swift
//  Training
//
//  Created by Jorge Angel Sanchez Martinez on 5/25/19.
//  Copyright © 2019 Jorge Angel Sanchez Martinez. All rights reserved.
//

import UIKit

class RappiViewController: BaseViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setTitle(title: String, isLargeTitle: Bool){
        navigationController?.navigationBar.prefersLargeTitles = isLargeTitle
        navigationItem.title = title
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationController?.navigationBar.barTintColor =  UIColor.lightGray
        let barButtonsTextColor = [NSAttributedString.Key.foregroundColor: UIColor.red]
        UIBarButtonItem.appearance().setTitleTextAttributes(barButtonsTextColor , for: .normal)
    }
}

extension BaseViewController: UISearchResultsUpdating{
    
    func addSearchBar(){
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        let appereanceSearchField = UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        appereanceSearchField.defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        appereanceSearchField.tintColor = .darkGray
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
}
