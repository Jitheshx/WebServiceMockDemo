//
//  NetworkClient+Mock.swift
//  WebServiceMockDemo
//
//  Created by Jithesh Xavier on 09/06/23.
//

import Foundation

// MARK: - DataTask
//1
protocol URLSessionDataTaskProtocol {
    //2
    func resume()
}
//3
extension URLSessionDataTask: URLSessionDataTaskProtocol {
    
}

//1
class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    //2
    func resume() {}
}

// MARK: - URLSession
//1
protocol URLSessionProtocol {
    //2
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
}
//3
extension URLSession: URLSessionProtocol {
    //4
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol   {
        //5
        return (dataTask(with: url, completionHandler: completionHandler) as URLSessionDataTask) as URLSessionDataTaskProtocol
    }
}

//1
class MockURLSession: URLSessionProtocol {
    //2
    var dataTask = MockURLSessionDataTask()
    //3
    var completionHandler: (Data?, URLResponse?, Error?)
    //4
    init(completionHandler: (Data?, URLResponse?, Error?)) {
        self.completionHandler = completionHandler
    }
    //5
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        //6
        completionHandler(self.completionHandler.0,
                          self.completionHandler.1,
                          self.completionHandler.2)
        //7
        return dataTask
    }
}
