//
//  TableData.swift
//  TableviewDemo
//
//  Created by Pooja Gupta on 13/01/20.
//  Copyright © 2020 Accenture. All rights reserved.
//

import UIKit
import ObjectMapper

class TableData: Mappable {

    var title : String?;
    var rows = [Row]();
    
    
    required init?(map: Map) {
        
    }
    
    init() {}
    
    convenience init(title : String?, rows : [Row]) {
        self.init();
        self.title = title;
        self.rows = rows;
    }
    
    func mapping(map: Map) {
        
        title <- map["title"];
        rows <- map["rows"];
    }
}

class Row: Mappable{
    var title: String?
    var description: String?
    var imageHref: String?
    
    
    required init?(map: Map) {
        
    }
    
    init() {}
    
    convenience init(title : String?, description : String?, imageHref: String?) {
        self.init();
        self.title = title
        self.description = description
        self.imageHref = imageHref
    }
    
    func mapping(map: Map) {
        
        title <- map["title"];
        description <- map["description"];
        imageHref <- map["imageHref"];
    }
}
