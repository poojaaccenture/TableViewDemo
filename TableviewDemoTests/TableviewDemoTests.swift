//
//  TableviewDemoTests.swift
//  TableviewDemoTests
//
//  Created by Pooja Gupta on 17/01/20.
//  Copyright © 2020 Organization. All rights reserved.
//

import XCTest
@testable import  TableviewDemo
import Alamofire

class TableviewDemoTests: XCTestCase {
    var sut: BaseViewModel!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    testApiResponse()
    }
    
    func testApiResponse() {
        let e = expectation(description: "200")
        WebServicesMappingUtil.getTableData { (response, statusCode) in
            if statusCode == 200 {
                e.fulfill()
            } else {
                XCTFail("Status code: \(statusCode)")
            }
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
