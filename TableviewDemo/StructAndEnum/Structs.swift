//
//  Structs.swift
//  TableViewDemo
//
//  Created by Pooja Gupta on 13/01/20.
//  Copyright © 2020 Accenture. All rights reserved.
//

import Foundation

//MARK: Web service related status codes

struct HTTP {
    private init(){}
    
    struct Status {
        
        private init(){}
        
        static let internetFailure:Int = 0
        static let success:Int = 200
        static let created:Int = 201
        static let noContentAvailable:Int = 204
        static let unauthorized:Int = 401
        static let forbidden:Int = 403
        static let resourceNotExist:Int = 404
        static let conflict:Int = 409
        static let badRequest:Int  = 400
        static let serverError : Int = 500
    }
}

