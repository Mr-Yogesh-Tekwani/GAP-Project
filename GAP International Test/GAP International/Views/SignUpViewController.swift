//
//  SignUpViewController.swift
//  GAP International
//
//  Created by Yogesh on 6/19/23.
//

import UIKit

class SignUpViewController: UIViewController {
    
    var signUpViewModel : SignUpViewModel?
    var usernameTextField: UITextField!
    var passwordTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        let titleView = UIImageView (image: UIImage (named: "GAP Icon"))
        titleView.contentMode = .scaleAspectFill
        self.navigationItem.titleView = titleView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        usernameTextField = UITextField()
        usernameTextField.placeholder = "Username"
        usernameTextField.font = UIFont.systemFont(ofSize: 30)
        usernameTextField.layer.borderWidth = 3.0
        usernameTextField.layer.borderColor = UIColor.systemBlue.cgColor
        usernameTextField.borderStyle = .roundedRect
        
        self.view.addSubview(usernameTextField)
        
        // Create and position the password text field
        passwordTextField = UITextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.font = UIFont.systemFont(ofSize: 30)
        passwordTextField.layer.borderWidth = 3.0
        passwordTextField.layer.borderColor = UIColor.systemBlue.cgColor
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        self.view.addSubview(passwordTextField)
        
        // Create a sign-up button
        let signUpButton = UIButton(type: .system)
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
        signUpButton.setTitleColor(.systemBlue, for: .normal)
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        self.view.addSubview(signUpButton)
        
        
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            usernameTextField.heightAnchor.constraint(equalToConstant: 70),
            usernameTextField.widthAnchor.constraint(equalToConstant: 300),
            
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100),
            passwordTextField.heightAnchor.constraint(equalToConstant: 70),
            passwordTextField.widthAnchor.constraint(equalToConstant: 300),
            
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 250)
        ])
        
    }
    
    @objc func signUpButtonTapped() {
        guard let username = usernameTextField.text, !username.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
                  // Show an error message if any field is empty
                  showAlert(title: "Error", message: "Please fill in all fields.")
                  return
              }
        
        signUpViewModel?.signUpPressed(username: username, password: password, finalCompletion: { ans in
            DispatchQueue.main.async {
                if ans == true{
                    self.showAlert(title: "Success", message: "User Created Successfully! \n Please go back and Login")
                    print("Signing up with username: \(username), password: \(password)")
                }
                else{
                    self.showAlert(title: "Error !", message: "Username Already Exists !")
                }
            }
        })
        
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
