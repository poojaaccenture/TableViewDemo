//
//  BaseViewModel.swift
//  TableviewDemo
//
//  Created by Pooja Gupta on 13/01/20.
//  Copyright © 2020 Accenture. All rights reserved.
//

import UIKit

class BaseViewModel {

    var data: TableData?
    
    
}

// Network calls
extension BaseViewModel {
    
    func getTableData() {
        
        WebServicesMappingUtil.getTableData {[weak self] (response, statusCode) in
            print(response as Any, statusCode)
           
            switch statusCode {
                
                case HTTP.Status.success:
                    if let response = response as? TableData {
                        self?.data = response
                }
                
            default:
                break
            }
            
        }
    }
}
