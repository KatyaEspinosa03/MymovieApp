//
//  SignUpViewController.swift
//  MymovieApp
//
//  Created by Katya Miranda on 12/11/23.
//

import UIKit

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var drowssapTextField: UITextField!
    @IBOutlet weak var drowssapConfirmTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCustomizeTextFields()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)

        // Do any additional setup after loading the view.
    }


    @IBAction func signUpButtonPressed(_ sender: UIButton) {
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
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
    
}

extension SignUpViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
