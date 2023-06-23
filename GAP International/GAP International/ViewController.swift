//
//  ViewController.swift
//  GAP International
//
//  Created by Yogesh on 6/19/23.
//

import UIKit

class ViewController: UIViewController {
    
    
    let mainStack : UIStackView = {
        let sv = UIStackView()
        sv.alignment = .fill
        sv.spacing = 150
        sv.distribution = .fill
        sv.axis = .vertical
        sv.backgroundColor = .white
        return sv
    }()
    
    
    let loginButton : UIButton = {
        let b = UIButton()
        b.setTitle("Login", for: .normal)
//        b.backgroundColor = .gray
        b.setTitleColor(.systemBlue, for: .normal)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 50)
        b.addTarget(self, action: #selector(loginClicked), for: .touchUpInside)
        return b
    }()
    
    let signUpButton : UIButton = {
        let b = UIButton()
        b.setTitle("Sign Up", for: .normal)
//        b.backgroundColor = .gray
        b.setTitleColor(.systemBlue, for: .normal)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 50)
        b.addTarget(self, action: #selector(signUpClicked), for: .touchUpInside)
        return b
    }()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        let titleView = UIImageView (image: UIImage (named: "GAP Icon"))
        titleView.contentMode = .scaleAspectFill
        self.navigationItem.titleView = titleView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        
        
//        mainStack.addArrangedSubview(loginButton)
        mainStack.addArrangedSubview(signUpButton)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(loginButton)
        self.view.addSubview(signUpButton)
        
        self.view.addSubview(mainStack)
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100)
        ])
    }
    
    @objc func signUpClicked(){
        let svc = SignUpViewController()
        navigationController?.pushViewController(svc, animated: true)
    }
    
    
    @objc func loginClicked(){
        let svc = LoginViewController()
        navigationController?.pushViewController(svc, animated: true)
    }
    
}

