//
//  VideoControlView.swift
//  TableViews
//
//  Created by Mezut on 17/04/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase
import Network



class CustomVideoControlView: UIView {
    

    var videoData: VideoData? {
        didSet{
            videoTitle.text = videoData?.videoTitle
            if let videoData = videoData {
              seekToSpecificTime(videoInfo: videoData)
            }
        }
    }
    
    var videoTrailer: VideoTrailer? {
        didSet{
            videoTitle.text = videoTrailer?.videoTitle

        }
    }
    
    var videoController = VideoController()
    let padding: CGFloat = 50
    var timer: Timer?
    var isPlaying = false
    var isControlsHidden = false
    var controlToggleAmount = 10
    var sliderTrack: Int?
    
    var videoPlayer: AVPlayer?
    var videoPlayerLayer: AVPlayerLayer?
    
  

    

    
  
    
    var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        indicator.startAnimating()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    lazy var rewindNumber: UILabel = {
       let label = UILabel()
        label.text = "\(controlToggleAmount)"
        label.font = UIFont(name: "Helvetica-Bold", size: 14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var forwardNumber: UILabel = {
       let label = UILabel()
        label.text = "\(controlToggleAmount)"
        label.font = UIFont(name: "Helvetica-Bold", size: 14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var rewindIconControl: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "rewind-icon").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(rewindPlayer), for: .touchUpInside)
        button.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var forwardIconControl: UIButton = {
          let button = UIButton(type: .custom)
          button.setImage(#imageLiteral(resourceName: "forward-icon").withRenderingMode(.alwaysOriginal), for: .normal)
          button.addTarget(self, action: #selector(forwardPlayer), for: .touchUpInside)
          button.contentMode = .scaleAspectFill
          button.translatesAutoresizingMaskIntoConstraints = false
          return button
    }()
    
    lazy var controlBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "pause-btn")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleVideoControl), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var rewindView: UIView = {
      let view = UIView()
        view.isHidden = true
        view.addSubview(rewindIconControl)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var forwardView: UIView = {
      let view = UIView()
        view.isHidden = true
        view.addSubview(forwardIconControl)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var controlStackView: UIStackView = {
        
       let stackView = UIStackView(arrangedSubviews: [rewindView, controlBtn, forwardView])
        controlBtn.alpha = 0
        layoutStackView()
        stackView.distribution = .fill
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var exitVideoIcon: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "close").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleExitMode), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var videoSlider: CustomSlider = {
       let slider = CustomSlider()

        slider.minimumTrackTintColor = .red
        slider.thumbTintColor = .clear
        slider.maximumTrackTintColor = Colors.btnLightGray
        slider.addTarget(self, action: #selector(handleSliderMovement), for: .valueChanged)
        slider.setThumbImage(UIImage(), for: .normal)
        slider.isUserInteractionEnabled = false
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    var videoTimerLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var videoContainerView: UIView = {
       let view = UIView()
        view.isUserInteractionEnabled = true
        view.isMultipleTouchEnabled = true
        view.isExclusiveTouch = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showControls))
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handleVideoPlayerZoom))
        view.addGestureRecognizer(tapGesture)
        view.addGestureRecognizer(pinchGesture)
        view.isMultipleTouchEnabled = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var imageThumbnail: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var liveVideoLabel: UILabel = {
       let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var videoTitle: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Helvetica", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let monitor = NWPathMonitor()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        
        checkForNetworkReachability()
        setupAVPlayer(videoURL: nil)
        avPlayerTasks()
        setupLayout()
        layoutStackView()
        resetTimer()
    }
    
    func checkForNetworkReachability(){
        
        monitor.pathUpdateHandler = { path in
            
            if path.status == .satisfied {
            } else {
                self.videoController.showAlertController()
            }
        }
    }
    
    func setupAVPlayer(videoURL: String?) {
        let url = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4")
        videoPlayer = AVPlayer(url: url!)
        videoPlayer?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)

         videoPlayerLayer = AVPlayerLayer(player: videoPlayer)
        videoPlayerLayer?.videoGravity = AVLayerVideoGravity.resizeAspect
        videoPlayerLayer?.frame = self.bounds
        videoPlayerLayer?.masksToBounds = true
        videoPlayer?.play()
    }
    

    
    func resetTimer(){
       timer?.invalidate()
       timer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(hideControls), userInfo: nil, repeats: false)
    }
    
    func seekToSpecificTime(videoInfo: VideoData){
        if let videoFullSeconds = videoInfo.videoFullTime, let videoRemainingSec = videoInfo.videoResumeTime {
          videoSlider.value  = Float(videoRemainingSec / videoFullSeconds)
          sliderTrack = 0
          let floatSeconds = Float(videoRemainingSec)
          let cmTime = CMTime(value: CMTimeValue(floatSeconds), timescale: 1)
            videoPlayer?.seek(to: cmTime) { (finishedSeek) in

           }
      }
        
    }
    

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?){
        if keyPath == "currentItem.loadedTimeRanges" {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.40) {
             UIView.animate(withDuration: 0.40, delay: 0, options: .curveEaseOut, animations: {
                
              self.activityIndicator.stopAnimating()
              self.rewindView.isHidden = false
              self.forwardView.isHidden = false
              self.controlBtn.alpha = 1
                
                if let videoDuration = self.videoPlayer?.currentItem?.duration  {
               let seconds = CMTimeGetSeconds(videoDuration)
                let secondsText = Int(seconds) % 60
                let minutesText = Int(seconds) / 60
                self.videoTimerLabel.text = "\(minutesText):\(secondsText)"
                if var sliderCount =  self.sliderTrack {
                    sliderCount += 1
                }
            }
                
         }, completion: nil)
   
       }
            
      }
        
    }

    func calculateAVPlayerStates(){
        if let currentItem = self.videoPlayer?.currentItem,  currentItem.status == AVPlayerItem.Status.readyToPlay{
        
        if currentItem.isPlaybackLikelyToKeepUp == true {
            activityIndicator.stopAnimating()
            controlBtn.alpha = 1
        }
        
        else if currentItem.isPlaybackBufferFull == true {

            if activityIndicator.isAnimating == false {
              controlBtn.alpha = 0
              activityIndicator.startAnimating()
            } else {
              controlBtn.alpha = 0
            }
        }
        
        else if currentItem.isPlaybackBufferEmpty == true {
            
           if activityIndicator.isAnimating == false {
             controlBtn.alpha = 0
             activityIndicator.startAnimating()
            
           }
           
           else {
            controlBtn.alpha = 0
             activityIndicator.startAnimating()
           }
            
        }
        
     }
        
  }
    
    func avPlayerTasks(){
        let cmInterval = CMTime(value: 1, timescale: 2)
        videoPlayer?.addPeriodicTimeObserver(forInterval: cmInterval, queue: DispatchQueue.main) { (progressTime) in
                        
         let seconds = CMTimeGetSeconds(progressTime)
         let actualSeconds = Int(seconds) % 60
         let actualMins = Int(seconds) / 60
         let durationString = String(format: "%02d", actualSeconds)
         
         self.videoSlider.thumbTintColor = .red
         self.videoSlider.isUserInteractionEnabled = true
        
         if actualMins >= 10 {
            self.liveVideoLabel.text = "\(actualMins):\(durationString)"
         } else {
            self.liveVideoLabel.text = "0\(actualMins):\(durationString)"
         }
            // Prevents The slider from being jumpy
            guard self.videoSlider.isTracking == false else {return}
            
            if let sliderTrackRef = self.sliderTrack,  sliderTrackRef >= 0 {
                self.updateSlider(with: progressTime)
            }
            
            self.calculateAVPlayerStates()
       }
        
    }
    
    private func updateSlider(with time: CMTime) {
        let currrentSeconds = CMTimeGetSeconds(time)
        if let videoPlayerDuration = videoPlayer?.currentItem?.duration {
            let fullTime = CMTimeGetSeconds(videoPlayerDuration)
            self.videoSlider.value = Float(currrentSeconds / fullTime)
        }
        
    }
    
    
    func setupLayout(){
        let videoControllerView = videoController.view!
        videoControllerView.translatesAutoresizingMaskIntoConstraints = false
        
        if let videoPlayerLayer = videoPlayerLayer {
            self.layer.addSublayer(videoPlayerLayer)
        }
        
        self.addSubview(videoControllerView)
        
        addSubview(videoContainerView)
        videoContainerView.addSubview(controlStackView)
        controlStackView.addSubview(activityIndicator)
        videoContainerView.addSubview(exitVideoIcon)
        videoContainerView.addSubview(videoTimerLabel)
        videoContainerView.addSubview(videoSlider)
        videoContainerView.addSubview(liveVideoLabel)
        videoContainerView.addSubview(videoTitle)
        
        
        NSLayoutConstraint.activate([
            videoControllerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            videoControllerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            videoControllerView.topAnchor.constraint(equalTo: self.topAnchor),
            videoControllerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            videoContainerView.leadingAnchor.constraint(equalTo: videoControllerView.leadingAnchor, constant:  0),
            videoContainerView.trailingAnchor.constraint(equalTo: videoControllerView.trailingAnchor, constant: 0),
            videoContainerView.topAnchor.constraint(equalTo: videoControllerView.topAnchor),
            videoContainerView.bottomAnchor.constraint(equalTo: videoControllerView.bottomAnchor),
            
            controlStackView.centerXAnchor.constraint(equalTo: videoContainerView.centerXAnchor),
            controlStackView.centerYAnchor.constraint(equalTo: videoContainerView.centerYAnchor),
            controlStackView.widthAnchor.constraint(equalToConstant: 480),
            controlStackView.heightAnchor.constraint(equalToConstant: 45),
            
            activityIndicator.centerXAnchor.constraint(equalTo: controlStackView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: controlStackView.centerYAnchor),
            
            exitVideoIcon.trailingAnchor.constraint(equalTo: videoContainerView.trailingAnchor, constant: -padding),
            exitVideoIcon.topAnchor.constraint(equalTo: videoContainerView.topAnchor, constant: 20 * 2),
            
            videoTimerLabel.trailingAnchor.constraint(equalTo: videoContainerView.trailingAnchor, constant:-40),
            videoTimerLabel.bottomAnchor.constraint(equalTo: videoContainerView.bottomAnchor, constant: -45),
            
            
            videoSlider.leadingAnchor.constraint(equalTo: videoContainerView.leadingAnchor, constant: padding),
            videoSlider.trailingAnchor.constraint(equalTo: videoTimerLabel.leadingAnchor, constant: -20),
            videoSlider.bottomAnchor.constraint(equalTo: videoContainerView.bottomAnchor, constant: -20 * 2),
            videoSlider.heightAnchor.constraint(equalToConstant: 30),
            
            liveVideoLabel.bottomAnchor.constraint(equalTo: videoSlider.topAnchor),
            liveVideoLabel.leadingAnchor.constraint(equalTo: videoSlider.leadingAnchor, constant: 20),
            
            videoTitle.topAnchor.constraint(equalTo: videoContainerView.topAnchor, constant: 20),
            videoTitle.centerXAnchor.constraint(equalTo: videoContainerView.centerXAnchor),
  
        ])
    }
    
    
    func layoutStackView(){
        
      rewindView.addSubview(rewindNumber)
      forwardView.addSubview(forwardNumber)
        
    NSLayoutConstraint.activate([
        rewindView.widthAnchor.constraint(equalToConstant: 50),
        rewindView.heightAnchor.constraint(equalToConstant: 55),
        rewindIconControl.centerXAnchor.constraint(equalTo: rewindView.centerXAnchor),
        rewindIconControl.centerYAnchor.constraint(equalTo: rewindView.centerYAnchor),
        
        forwardView.widthAnchor.constraint(equalToConstant: 50),
        forwardView.heightAnchor.constraint(equalToConstant: 55),
        forwardIconControl.centerXAnchor.constraint(equalTo: forwardView.centerXAnchor),
        forwardIconControl.centerYAnchor.constraint(equalTo: forwardView.centerYAnchor),
    
        rewindNumber.centerXAnchor.constraint(equalTo: rewindView.centerXAnchor),
        rewindNumber.centerYAnchor.constraint(equalTo: rewindView.centerYAnchor, constant: 3),
        
        forwardNumber.centerXAnchor.constraint(equalTo: forwardView.centerXAnchor),
        forwardNumber.centerYAnchor.constraint(equalTo: forwardView.centerYAnchor, constant: 3),
        
        ])
        
    
           
    }
    
    @objc func handleSliderMovement(){
        if let videoDuration = videoPlayer?.currentItem?.duration {
          let actualDuration = CMTimeGetSeconds(videoDuration)
          let value = Float64(videoSlider.value) * actualDuration
          
          // Prevents the uislider thumb from being dragged when video player is not yet in a playable state
          if (value.isNaN || value.isInfinite) {
             return
          }
            
          let seekTime = CMTime(value: Int64(value), timescale: 1)
            
            videoPlayer?.seek(to: seekTime) { (completedSeek) in
            // Do something if the seek operation is interupted -- ActivityIndicator
                
         }
          
       }
    }
    

    @objc func handleVideoControl(){
        if isPlaying == false {
            controlBtn.setImage(#imageLiteral(resourceName: "play-button-2").withRenderingMode(.alwaysOriginal), for: .normal)
            videoPlayer?.pause()
            isPlaying = true
        } else {
            controlBtn.setImage(#imageLiteral(resourceName: "pause-btn").withRenderingMode(.alwaysOriginal), for: .normal)
            videoPlayer?.play()
            isPlaying = false
        }
        
    }
    

  @objc func handleExitMode(){
    if let videoCurrentTime = videoPlayer?.currentTime() {
        let seconds = CMTimeGetSeconds(videoCurrentTime)
        guard let videoPlayerDuration = videoPlayer?.currentItem?.duration else {return}
        let fullVideoSeconds = CMTimeGetSeconds(videoPlayerDuration)
        
        if let videoPlayerItem = videoPlayer?.currentItem {
            
         formatedCMTime(videoItem: videoPlayerItem) { (videoInfo) in
          Firebase.Database.getActiveUser { (profileModel) in
           if let videoInformation = self.videoData {
            Firebase.Database.validateVideoTimeChange(activeUser: profileModel, videoTime: CGFloat(seconds), videoData: videoInformation, fullVideoSeconds: CGFloat(fullVideoSeconds))
            
              }
            }
                   
          }
       }
    }

   
      if let keyWindow = UIApplication.shared.keyWindow {
        if let presentView = keyWindow.subviews.last {
            videoPlayer?.pause()
          presentView.removeFromSuperview()
       }
        
      let portrait = UIInterfaceOrientation.portrait.rawValue
      UIDevice.current.setValue(portrait, forKey: "orientation")
      }
         
  }
    
    @objc func showControls(){
       let viewsToAnimate = [controlStackView,videoTitle,videoSlider,videoTimerLabel,liveVideoLabel,exitVideoIcon]
       if self.isControlsHidden == false {
        hideControls()
        return
    }
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
          UIView.manipulateElements(viewsToShow: viewsToAnimate, enabledAlpha: true, enableHidden: nil)
           self.resetTimer()
           self.isControlsHidden = false
           self.videoContainerView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        }, completion: nil)
    }
    
    @objc func hideControls() {
        let viewsToAnimate = [controlStackView,videoTitle,videoSlider,videoTimerLabel,liveVideoLabel,exitVideoIcon]
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
         UIView.manipulateElements(viewsToHide: viewsToAnimate, enabledAlpha: true, enableHidden: nil)
         self.isControlsHidden = true
         self.videoContainerView.backgroundColor = .clear
        }, completion: nil)
    }
    
    @objc func handleVideoPlayerZoom(pinchGesture: UIPinchGestureRecognizer){
        // Handling Zooming in and out of video
        if pinchGesture.state == .changed {
         if videoPlayerLayer?.videoGravity == AVLayerVideoGravity.resizeAspect {
                videoPlayerLayer?.videoGravity = .resizeAspectFill
                pinchGesture.state = .ended
            } else {
                videoPlayerLayer?.videoGravity = .resizeAspect
                pinchGesture.state = .ended
            }
            
        }
    }
  
    func calculateSeekTime(advancedBy:Double){
        if let videoPlayerItem = videoPlayer?.currentItem{
          let playerCurrentTime = videoPlayerItem.currentTime()
         let currentTimeInSecondsMinus10 =  CMTimeGetSeconds(playerCurrentTime).advanced(by: advancedBy)
         let seekTime = CMTime(value: CMTimeValue(currentTimeInSecondsMinus10), timescale: 1)
            videoPlayer?.seek(to: seekTime) { (completedSeek) in
       }
            
     }
   }
    
    @objc func rewindPlayer(){
        let radianToDegress = CGFloat(-65 * Double.pi/180)
        UIView.animate(withDuration: 0.7, animations: {
            self.rewindNumber.transform = CGAffineTransform(translationX: -60, y: 0)
            self.controlToggleAmount += 10
            self.rewindNumber.text = "-\(self.controlToggleAmount)"
        }) { (finished) in
            self.rewindNumber.transform = .identity
            self.rewindNumber.text = "\(10)"
        } // Finished Animation
        
        UIView.animate(withDuration: 0.2, animations: {
            self.rewindIconControl.transform = CGAffineTransform(rotationAngle: radianToDegress)
        }) { (finished) in
            self.rewindIconControl.transform = .identity
        }
        
        // Goes backwards in time by 10 seconds
       calculateSeekTime(advancedBy: -10)
    }
    
    @objc func forwardPlayer(){
      let radianToDegress = CGFloat(65 * Double.pi/180)
           UIView.animate(withDuration: 0.7, animations: {
               self.forwardNumber.transform = CGAffineTransform(translationX: 60, y: 0)
               self.controlToggleAmount += 10
               self.forwardNumber.text = "-\(self.controlToggleAmount)"
           }) { (finished) in
               self.forwardNumber.transform = .identity
               self.forwardNumber.text = "\(10)"
           } // Finished Animation
           
           UIView.animate(withDuration: 0.2, animations: {
               self.forwardIconControl.transform = CGAffineTransform(rotationAngle: radianToDegress)
           }) { (finished) in
               self.forwardIconControl.transform = .identity
           }
        
         //Goes forward in time by 10 seconds
        calculateSeekTime(advancedBy: +10)
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        // Makes sure the videoPlayer is visibile with the layer bounds
        videoPlayerLayer?.frame = self.bounds
    }
    
    
    
    required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    
       
}

