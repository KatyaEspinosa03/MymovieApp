//
//  LoginViewController.swift
//  MymovieApp
//
//  Created by Katya Miranda on 12/11/23.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        
        setCustomizeTextFields()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func logInButton(_ sender: UIButton) {
    }
    
    @IBAction func signUpButton(_ sender: UIButton) {
        let signUpVC = SignUpViewController()
        present(signUpVC, animated: true)
    }
    
    // MARK: Private Function
    
    private func setCustomizeTextFields(){
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    
        
        emailTextField.setBorder()
        emailTextField.setColorPlaceholder(placeholderText: " Username")
        passwordTextField.setBorder()
        passwordTextField.setColorPlaceholder(placeholderText: " Password")
    }

    /// Function to dsimiss the keyboard once the screen is tapped.
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}

extension LoginViewController: UITextFieldDelegate{
    // Function to get the password to dismiss after hitting the return key.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

