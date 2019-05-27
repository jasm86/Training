//
//  SearchResultCell.swift
//  Training
//
//  Created by Jorge Angel Sanchez Martinez on 5/26/19.
//  Copyright © 2019 Jorge Angel Sanchez Martinez. All rights reserved.
//

import UIKit
import Kingfisher

struct SearchResultCellModel: DrawableCellProtocol{
    var searchReleaseDate: String?
    var titleSearch: String?
    var searchImage: String?
    var isEnable = true
    
    init(searchReleaseDate: String?, titleSearch: String?, searchImage: String?) {
        self.searchReleaseDate = searchReleaseDate
        self.titleSearch = titleSearch
        self.searchImage = searchImage
    }
    
    func cellForTableView(_ tableView: UITableView, atIndexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: SearchResultCell.identifier, for: atIndexPath)
    }
    
    func drawCell(_ cell: UITableViewCell) {
        if let cell = cell as? SearchResultCell{
            cell.fill(searchReleaseDate: searchReleaseDate, titleSearch: titleSearch, image: searchImage)
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
    
    fileprivate func fill(searchReleaseDate: String?, titleSearch: String?, image: String?){
        self.titleSearch.text = titleSearch
        self.searchReleaseDate.text = searchReleaseDate
        if let imagePath = image {
            var imageUrl = UserDefaults.urlImage()
            imageUrl.append(UserDefaults.imageHomeSize())
            imageUrl.append(imagePath)
            
            let url = URL(string: imageUrl)
            searchImage.kf.indicatorType = .activity
            searchImage.kf.setImage(
                with: url,
                placeholder: UIImage(named: "defaultMovie"),
                options: [
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
        }
        
    }
}
