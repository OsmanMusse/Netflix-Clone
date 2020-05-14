//
//  DataModel.swift
//  TableViews
//
//  Created by Mezut on 27/07/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit

class VideoCategory {
    var name: String?
    var videoData: [VideoData]?
}


class VideoData {
    var videoURL: String?
    var videoTitle: String?
    var videoResumeTime: CGFloat?
    var videoFullTime: CGFloat?
    var imageBorderColor: UIColor?
    var videocategory: String?
    var videoTrailer: [VideoTrailer]?
    var isAddedToMyList = false
    var videoKeyIdentifier:String?

    
    

    
    var cgColor: CGColor? {
        guard let videoBorderColor = imageBorderColor else {return nil}
        return videoBorderColor.cgColor
    }
}


public class VideoTrailer {
    var videoTitle: String?
    var videoURL: String?
    
    
}



