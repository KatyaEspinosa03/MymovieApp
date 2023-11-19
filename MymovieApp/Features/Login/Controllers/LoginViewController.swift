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
        if let email = emailTextField.text,
           let drowssap  = passwordTextField.text,
           !email.isEmpty && !drowssap.isEmpty {
            processLogIn(email: email, password: drowssap)
            alertMessage(title: "Log in Exitoso", message: "Has ingresado a tu cuenta")
        } else {
            alertMessage(title: "Falta información", message: "Verifica que hayas llenado todos los campos")
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

    /// Function to dsimiss the keyboard once the screen is tapped.
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    private func processLogIn(email: String, password: String){
        let headers = [
            "content-type": "application/json",
            "Authentication": "Bearer 5hvsyf2K6xuUfJVxRu5mDaNI0IAODh",
            "X-RapidAPI-Key": "4628b3ca27msh9c7282376d9f318p1ed571jsn71c004e33816",
            "X-RapidAPI-Host": "logintesting.p.rapidapi.com"
        ]
        
        let url = URL(string: "https://logintesting.p.rapidapi.com/login")!
        
        let parameters = ["email": email,
                          "password": password]
        
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
                do {
                    let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                    print("Log in exitoso:", json!)
                }catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func alertMessage(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

extension LoginViewController: UITextFieldDelegate{
    // Function to get the password to dismiss after hitting the return key.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

