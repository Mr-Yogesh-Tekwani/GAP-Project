//
//  RequestManager.swift
//  GAP International
//
//  Created by Yogesh on 6/19/23.
//

import Foundation

protocol NetworkProtocol {
    func getData(urlRequest: URLRequest,
                 completion: @escaping (Data?, HTTPURLResponse?, Error?) -> Void)
}


class Network: NetworkProtocol {
    func getData(urlRequest: URLRequest, completion: @escaping (Data?, HTTPURLResponse?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, response, error in
            completion(data, response as? HTTPURLResponse, error)
        })
        task.resume()
    }
    
}

class NetworkClient{
    
    var network: NetworkProtocol
    
    init(network: NetworkProtocol = Network()) {
        self.network = network
    }
    
    func createRequest(url: URL, body: [String:Any]?, headers: [String:String] = [:]) -> URLRequest? {
        
        var request = URLRequest(url: url)
        
        if let body = body{
            request.httpMethod = "POST"
            do{
                let data = try JSONSerialization.data(withJSONObject: body)
                request.httpBody = data
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
        network.getData(urlRequest: request, completion: { data, headers, error in
            if let data = data {
                //print(String(data: data, encoding: .utf8))
                completionHandler(data)
            } else {
                print("Network Err", String(describing: error), "\n", String(describing: error?.localizedDescription))
                completionHandler(nil)
            }
        })
    
    }
}
