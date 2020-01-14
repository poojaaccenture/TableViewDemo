//
//  BaseViewModel.swift
//  TableviewDemo
//
//  Created by Pooja Gupta on 13/01/20.
//  Copyright © 2020 Organization. All rights reserved.
//

import UIKit

class BaseViewModel {
    
    var data: TableData?
    
    // MARK:- Dynamic parameters
    let dataDidLoad = Dynamic<Bool>(value: false)
    
    var title: String {
        return data?.title ?? ""
    }
    
}

// MARK:- Table releated methods
extension BaseViewModel {
    func numberOfRows(in section: Int) -> Int {
        return data?.rows.count ?? 0
    }
    
    func cellViewModel(for indexPath: IndexPath) -> BaseCellViewModel? {
        var cellViewModel: BaseCellViewModel?
        
        if indexPath.row < data?.rows.count ?? 0 {
            
            let cellData = data?.rows[indexPath.row]
            let title = LabelText.textWithStyle(TextWithStyle.init(text: cellData?.title ?? "", color: .black, font: UIFont.boldSystemFont(ofSize: 18), alignment: .left))
            let description = LabelText.textWithStyle(TextWithStyle.init(text: cellData?.description ?? "", color: .black, font: UIFont.systemFont(ofSize: 15), alignment: .left))
            
            cellViewModel = BaseCellViewModel.init(title: title, description: description, imageUrl: cellData?.imageHref)
        }
        
        return cellViewModel
    }
}

//MARK:- Network calls
extension BaseViewModel {
    
    func getTableData() {
        
        WebServicesMappingUtil.getTableData {[weak self] (response, statusCode) in
            guard let self = self else { return }
            
            switch statusCode {
            case HTTP.Status.success:
                if let response = response as? TableData {
                    self.data = response
                    self.dataDidLoad.value = true
                }
                
            default:
                break
            }
            
        }
    }
}
