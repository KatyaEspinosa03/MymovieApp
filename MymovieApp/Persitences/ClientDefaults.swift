//
//  ClientDefaults.swift
//  MymovieApp
//
//  Created by Katya Miranda on 03/12/23.
//

import Foundation

final class ClientDefaults {
    
    // MARK: Initializers
    
    private init(){}
    
    static var shared: ClientDefaults {
        return ClientDefaults()
    }
    
    // MARK: Public Variables
    
    public var getUsername: String {
        return decryptInfo(with: userDefaults.string(forKey: "username"))
    }
    
    public var getAccessToken: String {
        return decryptInfo(with: userDefaults.string(forKey: "accessToken"))
    }
    
    // MARK: Private Variables
    
    private let userDefaults = UserDefaults.standard
    
    // MARK: Public methods.
    
    public func setUsername(with username: String){
        userDefaults.set(encryptInfo(with: username), forKey: "username")
    }
    
    public func setAccessToken(with accessToken: String){
        userDefaults.set(encryptInfo(with: accessToken), forKey: "accessToken")
    }
    
    // MARK: Private Methods.
    
    private func encryptInfo(with value: String) -> String? {
        let data = value.data(using: .utf8)
        let valueEncryted = data?.base64EncodedString()
        return valueEncryted
    }
    
    private func decryptInfo(with value: String?) -> String {
        guard let valueEncrypted = value,
              let data = Data(base64Encoded: valueEncrypted),
              let valueDecrypted = String(data: data, encoding: .utf8) else { return "" }
        return valueDecrypted
    }
}
