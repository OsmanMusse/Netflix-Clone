//
//  CustomTextField.swift
//  NetflixApp
//
//  Created by Mezut on 17/07/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    
    var padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    
    override func  textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
