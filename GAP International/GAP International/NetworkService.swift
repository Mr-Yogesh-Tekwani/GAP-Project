//
//  RequestManager.swift
//  GAP International
//
//  Created by Yogesh on 6/19/23.
//

import Foundation

func createRequest(url: URL, body: [String:Any]?, headers: [String:String] = [:]) -> URLRequest? {
    
    var request = URLRequest(url: url)
    
    if let body = body{
        request.httpMethod = "POST"
        do{
            if let data = try? JSONSerialization.data(withJSONObject: body) {
                request.httpBody = data
            }
        } catch{
            print("Fetch Data Error", error, "\n", error.localizedDescription)
            return nil
        }
    }
    else {
        request.httpMethod = "GET"
    }
    request.addValue("application/json", forHTTPHeaderField: "Content-type")
    
    for (key, value) in headers{
        request.addValue(value, forHTTPHeaderField: key)
    }
    return request
}


func networkCall(request:URLRequest, completionHandler: @escaping (Data?) -> Void) {
    URLSession.shared.dataTask(with: request) { data, headers, error in
        if let data = data {
            //print(String(data: data, encoding: .utf8))
            completionHandler(data)
        } else {
            print("Network Err", error, "\n", error?.localizedDescription)
            completionHandler(nil)
        }
    }.resume()
}
