//
//  Preferences.swift
//  Training
//
//  Created by Jorge Angel Sanchez Martinez on 5/27/19.
//  Copyright © 2019 Jorge Angel Sanchez Martinez. All rights reserved.
//

import Foundation

extension UserDefaults{
    private static let imageBaseUrl = "http://image.tmdb.org/t/p/"
    private static let homeSize = "w500"
    private static let detailSize = "w500"
    private static let URL_IMAGE = "URL_IMAGE"
    private static let IMAGE_HOME_SIZE = "IMAGE_HOME_SIZE"
    private static let IMAGE_DETAIL_SIZE = "IMAGE_DETAIL_SIZE"
    
    public static func setUrlImage(url: String?){
        standard.set(url, forKey: URL_IMAGE)
    }
    
    public static func urlImage() -> String{
        return standard.string(forKey: URL_IMAGE) ?? imageBaseUrl
    }
    
    public static func setImageHomeSize(size: String?){
        standard.set(size, forKey: IMAGE_HOME_SIZE)
    }
    
    public static func imageHomeSize() -> String{
        return standard.string(forKey: IMAGE_HOME_SIZE) ?? homeSize
    }
    
    public static func setImageDetailSize(size: String?){
        standard.set(size, forKey: IMAGE_DETAIL_SIZE)
    }
    
    public static func imageDetailSize() -> String{
        return standard.string(forKey: IMAGE_DETAIL_SIZE) ?? detailSize
    }
}

