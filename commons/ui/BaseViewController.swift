//
//  BaseViewController.swift
//  Training
//
//  Created by Jorge Angel Sanchez Martinez on 5/25/19.
//  Copyright © 2019 Jorge Angel Sanchez Martinez. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController{
    @IBOutlet weak var scrollContent: UIScrollView!
    
    override func viewDidLoad() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }        
    
    @objc func keyboardWillHide(notification: NSNotification) {
        print("keyboardWillHide")
        if let scroll = scrollContent{
            scroll.contentInset.bottom = 0
            scroll.scrollIndicatorInsets.bottom = 0
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        print("keyboardWillShow")
        //let distanceToMove = rectField.origin.y + rectField.height - keyboardRect.origin.y
        if let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue, let scroll = scrollContent{
            scroll.contentInset.bottom = keyboardSize.cgSizeValue.height
            scroll.scrollIndicatorInsets.bottom = keyboardSize.cgSizeValue.height
        }
    }
    
    public func isNetworkConnected() -> Bool {
        let reachable = ReachabilityManager<Api>.shared.isReachable()
        if !reachable {
            showMessage(title: "", message: "connection_error".localized())
        }
        return reachable
    }
    
    public func showProgress(title: String? = nil){
        ProgressView.show(in: self, with: title ?? "wait".localized())
    }
    
    public func dismissProgress(_ completion: (() -> Void)? = nil){
        ProgressView.hide(completion)
    }
    
    public func hideKeyboard(){
        self.view.endEditing(true)
    }
    
    public func isValidForm() -> Bool{
        let isValid = true
        return isValid
    }
    
    func showMessage(title: String, message: String, completion: (()->())? = nil){
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "accept".localized(), style: .default){ action in
            completion?()
        }
        alertView.addAction(confirmAction)
        present(alertView, animated: true, completion: nil)
    }
    
    
    func showErrorMessage(title: String, message: String, completion: (()->())? = nil){
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "accept".localized(), style: .destructive){ action in
            completion?()
        }
        alertView.addAction(confirmAction)
        present(alertView, animated: true, completion: nil)
    }
    
    func showMessageConfirm( title: String, message: String, completition: @escaping ()->()){
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "accept".localized(), style: .default){ action in
            completition()
        }
        alertView.addAction(confirmAction)
        let cancelAction = UIAlertAction(title: "cancel".localized(), style: .cancel, handler: nil)
        alertView.addAction(cancelAction)
        present(alertView, animated: true, completion: nil)
    }
    
    func showMessageConfirm( title: String, message: String, accept: String, acceptCompletition: (() -> ())? = nil, cancel: String, cancelCompletition: (() -> ())? = nil){
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: accept, style: .default){ action in
            acceptCompletition?()
        }
        alertView.addAction(confirmAction)
        let cancelAction = UIAlertAction(title: cancel, style: .default){ action in
            cancelCompletition?()
        }
        alertView.addAction(cancelAction)
        present(alertView, animated: true, completion: nil)
    }
    
    func showMessageConfirm( message: String, completition: @escaping ()->()){
        let alertView = UIAlertController(title: "app_name".localized(), message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "accept".localized(), style: .default){ action in
            completition()
        }
        alertView.addAction(confirmAction)
        let cancelAction = UIAlertAction(title:  "cancel".localized(), style: .cancel, handler: nil)
        alertView.addAction(cancelAction)
        present(alertView, animated: true, completion: nil)
    }
}
