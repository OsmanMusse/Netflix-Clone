//
//  ShareApp.swift
//  TableViews
//
//  Created by Mezut on 27/04/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit

enum SharingApp {
    case whatsApp
    case Messages
    case InstagramStories
    case Messenger
    case Snapchat
    case Twitter
    case Copylink
}



extension SharingApp {
    
    var text: String {
      switch self {
       case .whatsApp: return "WhatsApp"
       case .Messages: return "Messages"
       case .InstagramStories: return "Instagram Stories"
       case .Messenger: return "Messenger"
       case .Snapchat: return "Snapchat"
       case .Twitter: return "Twitter"
       case .Copylink: return "Copy link"
     }
 }
    
    var icon: UIImage {
        switch self {
        case .whatsApp: return #imageLiteral(resourceName: "whatsapp-icon").withRenderingMode(.alwaysOriginal)
        case .Messages: return #imageLiteral(resourceName: "Messages-icon").withRenderingMode(.alwaysOriginal)
        case .InstagramStories: return #imageLiteral(resourceName: "instagram-icon").withRenderingMode(.alwaysOriginal)
        case .Messenger: return #imageLiteral(resourceName: "Messenger-icon").withRenderingMode(.alwaysOriginal)
        case .Snapchat: return #imageLiteral(resourceName: "snapchat-icon").withRenderingMode(.alwaysOriginal)
        case .Twitter: return #imageLiteral(resourceName: "Twitter-icon").withRenderingMode(.alwaysOriginal)
        case .Copylink: return #imageLiteral(resourceName: "CopyLink-icon").withRenderingMode(.alwaysOriginal)
        }
    }
    
}


