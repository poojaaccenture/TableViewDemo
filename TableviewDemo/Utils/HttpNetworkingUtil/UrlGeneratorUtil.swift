//
//  UrlGeneratorUtil.swift
//  TableViewDemo
//
//  Created by Pooja Gupta on 16/10/18.
//  Copyright © 2018 SlicePay. All rights reserved.
//

import UIKit

class UrlGeneratorUtil: NSObject {

    
    //      https://newsapi.org/v2/everything?q=apple&pageSize=10&page=1&sortBy=publishedAt&apiKey=3363a374df9f4660a260a187915f0937
    class func getNewsDataUrl(for page : UInt) ->String{
  
        return "\(API.getRootUrl())/everything?q=apple&pageSize=\(Constants.pageSize)&page=\(page)&sortBy=popularity&apiKey=\(Constants.appKey)";
    }
    
}
