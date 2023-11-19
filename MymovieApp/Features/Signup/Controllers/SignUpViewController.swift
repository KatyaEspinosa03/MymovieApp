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
        
        if let email = emailTextField.text,
           let drowssap = drowssapTextField.text,
           let firstName = firstNameTextField.text,
           let lastName = lastNameTextField.text,
           let confirmdrowssap = drowssapConfirmTextField.text,
           !email.isEmpty &&
            !drowssap.isEmpty &&
            !firstName.isEmpty &&
            !lastName.isEmpty &&
            !confirmdrowssap.isEmpty &&
            drowssap == confirmdrowssap {
            
            processSignup(firstName: firstName, lastname: lastName, email: email, password: drowssap, confirmPassword: confirmdrowssap)
            alertMessage(title: "Sign up exitoso", message: "Tu información ha sido registrada")
            
        }else if let drowssap = drowssapTextField.text,
                 let confirmdrowssap = drowssapConfirmTextField.text,
        drowssap != confirmdrowssap {
            alertMessage(title: "Las contraseñas no coinciden", message: "Confirma que las contraseñas sean iguales")
           
        } else {
            
            alertMessage(title: "Falta información", message: "Rellena todos los campos")
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
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
    /// Function to connect to the webserver and do the sign up
    ///
    /// This function takes the following parameters: first name, last name, email, password and confirim password
    private func processSignup(firstName: String, lastname: String, email: String, password: String, confirmPassword: String ){
        
        let headers = [
            "content-type": "application/json",
            "Authentication": "Bearer 5hvsyf2K6xuUfJVxRu5mDaNI0IAODh",
            "X-RapidAPI-Key": "4628b3ca27msh9c7282376d9f318p1ed571jsn71c004e33816",
            "X-RapidAPI-Host": "logintesting.p.rapidapi.com"
        ]
        
        let url = URL(string: "https://logintesting.p.rapidapi.com/login")!
        
        let parameters = ["firstName": firstName,
                          "lastName": lastname,
                          "username": email,
                          "password": password,
                          "confirmPassword": confirmPassword]
        
        let postData = try! JSONSerialization.data(withJSONObject: parameters)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData
        
        let urlSession = URLSession.shared
        let dataTask = urlSession.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let response = response as? HTTPURLResponse,
                      response.statusCode == 202, let data = data {
                do{
                    let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                    print("Sign up exitoso", json!)
                }catch{
                    print(error.localizedDescription)
                }
            }
            
        }
        dataTask.resume()
        
    }
    
    /// Function to customize the alert messages used when trying to dispatch the webserver connection
    ///
    /// - Parameters:
    ///    - title: title to show to the user
    ///    - message: the action the user needs to take
   
    private func alertMessage(title: String, message:String ){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
        
    }
}

extension SignUpViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
