//
//  RESTService.swift
//  KetoLand
//
//  Created by Jason Sanchez on 10/9/18.
//  Copyright © 2018 Jason Sanchez. All rights reserved.
//

import UIKit

enum RESTServiceError: Error {
    case invalidURL(forEndPoint: String)
    case invalidRequest(withError: String)
    case serialization(withError: String)
    case noData
}

enum RESTServiceOperation: String {
    case get  = "GET"
    case post = "POST"
}

class RESTService {
    typealias RESTCompletionHandler = (_ data: Any?, Error?) -> Void
    
    class func execute(endPoint urlString: String, forType type: RESTServiceOperation, withParams params: [String: Any]?, completionHandler: @escaping RESTCompletionHandler) {
        var queryString = "?"
        var endPoint = urlString
        
        if let params = params {
            for (key, value) in params {
                queryString += "\(key)=\(value)&"
            }
            queryString.removeLast()
        }
        
        if queryString.count > 1 {
            endPoint += queryString
        }
        
        guard let url = URL(string: endPoint) else {
            completionHandler(nil, RESTServiceError.invalidURL(forEndPoint: urlString))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = type.rawValue
        urlRequest.setValue("fe9e20cf717cf7a7338e69c7d922a40c", forHTTPHeaderField: "user-key")
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                completionHandler(nil, RESTServiceError.invalidRequest(withError: error?.localizedDescription ?? ""))
            }
            else {
                guard let data = data else {
                    completionHandler(nil, RESTServiceError.noData)
                    return
                }
                
                do {
                    if let image = UIImage(data: data) {
                        completionHandler(image, nil)
                    }
                    else {
                        let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                        completionHandler(json, nil)
                    }
                }
                catch let error as NSError {
                    completionHandler(nil, RESTServiceError.serialization(withError: error.localizedDescription))
                }
            }
        }
        task.resume()
    }
}
