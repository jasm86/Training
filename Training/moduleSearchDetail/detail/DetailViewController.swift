//
//  DetailViewController.swift
//  Training
//
//  Created by Jorge Angel Sanchez Martinez on 5/25/19.
//  Copyright © 2019 Jorge Angel Sanchez Martinez. All rights reserved.
//

import UIKit

class DetailViewController: RappiViewController, DetailViewProtocol{
    public static let identifier = "DetailViewControllerIdentifier"
    var presenter: (PresentableProtocol & PresenterInteractorProtocol)?
    @IBOutlet private weak var descriptionSearchResult: UILabel!
    @IBOutlet private weak var imageSearchResult: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadView()
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
    
    func updateUI() {
        
    }
    
    func showSearchResult(title: String, description: String, image: String) {
        setTitle(title: title, isLargeTitle: false)
        self.descriptionSearchResult.text = description
        
        var imageUrl = UserDefaults.urlImage()
        imageUrl.append(UserDefaults.imageDetailSize())
        imageUrl.append(image)
        
        let url = URL(string: imageUrl)
        imageSearchResult.kf.indicatorType = .activity
        imageSearchResult.kf.setImage(
            with: url,
            placeholder: UIImage(named: "defaultMovie"),
            options: [
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
}
