//
//  MockNetwork.swift
//  GAP InternationalTests
//
//  Created by Yogesh on 7/6/23.
//

import Foundation
import XCTest

@testable import GAP_International

enum JsonFiles: String {
    case CreateUserFailedResults
    case CreateUserSuccessResults
    case LoginSuccessResults
    case LoginFailedResults
    case SaveJournalSuccessResults
    case SaveJournalFailedResults

    init?(url: URL, failedURL: Bool) {
        switch url {
        case let x where  x == createUserUrl:
            self = failedURL ? .CreateUserFailedResults : .CreateUserSuccessResults
        case let x where  x == userLoginUrl:
            self = failedURL ? .LoginFailedResults : .LoginSuccessResults
        case let x where  x == saveJounalUrl :
            self = failedURL ? .SaveJournalFailedResults : .SaveJournalSuccessResults
        
        default:
            return nil
        }
    }
}


class MockNetwork: NetworkProtocol{

    var AllFailedURLS: Bool = false
    
    func getData(urlRequest: URLRequest,
                 completion: @escaping (Data?, HTTPURLResponse?, Error?) -> Void) {
        guard let url = urlRequest.url,
              let file = JsonFiles(url: url,
                                   failedURL: AllFailedURLS) else {
            completion(nil,nil,nil)
            return
        }
        
        let bundle = Bundle(for: MockNetwork.self)
        if let path = bundle.path(forResource: file.rawValue,
                                       ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path),
                                    options: .mappedIfSafe)
                let response = HTTPURLResponse(url: url,
                                               statusCode: 200,
                                               httpVersion: nil,
                                               headerFields: nil)
                completion(data, response, nil)
            }catch {
                completion(nil,nil,nil)
            }
        } else {
            completion(nil,nil,nil)
        }
        
    }
}
