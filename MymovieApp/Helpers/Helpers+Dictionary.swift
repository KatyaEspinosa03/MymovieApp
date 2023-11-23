//
//  Helpers+Dictionary.swift
//  MymovieApp
//
//  Created by Katya Miranda on 19/11/23.
//

import Foundation


extension [String : String ]{
    func getData() ->  Data? {
        try! JSONSerialization.data(withJSONObject: self)
    }
}
