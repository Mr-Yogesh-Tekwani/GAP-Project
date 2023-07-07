//
//  ClientManager.swift
//  GAP International
//
//  Created by Yogesh on 6/19/23.
//

import Foundation
import UIKit

class ClientManager {
    
    var networkClient: NetworkClient

    init(networkClient: NetworkClient = NetworkClient()) {
        self.networkClient = networkClient
    }
    
    func createAccount(username: String, password: String, completion: @escaping (Bool) -> ()) {
        let body: [String: String] = [
            "UserName": username,
            "Password": password
        ]
        guard let request = networkClient.createRequest(url: createUserUrl!, body: body) else {
            return
        }
        
        networkClient.networkCall(request: request) { data in
            let decoder = JSONDecoder()
            if let model = try? decoder.decode(Login.self, from: data!) {
                print(model.Result)
                if model.Result.lowercased() == "username already exist" {
                    completion(false)
                }
                else{
                    completion(true)
                }
            }
        }
        
    }
    
    
    func loginAccount(username: String, password: String, completion: @escaping (Bool) -> ()){
        
        var check = false
        let body: [String: String] = [
            "UserName": username,
            "Password": password
        ]
        guard let request = networkClient.createRequest(url: userLoginUrl!, body: body) else {
            completion(false)
            return
        }
        
        networkClient.networkCall(request: request) { data in
            let decoder = JSONDecoder()
            if let model = try? decoder.decode(Login.self, from: data!) {
                print(model.Result)
                if model.Result == "Login successful"{
                    check = true
                    completion(true)
                    print("Check = ", check)
                }
                else{
                    completion(false)
                    
                }
            }
        }
        
    }
    
    
    
    func saveJournalProgress(url: URL, username: String, chpName: String, comment: String, level: Int, completion: @escaping (Bool) -> ()){
        
        let body: [String: Any] = [
            "UserName": username,
            "ChapterName": chpName,
            "Comment": comment,
            "Level" : level
            
        ]
        guard let request = networkClient.createRequest(url: url, body: body) else {
            completion(false)
            return
        }
        
        if comment != "" {
            networkClient.networkCall(request: request) { data in
                let decoder = JSONDecoder()
                if let model = try? decoder.decode(Login.self, from: data!) {
                    print(model.Result)
                    if model.Result == "Save successful"{
                        
                        completion(true)
                    }
                    else{
                        completion(false)
                        
                    }
                }
            }
        }
    }    
}
