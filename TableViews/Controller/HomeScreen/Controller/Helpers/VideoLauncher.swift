//
//  VideoLauncher.swift
//  TableViews
//
//  Created by Mezut on 16/04/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit


class VideoLauncher {
    
    let padding: CGFloat = 50
    var singleViewController: SingleVideoController?
    
    
    func launchVideoPlayer(videoInformation: VideoData?, videoTrailer: VideoTrailer?){
        
        let videoView = CustomVideoControlView()
        videoView.videoData = videoInformation
        videoView.videoTrailer = videoTrailer
        videoView.translatesAutoresizingMaskIntoConstraints = false
        
        let view = UIView()
          view.backgroundColor = .black
          view.translatesAutoresizingMaskIntoConstraints = false
   
        
     if let keyWindow = UIApplication.shared.keyWindow {

        view.addSubview(videoView)
        keyWindow.addSubview(view)
        

        
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: keyWindow.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: keyWindow.trailingAnchor),
            view.topAnchor.constraint(equalTo: keyWindow.topAnchor),
            view.bottomAnchor.constraint(equalTo: keyWindow.bottomAnchor),
            
            videoView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 0),
            videoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            videoView.topAnchor.constraint(equalTo: view.topAnchor),
            videoView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
   }
    

}


    

    

