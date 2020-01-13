//
//  HttpNetworkingUtil.swift
//  TableViewDemo
//
//  Created by Pooja Gupta on 16/10/18.
//  Copyright © 2018 SlicePay. All rights reserved.
//

import UIKit
import Alamofire

public typealias WSCompletionBlock = (DataResponse<Any>) -> Void

class HttpNetworkingUtil: NSObject {

    /// GET Request
    ///
    /// - Parameters:
    ///   - requestURL: *String* - URL
    ///   - headerDict: *NSDictionary* - Custom headers to be added
    ///   - closure: *WSCompletionBlock* - Completion Block that will be executed once API call is done
    class func getDataFromWS(requestURL: String, headerDict: NSDictionary?, closure: @escaping WSCompletionBlock) -> Void{

        if let url = URL(string: requestURL) {

            var urlRequest = URLRequest(url: url)

            urlRequest.httpMethod = HTTPMethod.get.rawValue

            urlRequest.allHTTPHeaderFields = HttpNetworkingUtil.getHeaders(from: headerDict, for: urlRequest)

            Alamofire.request(urlRequest)
                .responseJSON { response in
                    closure(response)
            }

        }
    }
    
    
    /// Used to append custom headers to default headers
    ///
    /// - Parameters:
    ///   - headerDict: *NSDictionary* - The custom headers required
    ///   - urlRequest: *URLRequest* - The URLRequest for which headers are used
    /// - Returns: *HTTPHeaders* - The combined headers for the request
    class func getHeaders(from headerDict:NSDictionary?, for urlRequest:URLRequest?) -> HTTPHeaders{
        
        var headers: HTTPHeaders
        
        if let existingHeaders = urlRequest?.allHTTPHeaderFields {
            headers = existingHeaders
        } else {
            headers = HTTPHeaders()
        }
        
        if let header = headerDict{
            for(key, value) in header{
                headers[key as! String] = value as? String
            }
        }
        
        return headers
    }
}
