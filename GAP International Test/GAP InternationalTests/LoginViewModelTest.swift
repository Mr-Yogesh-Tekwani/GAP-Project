//
//  LoginViewModelTest.swift
//  GAP InternationalTests
//
//  Created by Yogesh on 7/7/23.
//

import Foundation
import XCTest
@testable import GAP_International

class LoginViewModelTest: XCTestCase{

    func testInit() throws {
        let loginVm = LoginViewModel()
        let _ = try XCTUnwrap(loginVm.makeVc() as UIViewController)
        
        
    }
}
