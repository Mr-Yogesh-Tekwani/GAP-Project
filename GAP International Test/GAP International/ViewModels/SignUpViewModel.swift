//
//  SignUpViewModel.swift
//  GAP International
//
//  Created by Yogesh on 7/6/23.
//

import Foundation
import UIKit

class SignUpViewModel {
    
    weak var signUpViewController : SignUpViewController?
    var client = ClientManager()
    
    func makeVc() -> UIViewController {
        let vc = SignUpViewController()
        vc.signUpViewModel = self
        self.signUpViewController = vc
        return vc
        
    }
    
    func signUpPressed(username: String, password: String, finalCompletion: @escaping (Bool) -> ()) {
        
        client.createAccount(username: username, password: password, completion: { check in
            if check == true{
                finalCompletion(true)
            }
            else{
                finalCompletion(false)
            }
        })
    }
}
