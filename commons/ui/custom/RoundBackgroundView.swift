//
//  RoundBackgroundView.swift
//  Training
//
//  Created by Jorge Angel Sanchez Martinez on 5/26/19.
//  Copyright © 2019 Jorge Angel Sanchez Martinez. All rights reserved.
//
import UIKit

@IBDesignable
class RoundBackgroundView: UIView{
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func awakeFromNib() {
        self.layoutIfNeeded()
    }
}

