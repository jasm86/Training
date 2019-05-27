//
//  ProgressView.swift
//  Training
//
//  Created by Jorge Angel Sanchez Martinez on 5/25/19.
//  Copyright © 2019 Jorge Angel Sanchez Martinez. All rights reserved.
//

import UIKit

class ProgressView: UIView {
    static let shared: ProgressView = ProgressView(frame: .zero)
    private static let iPhoneXVerticalMargin: CGFloat = 50.0
    
    var title: String = ""
    private var titleLabel: UILabel?
    private var spinner: UIActivityIndicatorView?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonSetup()
    }
    
    private func commonSetup() {
        layoutMargins = .zero
        preservesSuperviewLayoutMargins = false
        translatesAutoresizingMaskIntoConstraints = false
        let margins = layoutMarginsGuide
        backgroundColor = UIColor.progressBackground()
        topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        spinner = UIActivityIndicatorView()
        guard let spinner = spinner else {
            return
        }
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.style = .whiteLarge
        spinner.color = UIColor.progressColor()
        spinner.hidesWhenStopped = true
        addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: margins.centerYAnchor).isActive = true
        titleLabel = UILabel()
        guard let titleLabel = titleLabel else {
            return
        }
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let verticalConstraint = NSLayoutConstraint(item: titleLabel,
                                                    attribute: .top,
                                                    relatedBy: .equal,
                                                    toItem: spinner,
                                                    attribute: .bottom,
                                                    multiplier: 1,
                                                    constant: 16)
        addConstraint(verticalConstraint)
        titleLabel.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 250.0).isActive = true
        titleLabel.textColor = UIColor.white
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.lineBreakMode = .byWordWrapping
        // To display the title labe, uncomment these lines
        //        addSubview(titleLabel)
        //        titleLabel?.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setNeedsUpdateConstraints()
        updateConstraintsIfNeeded()
    }
    
    func showSpinner() {
        spinner?.startAnimating()
    }
    
    func hideSpinner() {
        spinner?.stopAnimating()
    }
    
    class func show(in controller: UIViewController, with title: String = "") {
        let view: UIView
        if let navigationController = controller.navigationController {
            view = navigationController.view
        } else {
            view = controller.view
        }
        guard let window = view.window else {
            return
        }
        let progressView = ProgressView.shared
        
        //already showing a spinner, don't add another
        if !window.subviews.filter({$0 is ProgressView}).isEmpty {
            return
        }
        window.addSubview(progressView)
        progressView.preservesSuperviewLayoutMargins = false
        
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: window.topAnchor, constant: -iPhoneXVerticalMargin),
            progressView.bottomAnchor.constraint(equalTo: window.bottomAnchor, constant: iPhoneXVerticalMargin),
            progressView.leadingAnchor.constraint(equalTo: window.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: window.trailingAnchor)
            ])
        
        progressView.setNeedsLayout()
        progressView.layoutIfNeeded()
        progressView.alpha = 1.0
        progressView.showSpinner()
        progressView.titleLabel?.text = title
    }
    
    class func hide(_ completion: (() -> Void)? = nil) {
        let spinner = ProgressView.shared
        defer { completion?() }
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, animations: {
                spinner.hideSpinner()
                spinner.alpha = 0.0
            }, completion: { (success) in
                spinner.removeFromSuperview()
            })
        }
    }
}

