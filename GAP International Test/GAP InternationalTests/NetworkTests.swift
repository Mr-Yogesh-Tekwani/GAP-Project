//
//  NetworkTests.swift
//  GAP InternationalTests
//
//  Created by Yogesh on 7/6/23.
//

import Foundation
import UIKit
import XCTest
@testable import GAP_International


class NetworkLayerTests: XCTestCase {

    func testCreateuserSuccess() throws {
        let mockNetwork = MockNetwork()
        let networkClient = NetworkClient(network: mockNetwork)
        let client = ClientManager(networkClient: networkClient)
        // Signal
        let callCompletedSignal = expectation(description: "Create User")

        var result : Bool = false
        
        client.createAccount(username: "Jul1011", password: "1111", completion: { check in
            result = check
            callCompletedSignal.fulfill()
        })
        
        
        waitForExpectations(timeout: 3)
        XCTAssertNotNil(result)
        XCTAssertEqual(result, true)
    }

    func testCreateuserFailed() throws {
        let mockNetwork = MockNetwork()
        mockNetwork.AllFailedURLS = true
        let networkClient = NetworkClient(network: mockNetwork)
        let client = ClientManager(networkClient: networkClient)
        // Signal
        let callCompletedSignal = expectation(description: "Create User")

        var result : Bool = false
        
        client.createAccount(username: "Jul1011", password: "1111", completion: { check in
            result = check
            callCompletedSignal.fulfill()
        })
        
        waitForExpectations(timeout: 3)
        XCTAssertNotNil(result)
        XCTAssertEqual(result, false)
    }
    
    
    // Login tests
    
    func testLoginSuccess() throws {
        let mockNetwork = MockNetwork()
        let networkClient = NetworkClient(network: mockNetwork)
        let client = ClientManager(networkClient: networkClient)
        // Signal
        let callCompletedSignal = expectation(description: "Create User")

        var result : Bool = false
        
        client.loginAccount(username: "Jul1011", password: "1111", completion: { check in
            result = check
            callCompletedSignal.fulfill()
        })
        
        
        waitForExpectations(timeout: 3)
        XCTAssertNotNil(result)
        XCTAssertEqual(result, true)
    }

    func testLoginFailed() throws {
        let mockNetwork = MockNetwork()
        mockNetwork.AllFailedURLS = true
        let networkClient = NetworkClient(network: mockNetwork)
        let client = ClientManager(networkClient: networkClient)
        // Signal
        let callCompletedSignal = expectation(description: "Create User")

        var result : Bool = false
        
        client.loginAccount(username: "Jul1011", password: "1111", completion: { check in
            result = check
            callCompletedSignal.fulfill()
        })
        
        waitForExpectations(timeout: 3)
        XCTAssertNotNil(result)
        XCTAssertEqual(result, false)
    }


}
