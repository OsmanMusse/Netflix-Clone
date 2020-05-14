//
//  SingleVideoHeader.swift
//  TableViews
//
//  Created by Mezut on 11/08/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit
import Hero
import Firebase
import Network


 var imageCache2 = [String: UIImage]()




class SingleVideoHeader: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    
    private let cellId = "cellId"
    var delegate: SingleVideoHeaderDelegate?
    
    var imageUrls = [VideoData]()
    var singleVideoController: SingleVideoController?
    
    // Constraints Reference
    var likeXAnchor: NSLayoutConstraint?
    var likeYAnchor: NSLayoutConstraint?
    var dislikeXAnchor: NSLayoutConstraint?
    var dislikeYAnchor: NSLayoutConstraint?
    var playBtnBottomAnchor: NSLayoutConstraint?
    
    var shouldAnimationGoDown: Bool?
    
    var backBtnState: Bool? {
        didSet{
            guard let isVisible = backBtnState else {return}
            goBackView.isHidden = isVisible
        }
    }
   
    
    
    
    var videoInformation: VideoData? {
        didSet{
            guard let imageURL = videoInformation?.videoURL else {return}
            videoImage.loadImage(urlString: imageURL)
            
            if let videoInfo = videoInformation {
                let crossBtn = videoOptionStackView.arrangedSubviews[0].subviews[0] as! UIButton
                let plusIcon = #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal)
                let tickIcon = #imageLiteral(resourceName: "interface").withRenderingMode(.alwaysOriginal)
                print(videoInfo.isAddedToMyList)
                crossBtn.setImage(videoInfo.isAddedToMyList == true ? tickIcon : plusIcon, for: .normal)
               checkIfVideoWasPlayed(videoInfo: videoInfo)
                
            }
        }
  }

    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize.width = 430
        scrollView.delegate = self
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var videoMenuStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [episodeBtn, trailersBtn, moreLikeThisBtn])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var episodeBtn: UIButton = {
       let button = UIButton(type: .system)
        button.setTitle("Episodes".uppercased(), for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.addTarget(self, action: #selector(handleEpisodeGrid), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var trailersBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Trailer & More".uppercased(), for: .normal)
        button.setTitleColor(Colors.btnGray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.addTarget(self, action: #selector(handleTrailerGrid), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var moreLikeThisBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("More Like This".uppercased(), for: .normal)
        button.setTitleColor(Colors.btnGray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.addTarget(self, action: #selector(handleMoreLikeThisGrid), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
 
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Random Text"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    var videoTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "New"
        label.font = UIFont(name: "SFUIDisplay-Bold", size: 17)
        label.textColor = UIColor(red: 71/255, green: 211/255, blue: 132/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var videoYearLabel: UILabel = {
        let label = UILabel()
        label.text = "2019"
        label.textColor = UIColor(red: 165/255, green: 156/255, blue: 154/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    var videoNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "15"
        label.textColor = UIColor(red: 165/255, green: 156/255, blue: 154/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var videoSeasonLabel: UILabel = {
        let label = UILabel()
        label.text = "1 Season"
        label.textColor = UIColor(red: 165/255, green: 156/255, blue: 154/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var videoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [videoTypeLabel, videoYearLabel, videoNumberLabel, videoSeasonLabel])
        stackView.distribution = .fill
        stackView.spacing = 21
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()


    var blurEffectView: UIVisualEffectView = {
        let osman = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurView = UIVisualEffectView(effect: osman)
        blurView.isHidden = false
        blurView.translatesAutoresizingMaskIntoConstraints = false
        return blurView
    }()

    lazy var blackCancelView: UIView = {

        let crossIcon = UIButton(type: .system)

        crossIcon.setImage(#imageLiteral(resourceName: "close").withRenderingMode(.alwaysOriginal), for: .normal)
        crossIcon.translatesAutoresizingMaskIntoConstraints = false
        crossIcon.addTarget(self, action: #selector(handleModalDismiss), for: .touchUpInside)

        var blackView = UIView()
        blackView.backgroundColor = .black
        blackView.layer.cornerRadius = 20
        blackView.alpha = 0.6
        blackView.translatesAutoresizingMaskIntoConstraints = false

        blackView.addSubview(crossIcon)

        crossIcon.centerYAnchor.constraint(equalTo: blackView.centerYAnchor).isActive = true
        crossIcon.centerXAnchor.constraint(equalTo: blackView.centerXAnchor).isActive = true
        
        return blackView
    }()
    
    
    lazy var backBtn: UIButton = {
        let backBtn = UIButton(type: .system)
        backBtn.setImage(UIImage(named: "left-arrow")?.withRenderingMode(.alwaysOriginal), for: .normal)
        backBtn.addTarget(self, action: #selector(handleBackBtn), for: .touchUpInside)
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        return backBtn
    }()
    lazy var goBackView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .black
        view.alpha = 0.6
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backBtn)
        
        backBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return view
    }()



    lazy var videoImage: CustomImageView = {
        var image = CustomImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var videoImageShadow: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var videoTitleShadow: UILabel = {
       let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    lazy var videoWatchTitle: UILabel = {
        let label = UILabel()
        label.text = "Watch \(videoSeasonLabel.text!) now"
        label.textColor = .white
        label.font = UIFont(name: "SFUIDisplay-Bold", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    lazy var playBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFUIDisplay-Bold", size: 16)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
        button.backgroundColor = UIColor(red: 228/255, green: 30/255, blue: 20/255, alpha: 1)
        button.setImage(#imageLiteral(resourceName: "play-button-white").withRenderingMode(.alwaysOriginal), for: .normal)
        button.layer.cornerRadius = 2
        button.addTarget(self, action: #selector(handlePlayBtn), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()


    var videoDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "An unassuming San Francisco chef becomes the latest in a long line of assassins chosen to keep the mystical Wu powers out of the wrong hands."
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .white
        label.numberOfLines = 4
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var videoCast: UILabel = {
       let label = UILabel()
        label.text = "Cast: Taylor Schilling, Kate Mulgrew, Laura Prepon"
        label.textColor = UIColor(red: 173/255, green: 173/255, blue: 173/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var videoCreator: UILabel = {
        let label = UILabel()
        label.text = "Creator: Jenji Kohan"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(red: 173/255, green: 173/255, blue: 173/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var videoOptionStackView: UIStackView = {
        
        let crossIcon = UIButton(type: .custom)
        crossIcon.addTarget(self, action: #selector(addToMyList(button:)), for: .touchUpInside)
        crossIcon.isSelected = false
        crossIcon.contentMode = .scaleAspectFit
        let myListLabel = UILabel()
        myListLabel.text = "My List"
        myListLabel.font = UIFont.systemFont(ofSize: 13)
        myListLabel.textColor =  UIColor(red: 173/255, green: 173/255, blue: 173/255, alpha: 1)
        let myListStackView = UIStackView(arrangedSubviews: [crossIcon,myListLabel])
        myListStackView.distribution = .fillProportionally
        myListStackView.axis = .vertical
        myListStackView.spacing = 6
        
        let rateIcon = UIButton(type: .system)
        rateIcon.isUserInteractionEnabled = true
        rateIcon.setImage(#imageLiteral(resourceName: "like").withRenderingMode(.alwaysOriginal), for: .normal)
        rateIcon.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleRating)))
        rateIcon.isUserInteractionEnabled = true
        rateIcon.contentMode = .scaleAspectFit
        let myRateLabel = UILabel()
        myRateLabel.text = "Rate"
        myRateLabel.font = UIFont.systemFont(ofSize: 13)
        myRateLabel.textColor =  UIColor(red: 173/255, green: 173/255, blue: 173/255, alpha: 1)
        let myRateStackView = UIStackView(arrangedSubviews: [rateIcon,myRateLabel])
        myRateStackView.distribution = .fillProportionally
        myRateStackView.axis = .vertical
        myRateStackView.spacing = 15
        
        
        let shareIcon = UIButton(type: .system)
        shareIcon.setImage(#imageLiteral(resourceName: "share").withRenderingMode(.alwaysOriginal), for: .normal)
        shareIcon.addTarget(self, action: #selector(handleSharing), for: .touchUpInside)
        shareIcon.contentMode = .scaleAspectFit
        let myShareLabel = UILabel()
        myShareLabel.text = "Share"
        myShareLabel.font = UIFont.systemFont(ofSize: 13)
        myShareLabel.textColor =  UIColor(red: 173/255, green: 173/255, blue: 173/255, alpha: 1)
        let myShareStackView = UIStackView(arrangedSubviews: [shareIcon,myShareLabel])
        myShareStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSharing)))
        myShareStackView.isUserInteractionEnabled = true
        myShareStackView.distribution = .fillProportionally
        myShareStackView.axis = .vertical
        myShareStackView.spacing = 15

    
        let parentStackView = UIStackView(arrangedSubviews: [myListStackView,myRateStackView,myShareStackView])
        parentStackView.distribution = .fill
        parentStackView.isUserInteractionEnabled = true
        parentStackView.spacing = 70
        parentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        return parentStackView
    }()
    
    
    var backgroundImage: UIImageView = {
      let image = UIImageView(image: #imageLiteral(resourceName: "jim-jefferies-poster"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var blackView: UIView = {
       let view = UIView()
        view.backgroundColor = Colors.mainblackColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var blueView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    

    var blackUnderline: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(red: 3/255, green: 3/255, blue: 3/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var redSliderEpisode:UIView = {
       let view =  UIView()
        view.backgroundColor = .red
        view.alpha = 1.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var redSliderTrailer:UIView = {
        let view =  UIView()
        view.backgroundColor = .red
        view.alpha = 0.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var redSliderMoreLikeThis:UIView = {
        let view =  UIView()
        view.backgroundColor = .red
        view.alpha = 0.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let progressTrack: Progress = {
       let progress = Progress()
        return progress
    }()
    
    lazy var progressView: UIProgressView = {
       let view = UIProgressView()
        view.backgroundColor = UIColor(red: 167/255, green: 167/255, blue: 167/255, alpha: 1)
        view.tintColor = UIColor.red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var videoRemainingLabel: UILabel = {
       let label = UILabel()
        label.text = "9m remaining"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var overlayAnimationView: UIView = {
        let view = UIView()
        view.alpha = 0
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleExitRating))
        view.isUserInteractionEnabled = false
        view.addGestureRecognizer(tapGesture)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    var likeContainerView: UIView = {
      let view = UIView()
      view.backgroundColor = Colors.chicagoColor.withAlphaComponent(0.85)
      view.layer.cornerRadius = 50
      view.layer.borderColor = UIColor.gray.cgColor
      view.layer.borderWidth = 0.5
      view.clipsToBounds = true
        
      view.alpha = 0
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
    }()
    
    var dislikeContainerView: UIView = {
       let view = UIView()
       view.backgroundColor = Colors.chicagoColor.withAlphaComponent(0.85)
       view.layer.cornerRadius = 50
       view.layer.borderColor = UIColor.gray.cgColor
       view.layer.borderWidth = 0.5
       view.clipsToBounds = true
       view.alpha = 0
       view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()
    
    var cancelContainerView:UIView = {
        let view = UIView()
        view.backgroundColor = Colors.chicagoColor.withAlphaComponent(0.9)
        view.layer.cornerRadius = 25
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 0.5
        view.clipsToBounds = true
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        videoImage.hero.id = "skyWalker"
        setupAnimationConstraints()
        createObservers()
        setupLayout()
    }
    
    
    
    
    func setupAnimationConstraints(){
        let likeButton = UIButton(type: .system)
        likeButton.setImage(#imageLiteral(resourceName: "like-btn-big").withRenderingMode(.alwaysOriginal), for: .normal)
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        
        let dislikeButton = UIButton(type: .system)
        dislikeButton.setImage(#imageLiteral(resourceName: "dislike-btn-big").withRenderingMode(.alwaysOriginal), for: .normal)
        dislikeButton.translatesAutoresizingMaskIntoConstraints = false
        
        let cancelBtn = UIImageView(image: #imageLiteral(resourceName: "close"))
        cancelBtn.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleExitRating))
        cancelBtn.addGestureRecognizer(tapGesture)
        cancelBtn.translatesAutoresizingMaskIntoConstraints = false
        
        likeContainerView.addSubview(likeButton)
        dislikeContainerView.addSubview(dislikeButton)
        cancelContainerView.addSubview(cancelBtn)
        
        likeButton.centerXAnchor.constraint(equalTo: likeContainerView.centerXAnchor).isActive = true
        likeButton.centerYAnchor.constraint(equalTo: likeContainerView.centerYAnchor).isActive = true
        dislikeButton.centerXAnchor.constraint(equalTo: dislikeContainerView.centerXAnchor).isActive = true
        dislikeButton.centerYAnchor.constraint(equalTo: dislikeContainerView.centerYAnchor, constant: 5).isActive = true
        cancelBtn.centerXAnchor.constraint(equalTo: cancelContainerView.centerXAnchor).isActive = true
        cancelBtn.centerYAnchor.constraint(equalTo: cancelContainerView.centerYAnchor).isActive = true
        cancelBtn.widthAnchor.constraint(equalToConstant: 20).isActive = true
        cancelBtn.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func createObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(handleExitRating), name: NotificationName.OverlayViewDidTap.name, object: nil)
    }
    
    func setupProgressViewConstraints(){
        
        
        playBtnBottomAnchor =  playBtn.bottomAnchor.constraint(equalTo: videoDescriptionLabel.topAnchor, constant: -35)
        playBtnBottomAnchor?.isActive = true
        
        blurEffectView.contentView.addSubview(progressView)
        blurEffectView.contentView.addSubview(videoRemainingLabel)
        blurEffectView.contentView.addSubview(overlayAnimationView)
        NSLayoutConstraint.activate([
          videoRemainingLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -13),
          videoRemainingLabel.topAnchor.constraint(equalTo: playBtn.bottomAnchor, constant: 14),
          
          progressView.topAnchor.constraint(equalTo: videoRemainingLabel.topAnchor, constant: 6),
          progressView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 13),
          progressView.trailingAnchor.constraint(equalTo: videoRemainingLabel.leadingAnchor, constant: -20),
          progressView.heightAnchor.constraint(equalToConstant: 4),
          
          overlayAnimationView.leadingAnchor.constraint(equalTo: blurEffectView.leadingAnchor),
          overlayAnimationView.topAnchor.constraint(equalTo: blurEffectView.topAnchor),
          overlayAnimationView.trailingAnchor.constraint(equalTo: blurEffectView.trailingAnchor),
          overlayAnimationView.heightAnchor.constraint(equalToConstant: 850)
          
          
          
        ])
    }
    
    
    
    func checkIfVideoWasPlayed(videoInfo: VideoData){
       guard let videoTitle = videoInfo.videoTitle else {return}
       Firebase.Database.isVideoResumable(videoTitle: videoTitle) { (videoResumeTime, videoFullTime) in
        self.setupProgressViewConstraints()
        self.playBtn.setTitle("Resume", for: .normal)
        let remainingTime = self.calculateVideoTime(videoResumeTime: videoResumeTime, videoFullTime: videoFullTime)
        self.videoRemainingLabel.text = "\(remainingTime) remaining"
        return
      }
        
        
        playBtn.setTitle("Play", for: .normal)
        playBtnBottomAnchor =  playBtn.bottomAnchor.constraint(equalTo: videoDescriptionLabel.topAnchor, constant: -10)
        playBtnBottomAnchor?.isActive = true
        
    }
    
    
    
    
    func calculateVideoTime(videoResumeTime: CGFloat, videoFullTime: CGFloat) -> String {
        let videoFullMinutes = Int(videoFullTime) / 60
        let videoResumeMinutes = Int(videoResumeTime) / 60
        
        progressTrack.totalUnitCount = Int64(videoFullMinutes)
       
        let remainingVideoMinutes = videoFullMinutes - videoResumeMinutes
        let progressCount = videoFullMinutes - remainingVideoMinutes
        
        progressTrack.completedUnitCount = Int64(progressCount)
                
        let completedFraction = Float(progressTrack.fractionCompleted)
        
        progressView.setProgress(completedFraction, animated: true)
        
        return "\(remainingVideoMinutes)m"
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }

    func setupLayout() {
          addSubview(backgroundImage)
          addSubview(blackView)
          addSubview(blurEffectView)
          addSubview(likeContainerView)
          addSubview(dislikeContainerView)
          addSubview(cancelContainerView)
          blurEffectView.contentView.addSubview(blueView)
          blueView.addSubview(scrollView)
          scrollView.addSubview(videoMenuStackView)
          blueView.addSubview(redSliderEpisode)
          blueView.addSubview(redSliderTrailer)
          blueView.addSubview(redSliderMoreLikeThis)
          blueView.addSubview(blackUnderline)
          blurEffectView.contentView.addSubview(videoOptionStackView)
          blurEffectView.contentView.addSubview(videoCreator)
          blurEffectView.contentView.addSubview(videoCast)
          blurEffectView.contentView.addSubview(videoCreator)
          blurEffectView.contentView.addSubview(videoCast)
          blurEffectView.contentView.addSubview(videoDescriptionLabel)
          blurEffectView.contentView.addSubview(playBtn)
          blurEffectView.contentView.addSubview(videoWatchTitle)
          blurEffectView.contentView.addSubview(videoStackView)
          blurEffectView.contentView.addSubview(videoImageShadow)
          blurEffectView.contentView.addSubview(videoTitleShadow)
          blurEffectView.contentView.addSubview(videoImage)
          blurEffectView.contentView.addSubview(blackCancelView)
          blurEffectView.contentView.addSubview(goBackView)
          likeXAnchor = likeContainerView.centerXAnchor.constraint(equalTo: videoOptionStackView.subviews[1].centerXAnchor)
          likeXAnchor?.isActive = true
          likeYAnchor = likeContainerView.centerYAnchor.constraint(equalTo: videoOptionStackView.subviews[1].centerYAnchor)
          likeYAnchor?.isActive = true
        
          dislikeXAnchor = dislikeContainerView.centerXAnchor.constraint(equalTo: videoOptionStackView.subviews[1].centerXAnchor)
          dislikeXAnchor?.isActive = true
          dislikeYAnchor = dislikeContainerView.centerYAnchor.constraint(equalTo: videoOptionStackView.subviews[1].centerYAnchor)
          dislikeYAnchor?.isActive = true
        
          playBtnBottomAnchor?.isActive = true

        
     
        NSLayoutConstraint.activate([
        
            likeContainerView.widthAnchor.constraint(equalToConstant: 100),
            likeContainerView.heightAnchor.constraint(equalToConstant: 100),

            
            dislikeContainerView.widthAnchor.constraint(equalToConstant: 100),
            dislikeContainerView.heightAnchor.constraint(equalToConstant: 100),

            cancelContainerView.centerXAnchor.constraint(equalTo: videoOptionStackView.subviews[1].centerXAnchor),
            cancelContainerView.centerYAnchor.constraint(equalTo: videoOptionStackView.subviews[1].centerYAnchor),
            cancelContainerView.widthAnchor.constraint(equalToConstant: 50),
            cancelContainerView.heightAnchor.constraint(equalToConstant: 50),
            
            
            
            backgroundImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundImage.topAnchor.constraint(equalTo: self.topAnchor),
            
            blackView.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor),
            blackView.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor),
            blackView.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor),
            blackView.heightAnchor.constraint(equalToConstant: 220),
        
            
            blurEffectView.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor),
            blurEffectView.topAnchor.constraint(equalTo: backgroundImage.topAnchor),
            
            blueView.leadingAnchor.constraint(equalTo: blurEffectView.leadingAnchor, constant: 0),
            blueView.trailingAnchor.constraint(equalTo: blurEffectView.trailingAnchor, constant: 0),
            blueView.bottomAnchor.constraint(equalTo: blurEffectView.bottomAnchor),
            blueView.heightAnchor.constraint(equalToConstant: 45),
            
            scrollView.topAnchor.constraint(equalTo: blueView.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: blueView.leadingAnchor, constant: 10),
            scrollView.widthAnchor.constraint(equalToConstant: blueView.frame.width),
            scrollView.trailingAnchor.constraint(equalTo: blueView.trailingAnchor, constant: -10),
            scrollView.heightAnchor.constraint(equalToConstant: 40),
            
            videoMenuStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),


           redSliderEpisode.widthAnchor.constraint(equalToConstant: 88),
           redSliderEpisode.heightAnchor.constraint(equalToConstant: 8),
           redSliderEpisode.topAnchor.constraint(equalTo: episodeBtn.topAnchor, constant: -10),
           redSliderEpisode.centerXAnchor.constraint(lessThanOrEqualTo: episodeBtn.centerXAnchor),
           
           redSliderTrailer.widthAnchor.constraint(equalToConstant: 146),
           redSliderTrailer.heightAnchor.constraint(equalToConstant: 8),
           redSliderTrailer.topAnchor.constraint(equalTo: trailersBtn.topAnchor, constant: -10),
           redSliderTrailer.centerXAnchor.constraint(lessThanOrEqualTo: trailersBtn.centerXAnchor),
           
           redSliderMoreLikeThis.widthAnchor.constraint(equalToConstant: 140),
           redSliderMoreLikeThis.heightAnchor.constraint(equalToConstant: 8),
           redSliderMoreLikeThis.topAnchor.constraint(equalTo: moreLikeThisBtn.topAnchor, constant: -10),
           redSliderMoreLikeThis.centerXAnchor.constraint(lessThanOrEqualTo: moreLikeThisBtn.centerXAnchor),
            
            blackUnderline.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            blackUnderline.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            blackUnderline.topAnchor.constraint(equalTo: blueView.topAnchor),
            blackUnderline.heightAnchor.constraint(equalToConstant: 3),
        
            videoOptionStackView.bottomAnchor.constraint(equalTo: blueView.bottomAnchor, constant: -70),
            videoOptionStackView.leadingAnchor.constraint(equalTo: blueView.leadingAnchor, constant: 30),
            
            
            videoCreator.bottomAnchor.constraint(equalTo: videoOptionStackView.topAnchor, constant: -15),
            videoCreator.centerXAnchor.constraint(equalTo: blurEffectView.centerXAnchor),
            videoCreator.leadingAnchor.constraint(equalTo: blurEffectView.leadingAnchor, constant: 13),
            videoCreator.trailingAnchor.constraint(equalTo: blurEffectView.trailingAnchor, constant: -13),
            
            videoCast.bottomAnchor.constraint(equalTo: videoCreator.bottomAnchor, constant: -20),
            videoCast.centerXAnchor.constraint(equalTo: blurEffectView.centerXAnchor),
            videoCast.leadingAnchor.constraint(equalTo: blurEffectView.leadingAnchor, constant: 13),
            videoCast.trailingAnchor.constraint(equalTo: blurEffectView.trailingAnchor, constant: -13),
            
            videoDescriptionLabel.bottomAnchor.constraint(equalTo: videoCast.bottomAnchor, constant: -30),
            videoDescriptionLabel.centerXAnchor.constraint(equalTo: blurEffectView.centerXAnchor),
            videoDescriptionLabel.leadingAnchor.constraint(equalTo: blurEffectView.leadingAnchor, constant: 13),
            videoDescriptionLabel.trailingAnchor.constraint(equalTo: blurEffectView.trailingAnchor, constant: -13),

            playBtn.centerXAnchor.constraint(equalTo: videoStackView.centerXAnchor),
            playBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 13),
            playBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -13),
            playBtn.heightAnchor.constraint(equalToConstant: 36),
                        
            videoWatchTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            videoWatchTitle.bottomAnchor.constraint(equalTo: playBtn.topAnchor, constant: -10),
            
            videoStackView.bottomAnchor.constraint(equalTo: videoWatchTitle.topAnchor, constant: -15),
            videoStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            videoImageShadow.bottomAnchor.constraint(equalTo: videoStackView.topAnchor, constant: -20),
            videoImageShadow.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            videoImageShadow.widthAnchor.constraint(equalToConstant: 150),
            videoImageShadow.heightAnchor.constraint(equalToConstant: 200),
            
            videoTitleShadow.centerXAnchor.constraint(equalTo: videoImageShadow.centerXAnchor),
            videoTitleShadow.centerYAnchor.constraint(equalTo: videoImageShadow.centerYAnchor),
            
            
            videoImage.topAnchor.constraint(equalTo: videoImageShadow.topAnchor),
            videoImage.leadingAnchor.constraint(equalTo: videoImageShadow.leadingAnchor),
            videoImage.trailingAnchor.constraint(equalTo: videoImageShadow.trailingAnchor),
            videoImage.bottomAnchor.constraint(equalTo: videoImageShadow.bottomAnchor),
            videoImage.widthAnchor.constraint(equalToConstant: 150),
            videoImage.heightAnchor.constraint(equalToConstant: 200),
            
            blurEffectView.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor),
            blurEffectView.topAnchor.constraint(equalTo: backgroundImage.topAnchor),

            blackCancelView.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor, constant: -10),
            blackCancelView.topAnchor.constraint(equalTo: backgroundImage.safeAreaLayoutGuide.topAnchor, constant: 10),
            blackCancelView.widthAnchor.constraint(equalToConstant: 40),
            blackCancelView.heightAnchor.constraint(equalToConstant: 40),
            
            goBackView.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor, constant: 10),
            goBackView.topAnchor.constraint(equalTo: backgroundImage.safeAreaLayoutGuide.topAnchor, constant: 10),
            goBackView.widthAnchor.constraint(equalToConstant: 40),
            goBackView.heightAnchor.constraint(equalToConstant: 40),
           
            ])
        

    }
    
    @objc func addToMyList(button: UIButton){
        button.isSelected = !button.isSelected
        
        if button.isSelected {
            button.setImage(#imageLiteral(resourceName: "interface").withRenderingMode(.alwaysOriginal), for: .normal)
            if let videoInfo = videoInformation {
                // Do Something
                delegate?.didTapLikeIcon()
                return
            }
            
        } else {
            button.setImage(#imageLiteral(resourceName: "plus"), for: .normal)
            if let videoInfo = videoInformation {
             // Do Something
                
            return 
          }
        }
        
        
    
    }
    
    
    @objc func handleRating(gesture: UITapGestureRecognizer){
        UIView.manipulateElements(viewsToShow: [likeContainerView,dislikeContainerView,cancelContainerView], enabledAlpha: true, enableHidden: nil)
        UIView.manipulateElements(viewsToShow: [overlayAnimationView], enabledAlpha: true, enableHidden: nil)
        videoOptionStackView.isHidden = true
     
        
        if shouldAnimationGoDown == false {
            likeXAnchor?.constant = -75
            likeYAnchor?.constant = 90
            dislikeXAnchor?.constant = 75
            dislikeYAnchor?.constant = 90
           
        } else {
           likeXAnchor?.constant = -75
           likeYAnchor?.constant = -90
           dislikeXAnchor?.constant = 75
           dislikeYAnchor?.constant = -90
        }
       
        
        singleVideoController?.disableScrolling()
        singleVideoController?.episodeHeader?.overlayAnimationView.isHidden = false
        singleVideoController?.trailerCustomCell?.overlayAnimationView.isHidden = false
        singleVideoController?.moreLikeThisCustomCell?.overlayAnimationView.isHidden = false
        self.overlayAnimationView.isUserInteractionEnabled = true
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
      
     }
    
    @objc func handleExitRating(notifcation: NSNotification?){
        UIView.manipulateElements(viewsToHide: [overlayAnimationView], enabledAlpha: true, enableHidden: nil)

        videoOptionStackView.isHidden = false
        
        likeXAnchor?.constant = 0
        likeYAnchor?.constant = 0
        dislikeXAnchor?.constant = 0
        dislikeYAnchor?.constant = 0
       
        singleVideoController?.enableScrolling()
        singleVideoController?.episodeHeader?.overlayAnimationView.isHidden = true
        singleVideoController?.trailerCustomCell?.overlayAnimationView.isHidden = true
        singleVideoController?.moreLikeThisCustomCell?.overlayAnimationView.isHidden = true
     
       UIView.animate(withDuration: 0.3) {
        UIView.manipulateElements(viewsToHide: [self.likeContainerView,self.dislikeContainerView,self.cancelContainerView], enabledAlpha: true, enableHidden: nil)
        self.layoutIfNeeded()
        
       }
        
    }
    
    
    @objc func handleSharing(){
        singleVideoController?.goToSharingController()
    }
    
    
 
    @objc func handlePlayBtn(){
        let videoLauncher = VideoLauncher()
        guard let videoInformationData = videoInformation else {return}
        if playBtn.titleLabel?.text == "Resume" {
            Firebase.Database.isVideoResumable(videoTitle: videoInformationData.videoTitle!) { (videoRemainingTime, videoFullTime) in
             videoInformationData.videoResumeTime = videoRemainingTime
             videoInformationData.videoFullTime = videoFullTime
                videoLauncher.launchVideoPlayer(videoInformation: videoInformationData, videoTrailer: nil)
             videoLauncher.singleViewController = self.singleVideoController
             let rotateRight = UIInterfaceOrientation.landscapeRight.rawValue
             UIDevice.current.setValue(rotateRight, forKey: "orientation")
            return
            }
        } else {
            videoLauncher.launchVideoPlayer(videoInformation: videoInformationData, videoTrailer: nil)
            videoLauncher.singleViewController = self.singleVideoController
            let rotateRight = UIInterfaceOrientation.landscapeRight.rawValue
            UIDevice.current.setValue(rotateRight, forKey: "orientation")
        }
        
    }
    
    @objc func handleModalDismiss(){
        singleVideoController?.dismiss(animated: false, completion: nil)
    }
    
    @objc func handleBackBtn(){
        self.singleVideoController?.dismiss(animated: false, completion: nil)
     }
    
    
    
    @objc func handleEpisodeGrid(){
        episodeBtn.setTitleColor(UIColor.white, for: .normal)
        trailersBtn.setTitleColor(Colors.btnGray, for: .normal)
        moreLikeThisBtn.setTitleColor(Colors.btnGray, for: .normal)
        
        UIView.animate(withDuration: 0.5) {
            self.redSliderEpisode.alpha = 1.0
            self.redSliderTrailer.alpha = 0.0
            self.redSliderMoreLikeThis.alpha = 0.0
        }
        
        self.delegate?.isEpisodeLayout()

    }
    
    
    @objc func handleTrailerGrid(){
         self.delegate?.isTrailerLayout()
       
        trailersBtn.setTitleColor(UIColor.white, for: .normal)
        episodeBtn.setTitleColor(Colors.btnGray, for: .normal)
        moreLikeThisBtn.setTitleColor(Colors.btnGray, for: .normal)
        
        UIView.animate(withDuration: 0.5) {
            self.redSliderTrailer.alpha = 1.0
            self.redSliderEpisode.alpha = 0.0
            self.redSliderMoreLikeThis.alpha = 0.0
        }
        
        
    }
    
    @objc func handleMoreLikeThisGrid(){
        delegate?.isMoreLikeThisLayout()
        moreLikeThisBtn.setTitleColor(UIColor.white, for: .normal)
        trailersBtn.setTitleColor(Colors.btnGray, for: .normal)
        episodeBtn.setTitleColor(Colors.btnGray, for: .normal)
        
        UIView.animate(withDuration: 0.5) {
            self.redSliderMoreLikeThis.alpha = 1.0
            self.redSliderEpisode.alpha = 0.0
            self.redSliderTrailer.alpha = 0.0
        }
    }
    
 
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
    





