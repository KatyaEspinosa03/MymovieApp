//
//  LogInService.swift
//  MymovieApp
//
//  Created by Katya Miranda on 19/11/23.
//

import Foundation


class LogInService {
    
    enum LogInErrors: Error {
        case unknownError(Error)
        case errorResponse
    }
    
    struct UserDataLogIn {
        var firstName: String?
        var lastName: String?
        var username: String
        var password: String
        var confirmPassword: String?
    }
    
    private let apiClient: APIClient
    
    init() {
        apiClient = APIClient(headers: [
            "content-type": "application/json",
            "Authentication": "Bearer 5hvsyf2K6xuUfJVxRu5mDaNI0IAODh",
            "X-RapidAPI-Key": "4628b3ca27msh9c7282376d9f318p1ed571jsn71c004e33816",
            "X-RapidAPI-Host": "logintesting.p.rapidapi.com"
        ],
                            url: URL(string: "https://logintesting.p.rapidapi.com/login")!,
                            httpMethod: .post)
    }
    
    /// Function to connect to the webserver and do the sign up
    ///
    /// This function takes the following parameters: first name, last name, email, password and confirm password, some of which are optionals
    public func doLogIn(parameters: UserDataLogIn, completion: @escaping (Result<Bool, LogInErrors>) -> Void) {
        apiClient.executeService(httpBody: getParameters(parameters).getData()) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(.unknownError(error)))
                } else if let response = response as? HTTPURLResponse,
                          (200..<300).contains(response.statusCode),
                          let data = data {
                    do {
                        let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                        
                        self.saveUserData(with: loginResponse.data)
                        
                        
                        completion(.success(loginResponse.isSuccess))
                        
                        //We store information locally, in the device's memory and ecrypt it.
                        
                        
                    } catch {
                        completion(.failure(.errorResponse))
                    }
                } else {
                    completion(.failure(.errorResponse))
                }
            }
        }
    }
    
    private func getParameters(_ parameters: UserDataLogIn) -> [String: String] {
        ["firstName": parameters.firstName ?? "",
         "lastName": parameters.lastName ?? "",
         "username": parameters.username,
         "password": parameters.password,
         "confirmPassword": parameters.confirmPassword ?? ""]
    }
    
    private func saveUserData(with data: LoginResponse.UserData) {
        let clientDefault = ClientDefaults.shared
        clientDefault.setUsername(with: data.username)
        clientDefault.setAccessToken(with: data.accessToken)
    }
}

// MARK: LOGIN SERVICE
struct LoginRequest: Encodable {
    let username: String
    let password: String
}

struct LoginResponse: Codable {
    let isSuccess: Bool
    let status: Int
    let message: String
    let data: UserData
    
    struct UserData: Codable {
        let username: String
        let accessToken: String
    }
}
