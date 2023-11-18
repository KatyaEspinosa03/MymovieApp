//
//  Helpers+TextFields.swift
//  MymovieApp
//
//  Created by Katya Miranda on 12/11/23.
//

import Foundation
import UIKit

extension UITextField {
    func setBorder(with color: Colors = .primaryColor) {
        self.layer.cornerRadius = 17
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(named: color.rawValue)?.cgColor
    }
    
    func setColorPlaceholder(with color: Colors = .Placeholder, placeholderText: String){
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor(named: color.rawValue)]
        self.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes as [NSAttributedString.Key : Any])
    }
}
