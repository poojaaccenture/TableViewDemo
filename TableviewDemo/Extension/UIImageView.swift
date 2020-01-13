//
//  UIImageView.swift
//  TableviewDemo
//
//  Created by Pooja Gupta on 13/01/20.
//  Copyright © 2020 Accenture. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func loadImage(from url:String?, withPlaceholder placeHolder:UIImage?) {
        if let urlString = url {
            let url = URL.init(string: urlString)
            
            var placeHolderImage = placeHolder
            
            if placeHolderImage == nil {
                placeHolderImage = UIImage.init(named: "placeholder")
            }
            
            self.kf.indicatorType = .activity
            (self.kf.indicator?.view as? UIActivityIndicatorView)?.color = UIColor.black;
            
            self.kf.setImage(with: url, placeholder: placeHolderImage, options: [.transition(.fade(0.2))], progressBlock: nil) { (image, error, cacheType, url) in }
        }
    }
}

