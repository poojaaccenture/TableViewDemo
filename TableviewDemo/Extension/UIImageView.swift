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
            let options: [KingfisherOptionsInfoItem] = [.scaleFactor(UIScreen.main.scale), .transition(.fade(0.25)), .cacheOriginalImage]
            self.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"), options: options, progressBlock: nil) { (image, error, chacheType, url) in
                if (image != nil) {
                     self.image = image
                }
            }
        }
    }
}


