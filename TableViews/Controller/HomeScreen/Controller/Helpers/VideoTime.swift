//
//  VideoTime.swift
//  TableViews
//
//  Created by Mezut on 21/04/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import Foundation


struct VideoTime {
    var videoMinutes: Int
    var videoSeconds: Int
    
    var formattedMinutesString: String? {
        if videoMinutes < 10 {
            return "0\(videoMinutes)"
        }
        return "\(videoMinutes)"
    }
    
    var formattedSecondsString: String? {
        if videoSeconds < 10 {
            return "0\(videoSeconds)"
        }
        return "\(videoSeconds)"
    }
}
