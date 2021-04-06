//
//  AHTests.swift
//  AHTests
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import XCTest
@testable import AH

class AHTests: XCTestCase {
    
    // MARK: - Properties
    
    var platform: Platform!
    
    func testJSONLocalMapping() throws {
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "Test", withExtension: "json") else {
            XCTFail("Missing file: Test.json")
            return
        }
        
        let data = try Data(contentsOf: url)
        let response: CollectionResponse!
        do {
            response = try JSONDecoder().decode(CollectionResponse.self, from: data)
        } catch(_) {
            XCTFail("Cannot decode json")
            fatalError()
        }
        
        try! testResponseMapping(response)
    }
    
    func testJSONRemoteMapping() throws {
        let expect = expectation(description: "Data loaded")
        
        platform
            .information
            .fetchCollection(with: BaseParameters(language: .en,
                                                  pagination: LimitOffset(limit: 10),
                                                  format: .json,
                                                  sortParameter: .artist,
                                                  imageOnly: true))
            .startWithResult { [unowned self] result in
                switch result {
                case .failure:
                    XCTFail("Data wasn't load")
                case .success(let collection):
                    try! self.testResponseMapping(collection)
                    expect.fulfill()
                    break
                    
                }
            }
        waitForExpectations(timeout: 5.0)
    }

    override func setUpWithError() throws {
        platform = Platform()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    @inlinable func testResponseMapping(_ response: CollectionResponse) throws {
        DispatchQueue.main.async {
            
            XCTAssertEqual(response.count, 469579)
            XCTAssertEqual(response.exhibits.count, 10)
            guard let firstExhibit = response.exhibits.first else {
                XCTFail("Array is empty")
                fatalError()
            }
            XCTAssertEqual(firstExhibit.title, "Model of an Artificial Reef")
            XCTAssertEqual(firstExhibit.description, "Model of an Artificial Reef, 's Lands Werf Amsterdam, 1800")
            XCTAssertEqual(firstExhibit.id, "en-NG-MC-1023")
            XCTAssertEqual(firstExhibit.objectNumber, "NG-MC-1023")
            XCTAssertEqual(firstExhibit.painter, "'s Lands Werf Amsterdam")
            guard let image = firstExhibit.image else {
                XCTFail("Image didn't parsed")
                fatalError()
            }
            XCTAssertEqual(image.height, 1978.0)
            XCTAssertEqual(image.width, 2500)
            XCTAssertEqual(image.url, "https://lh4.ggpht.com/1Dr0Q0HJd_8COtSKmQ0JiW4rAX77YR8jsP0JeRxorwu3oumCUTYMsxBSPqfgaRWjlO9uJt3Ufi1Vfz5yY1nGrHBwaGA=s0")
            XCTAssertEqual(image.id, "7725ae86-826d-419f-b748-5b73827d2297")
        }
    }

}
