//
//  Notifications.swift
//  TableViews
//
//  Created by Mezut on 03/05/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit


enum NotificationName: CaseIterable{
  case OverlayViewDidTap
  case videoOptionOverlayDidTap
  case trailerOverlayDidTap
  case internetConnectionValid
  case internetConnectionInvalid
}




extension NotificationName {
    
    var name: Notification.Name {
        switch self {
        case .OverlayViewDidTap:        return Notification.Name(rawValue:  "OverlayViewDidTap")
        case .videoOptionOverlayDidTap: return Notification.Name(rawValue:  "videoOptionOverlayDidTap")
        case .trailerOverlayDidTap:     return Notification.Name(rawValue:  "trailerOverlayDidTap")
        case .internetConnectionInvalid: return Notification.Name(rawValue: "internetConnectionInvalid")
        case .internetConnectionValid : return Notification.Name(rawValue:  "internetConnectionValid")
        }
    }
    
}
