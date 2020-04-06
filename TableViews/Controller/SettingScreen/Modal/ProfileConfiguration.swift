//
//  ProfileConfiguration.swift
//  TableViews
//
//  Created by Mezut on 06/04/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit

enum ProfileConfigurationOptions: CaseIterable {
    case MyList
    case AppSettings
    case Account
    case Help
    
}


extension ProfileConfigurationOptions {
    var text: String {
        switch self {
        case .MyList:      return "My List"
        case .AppSettings:  return "App Settings"
        case .Account:     return "Account"
        case .Help:        return "Help"
        }

    }
        
        var icon: UIImage {
            switch self {
            case  .MyList: return #imageLiteral(resourceName: "tick-gray")
            case .AppSettings: return #imageLiteral(resourceName: "settings-icon")
            case .Account: return #imageLiteral(resourceName: "account-icon")
            case .Help: return #imageLiteral(resourceName: "help-icon")
            }
        }
    }




