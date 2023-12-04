//
//  LoginViewController.swift
//  MymovieApp
//
//  Created by Katya Miranda on 12/11/23.
//

import UIKit

class LoginViewController: MainViewController {
 
    enum LogInResult {
        case success
        case informationIsEmpty
        
        
        var errorTtitle: String{
            switch self {
            case .informationIsEmpty:
                return "Some information is missing"
            default: return ""
            }
        }
        var errorMessage: String {
            switch self {
            case .informationIsEmpty:
                return "Make sure to fill out all fields."
            default: return ""
            }
        }
    }

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCustomizeTextFields()
        
        let clientDefaults = ClientDefaults.shared
        
        if clientDefaults.getUsername != "" {
            print("EL cliente inició sesión antes")
            //TODO: Send to main screen
        }
        
       

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func logInButton(_ sender: UIButton) {
            let email = emailTextField.text ?? ""
           let drowssap  = passwordTextField.text ?? ""
           
            let result = validateData(email: email, password: drowssap)
        
        if result == .success {
            let loginService = LogInService()
            
            loginService.doLogIn(parameters: .init(username: email, password: drowssap)) 
            { result in
                switch result {
                case .success(let isSuccess):
                    self.alertMessage(title: "LogIn Exitoso", message: "")
                    print(isSuccess)
                case .failure(let error):
                    self.alertMessage(title: "Error", message: error.localizedDescription)
                }
            }
        } else {
            alertMessage(title: result.errorTtitle, message: result.errorMessage)
        }
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
    
    private func validateData(email: String, password: String) -> LogInResult {
        if email.isEmpty || password.isEmpty {
            return .informationIsEmpty
        }
        return .success
    }
    
}


