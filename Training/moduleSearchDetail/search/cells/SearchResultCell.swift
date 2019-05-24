//
//  SearchResultCell.swift
//  Training
//
//  Created by Jorge Angel Sanchez Martinez on 5/26/19.
//  Copyright © 2019 Jorge Angel Sanchez Martinez. All rights reserved.
//

import UIKit
struct SearchResultCellModel: DrawableCellProtocol{
    var searchReleaseDate: String?
    var titleSearch: String?
    var searchImage: String?
    
    func cellForTableView(_ tableView: UITableView, atIndexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: SearchResultCell.identifier, for: atIndexPath)
    }
    
    func drawCell(_ cell: UITableViewCell) {
        if let cell = cell as? SearchResultCell{
            cell.fill(searchReleaseDate: searchReleaseDate, titleSearch: titleSearch, searchImage: searchImage)
        }
    }
}

class SearchResultCell: UITableViewCell{
    static let identifier = "SearchResultCell"
    
    @IBOutlet weak var searchReleaseDate: UILabel!
    @IBOutlet weak var titleSearch: UILabel!
    @IBOutlet weak var searchImage: UIImageView!
    static var nib: UINib = {
        return UINib(nibName: identifier, bundle: nil)
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    fileprivate func fill(searchReleaseDate: String?, titleSearch: String?, searchImage: String?){
        
    }
}
