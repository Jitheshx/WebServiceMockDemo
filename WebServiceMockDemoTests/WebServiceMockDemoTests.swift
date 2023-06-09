//
//  WebServiceMockDemoTests.swift
//  WebServiceMockDemoTests
//
//  Created by Jithesh Xavier on 09/06/23.
//

import XCTest
@testable import WebServiceMockDemo

final class WebServiceMockDemoTests: XCTestCase {
    
    //1
    var sut: NetworkClient!
    //2
    var mockSession: MockURLSession!
    
    override func setUpWithError() throws {
        
    }
    
    override func tearDownWithError() throws {
        sut = nil
        mockSession = nil
        super.tearDown()
    }
    
    private func loadJsonData(file: String) -> Data? {
        //1
        if let jsonFilePath = Bundle(for: type(of:  self)).path(forResource: file, ofType: "json") {
            let jsonFileURL = URL(fileURLWithPath: jsonFilePath)
            //2
            if let jsonData = try? Data(contentsOf: jsonFileURL) {
                return jsonData
            }
        }
        //3
        return nil
    }
    
    private func createMockSession(fromJsonFile file: String,
                                   andStatusCode code: Int,
                                   andError error: Error?) -> MockURLSession? {
        
        //1
        let data = loadJsonData(file: file)
        //2
        let response = HTTPURLResponse(url: URL(string: "TestUrl")!, statusCode: code, httpVersion: nil, headerFields: nil)
        //3
        return MockURLSession(completionHandler: (data, response, error))
    }
    
    //1
    func testNetworkClient_successResult() {
        mockSession = createMockSession(fromJsonFile: "Search",
                                        andStatusCode: 200, andError: nil)
        sut = NetworkClient(withSession: mockSession)
        sut.searchItunes(url: URL(string: "TestUrl")!) { (trackStore, errorMessage) in
            XCTAssertNotNil(trackStore)
            XCTAssertNil(errorMessage)
            XCTAssertTrue(trackStore?.results?.count == 1)
            let track = trackStore?.results?.first!
            XCTAssertTrue(track?.artistName == "The Prodigy")
        }
    }
    //2
    func testNetworkClient_404Result() {
        mockSession = createMockSession(fromJsonFile: "Search", andStatusCode: 404, andError: nil)
        sut = NetworkClient(withSession: mockSession)
        sut.searchItunes(url: URL(string: "TestUrl")!) { (trackStore, errorMessage) in
            XCTAssertNotNil(errorMessage)
            XCTAssertNil(trackStore)
            XCTAssertTrue(errorMessage == "Bad Url")
        }
    }
    //3
    func testNetworkClient_NoData() {
        mockSession = createMockSession(fromJsonFile: "A", andStatusCode: 500, andError: nil)
        sut = NetworkClient(withSession: mockSession)
        sut.searchItunes(url: URL(string: "TestUrl")!) { (trackStore, errorMessage) in
            XCTAssertNotNil(errorMessage)
            XCTAssertNil(trackStore)
            XCTAssertTrue(errorMessage == "No Data")
        }
    }
    //4
    func testNetworkClient_AnotherStatusCode() {
        mockSession = createMockSession(fromJsonFile: "Search", andStatusCode: 401, andError: nil)
        sut = NetworkClient(withSession: mockSession)
        sut.searchItunes(url: URL(string: "TestUrl")!) { (trackStore, errorMessage) in
            XCTAssertNotNil(errorMessage)
            XCTAssertNil(trackStore)
            XCTAssertTrue(errorMessage == "statusCode: 401")
        }
    }
}
