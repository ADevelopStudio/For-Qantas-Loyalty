//
//  For_Qantas_LoyaltyTests.swift
//  For Qantas LoyaltyTests
//
//  Created by Dmitrii Zverev on 26/6/18.
//  Copyright © 2018 Dmitrii Zverev. All rights reserved.
//

import XCTest
@testable import For_Qantas_Loyalty

class For_Qantas_LoyaltyTests: XCTestCase {
    
    
    func testRemovingWhiteCrap() {
        let testString = "  hello  there \n\n"
        let testResultString = "hello  there"
        XCTAssertEqual(testString.withoutWhiteCrap, testResultString)
    }
    

    func testAsynchronousURLConnection() {
        
        let url = URL(string:  ConnectionManager.recipesBaseUrl)!
        let urlExpectation = expectation(description: "GET \(url)")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            XCTAssertNotNil(data, "data should not be nil")
            XCTAssertNil(error, "error should be nil")
            
            if let response = response as? HTTPURLResponse,
                let responseURL = response.url,
                let mimeType = response.mimeType
            {
                let decoder = JSONDecoder()
                if let data = data {
                    XCTAssertNotNil(try? decoder.decode(SearchResults.self, from: data), "SearchResults JOSN Decoding error")
                }
                XCTAssertEqual(responseURL.absoluteString, url.absoluteString, "HTTP response URL should be equal to original URL")
                XCTAssertEqual(response.statusCode, 200, "HTTP response status code should be 200")
                XCTAssertEqual(mimeType, "application/json", "HTTP response content type should be application/json")
            } else {
                XCTFail("Response was not HTTPURLResponse")
            }
            
            urlExpectation.fulfill()
        }
        
        task.resume()
        
        waitForExpectations(timeout: task.originalRequest!.timeoutInterval) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            task.cancel()
        }
    }
    
}
