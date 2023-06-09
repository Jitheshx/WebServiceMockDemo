//
//  NetworkClient.swift
//  WebServiceMockDemo
//
//  Created by Jithesh Xavier on 09/06/23.
//

import Foundation

class NetworkClient {
    
    //1
    private var session: URLSessionProtocol
    //2
    init(withSession session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func searchItunes(url: URL, completion: @escaping  (_ trackStore: TrackStore?, _ errorMessage: String?) -> Void) {
        
        let dataTask = session.dataTask(with: url) { (data,   response, error) in
            //1
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
               return
            }
            //2
            guard let data = data else {
                completion(nil, "No Data")
                return
            }
            //3
            switch statusCode {
        
            //4
            case 200:
                do {
                    let trackStore = try JSONDecoder().decode(TrackStore.self, from: data)
                    completion(trackStore, nil)
                } catch {
                    completion(nil, "error")
                }
                
            //5
            case 404:
                completion(nil, "Bad Url")
            default:
            //6
            completion(nil, "statusCode: \(statusCode)")
            }
        }
        dataTask.resume()
    }
    
}
