//
//  ClientManager.swift
//  GAP International
//
//  Created by Yogesh on 6/19/23.
//

import Foundation
import UIKit

func createAccount(username: String, password: String) {
    let body: [String: String] = [
        "UserName": username,
        "Password": password
    ]
    guard let request = createRequest(url: createUserUrl!, body: body) else {
        return
    }
    
    networkCall(request: request) { data in
        let decoder = JSONDecoder()
        if let model = try? decoder.decode(Login.self, from: data!) {
            print(model.Result)
        }
    }
    
}


func loginAccount(username: String, password: String, completion: @escaping (Bool) -> ()){
    
    var check = false
    let body: [String: String] = [
        "UserName": username,
        "Password": password
    ]
    guard let request = createRequest(url: userLoginUrl!, body: body) else {
        completion(false)
        return
    }
    
    networkCall(request: request) { data in
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
    
    var check = false
    let body: [String: Any] = [
        "UserName": username,
        "ChapterName": chpName,
        "Comment": comment,
        "Level" : level
        
    ]
    guard let request = createRequest(url: url, body: body) else {
        completion(false)
        return
    }
    
    if comment != "" {
    networkCall(request: request) { data in
        let decoder = JSONDecoder()
        if let model = try? decoder.decode(Login.self, from: data!) {
            print(model.Result)
            if model.Result == "Save successful"{
                check = true
                completion(true)
            }
            else{
                completion(false)
                
            }
        }
        }
    }
}




func getJournalDetails(url: URL) -> [JournalDetails]{
    
    var request = URLRequest(url: url)
    var details : [JournalDetails] = []
    request.httpMethod = "GET"
    
    networkCall(request: request) { data in
        let decoder = JSONDecoder()
        if let model = try? decoder.decode([JournalDetails].self, from: data!) {
            print("Decoding Successful !!!")
            
            details = model
            
        } else{
            print("Decoding error")
        }
        
    }
    print("Details data = ", details)
    return details
}
