//
//  SignUpViewController.swift
//  MymovieApp
//
//  Created by Katya Miranda on 12/11/23.
//

import UIKit

class SignUpViewController: MainViewController {
    
    
    enum SignUpResult {
        case passwordNotMatch
        case success
        case informationIsEmpty
        
        
        var errorTtitle: String{
            switch self {
            case .passwordNotMatch:
                return "The passwords don't match"
            case .informationIsEmpty:
                return "Some information is missing"
            default: return ""
            }
        }
        var errorMessage: String {
            switch self {
            case .passwordNotMatch:
                return "Please make sure the passwords are the same."
            case .informationIsEmpty:
                return "Make sure to fill out all fields."
            default: return ""
            }
        }
    }
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var drowssapTextField: UITextField!
    @IBOutlet weak var drowssapConfirmTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCustomizeTextFields()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        
        let email = emailTextField.text ?? ""
        let drowssap = drowssapTextField.text ?? ""
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let confirmdrowssap = drowssapConfirmTextField.text ?? ""
        
        let result = validateData(drowssap: drowssap,
                                  confirmdrowssap: confirmdrowssap,
                                  firstName: firstName,
                                  email: email,
                                  lastName: lastName)
        
        if result == .success{
            
            // TODO: We execute login Service
            let logInService = LogInService()
            
            logInService.doLogIn(parameters:
                    .init(firstName: firstName,
                          lastName: lastName,
                          username: email,
                         password: drowssap,
                         confirmPassword: confirmdrowssap))
            { result in
                switch result {
                case .success(let isSuccess):
                
                    // TODO: We store info in internal database and navigate to main screen
                    self.alertMessage(title: "Sign up Exitoso", message: "")
                    print(isSuccess)
                case .failure(let error):
                    self.alertMessage(title: "Error", message: error.localizedDescription)
                }
            }
        } else {
            alertMessage(title: result.errorTtitle, message: result.errorMessage)
        }
    }
        
        
        @IBAction func signInButtonPressed(_ sender: UIButton) {
            self.dismiss(animated: true, completion: nil)
        }
        
        
        // MARK: Private function
        
        /// Function to set the initial customization of the screen's text fields
        private func setCustomizeTextFields(){
            firstNameTextField.delegate = self
            lastNameTextField.delegate = self
            emailTextField.delegate = self
            drowssapTextField.delegate = self
            drowssapConfirmTextField.delegate = self
            
            
            firstNameTextField.setBorder()
            firstNameTextField.setColorPlaceholder(placeholderText: " First Name")
            lastNameTextField.setBorder()
            lastNameTextField.setColorPlaceholder(placeholderText: " Last Name")
            emailTextField.setBorder()
            emailTextField.setColorPlaceholder(placeholderText: " Email")
            drowssapTextField.setBorder()
            drowssapTextField.setColorPlaceholder(placeholderText: " Password")
            drowssapConfirmTextField.setBorder()
            drowssapConfirmTextField.setColorPlaceholder(placeholderText: " Confirm Password")
        }
        
        
        
    private func validateData(drowssap: String, confirmdrowssap: String, firstName: String, email: String, lastName: String) -> SignUpResult {
            if drowssap != confirmdrowssap{
                return .passwordNotMatch
                } else if drowssap.isEmpty || 
                            confirmdrowssap.isEmpty ||
                            firstName.isEmpty ||
                            email.isEmpty ||
                            lastName.isEmpty {
                    return .informationIsEmpty
                } else {
                    return .success
                }
        }
        
    }
    

