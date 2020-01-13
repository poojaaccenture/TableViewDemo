//
//  WebServicesMappingUtil.swift
//  TableViewDemo
//
//  Created by Pooja Gupta on 16/10/18.
//  Copyright © 2018 SlicePay. All rights reserved.
//

import UIKit
import ObjectMapper

typealias ResponseClosure = (_ response:Any?, _ statusCode:Int)->Void

class WebServicesMappingUtil: NSObject {
    
    class func getNews(for pageNo : UInt, closure: @escaping ResponseClosure) -> Void {
        
        let url = UrlGeneratorUtil.getNewsDataUrl(for: pageNo);
        
        HttpNetworkingUtil.getDataFromWS(requestURL: url, headerDict: nil) { (response) in
            switch response.result {
            case .success:
                
                if(response.response?.statusCode == HTTP.Status.success){
                    
                    let news  =  Mapper<News>().map(JSON: response.result.value as! [String : Any]);
                    
                    closure(news as Any, (response.response?.statusCode)!)
                    
                }else{
                    closure(nil, (response.response?.statusCode)!)
                }
                
            case .failure(var error):
                error = response.result.error!
                closure(error, HTTP.Status.internetFailure)
            }
        }
    }
}
