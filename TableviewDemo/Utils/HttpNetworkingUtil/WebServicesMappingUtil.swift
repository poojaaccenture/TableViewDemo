//
//  WebServicesMappingUtil.swift
//  TableViewDemo
//
//  Created by Pooja Gupta on 13/01/20.
//  Copyright © 2020 Organization. All rights reserved.
//

import UIKit
import ObjectMapper

typealias ResponseClosure = (_ response:Any?, _ statusCode:Int)->Void

class WebServicesMappingUtil {
    
    class func getTableData(closure: @escaping ResponseClosure) -> Void {
        
        let url = UrlGeneratorUtil.tableDataUrl();
        
        HttpNetworkingUtil.getDataFromWS(requestURL: url, headerDict: nil) { (response) in
            switch response.result {
            case .success:
                
                if(response.response?.statusCode == HTTP.Status.success){

                    let data  =  Mapper<TableData>().map(JSON: response.result.value as! [String : Any])
                    
                    //Remove the data which title is nill
                    let filtetedData = data?.rows.filter({ (item) -> Bool in
                        item.title != nil
                    })
                    
                    data?.rows = filtetedData ?? [Row]()
                    closure(data as Any, (response.response?.statusCode)!)

                }else{
                    closure(nil, (response.response?.statusCode)!)
                }
                break;
                
            case .failure(var error):
                error = response.result.error!
                closure(error,HTTP.Status.internetFailure)
            }
        }
    }
}
