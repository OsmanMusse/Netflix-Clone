//
//  HelperMethods.swift
//  TableViews
//
//  Created by Mezut on 12/04/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit

enum AlertMessage: CaseIterable {
    case ProfileError
    
    
    var title: String {
        
      switch self {
       case .ProfileError: return "Profile Error"
     }
        
    }
    
    var message: String {
        switch self {
          case .ProfileError: return "Profile Operation Failed. Please try again later"
        }
    }
    
}



