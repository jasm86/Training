//
//  ViperProtocols.swift
//  Training
//
//  Created by Jorge Angel Sanchez Martinez on 5/24/19.
//  Copyright © 2019 Jorge Angel Sanchez Martinez. All rights reserved.
//

import Foundation
import UIKit

protocol ViewableProtocol: AnyObject {
    var presenter: (PresentableProtocol & PresenterInteractorProtocol)? { get set }
    
    func showError(error: String?)
    func notifyMessage(mesage: String)
    func displayProgress()
    func dissmisProgress()
    func updateUI()
}

protocol PresentableProtocol: AnyObject {
    var view: ViewableProtocol? { get set }
    var interector: InteractantProtocol? { get set }
    var router: RoutableProtocol? { get set }
    
    func loadView()
}

protocol InteractantProtocol: AnyObject {
    var presenter: PresenterInteractorProtocol? { get set }
}

protocol PresenterInteractorProtocol: AnyObject {
    
}

protocol RoutableProtocol: AnyObject {
    static func createMainModule() -> UIViewController;
}

