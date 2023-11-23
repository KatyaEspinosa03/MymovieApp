//
//  ApiClient.swift
//  MymovieApp
//
//  Created by Katya Miranda on 19/11/23.
//

import Foundation

class APIClient {
    
    enum HTTPMethod: String {
        case post = "POST"
        case get = "GET"
    }
    
    private let session = URLSession.shared
    private let headers: [String: String]
    private let url: URL
    private let httpMethod: HTTPMethod
    
    init(headers:  [String: String], url: URL, httpMethod: HTTPMethod ) {
        self.headers = headers
        self.url = url
        self.httpMethod = httpMethod
    }
    
    func executeService(httpBody: Data? = nil, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let dataTask = session.dataTask(with: getRequest(httpBody: httpBody), completionHandler: completion)
        dataTask.resume()
        
    }
    
    private func getRequest(httpBody: Data?) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = httpBody
        return request
    }
}
