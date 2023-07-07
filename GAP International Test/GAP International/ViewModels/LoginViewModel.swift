//
//  LoginViewModel.swift
//  GAP International
//
//  Created by Yogesh on 7/5/23.
//

import Foundation
import UIKit

class LoginViewModel {
    
    weak var loginViewController : LoginViewController?
    var client = ClientManager()
    func makeVc() -> UIViewController {
        let vc = LoginViewController()
        vc.loginViewModel = self
        self.loginViewController = vc
        return vc
        
    }
    
    func loginPressed(username: String, password: String, finalCompletion: @escaping (Bool) -> ()) {
        
        client.loginAccount(username: username, password: password, completion: { check in
            print("Loggin in with username: \(username), password: \(password)")
                if check == true {
                    finalCompletion(true)
                    }
                else {
                    finalCompletion(false)
                }
        })
    }
}
