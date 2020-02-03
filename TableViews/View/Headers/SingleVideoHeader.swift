//
//  SingleVideoHeader.swift
//  TableViews
//
//  Created by Mezut on 11/08/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit
import Hero


 var imageCache2 = [String: UIImage]()

class SingleVideoHeader: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var delegate: SingleVideoHeaderDelegate?
    
    var imageUrls = [VideoData]()
   
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize.width = 430
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
    
    
    let cellId = "cellId"
    

    
    var singleVideoController: SingleVideoController?
    
    var videoInformation: VideoData? {
        didSet{
            
        

            

            guard let videoUrl = videoInformation?.videoName else {return}
            
            
            if let cachedImage = imageCache2[videoUrl] {
                self.videoImage.image = cachedImage
                return
            }
            
            
            
            guard let url = URL(string: videoUrl) else {return}
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                guard let dataImage = data else {return}
                guard let videoImages = UIImage(data: dataImage) else {return}
                
                imageCache2[url.absoluteString] = videoImages

                DispatchQueue.main.sync {
                    self.videoImage.image = videoImages
                }

            }.resume()
        }
    }
    

    
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
        blackView.backgroundColor = .black
        blackView.alpha = 0.7
        blackView.isOpaque = true
        blackView.translatesAutoresizingMaskIntoConstraints = false

        blackView.addSubview(crossIcon)

        crossIcon.centerYAnchor.constraint(equalTo: blackView.centerYAnchor).isActive = true
        crossIcon.centerXAnchor.constraint(equalTo: blackView.centerXAnchor).isActive = true

        return blackView
    }()



    lazy var videoImage: UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = false
        image.clipsToBounds = true
        image.layer.shadowColor = UIColor.black.cgColor
        image.layer.shadowOpacity = 1
        image.layer.shadowOffset = .zero
        image.layer.shadowRadius = 5
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    lazy var videoWatchTitle: UILabel = {
        let label = UILabel()
        label.text = "Watch \(videoSeasonLabel.text!) now"
        label.textColor = .white
        label.font = UIFont(name: "SFUIDisplay-Bold", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    var playBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Play", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFUIDisplay-Bold", size: 16)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
        button.setImage(#imageLiteral(resourceName: "play-button-white").withRenderingMode(.alwaysOriginal), for: .normal)
        button.backgroundColor = UIColor(red: 228/255, green: 30/255, blue: 20/255, alpha: 1)
        button.layer.cornerRadius = 2
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
        
        let tickIcon = UIButton(type: .system)
        tickIcon.setImage(#imageLiteral(resourceName: "tick").withRenderingMode(.alwaysOriginal), for: .normal)
        tickIcon.contentMode = .scaleAspectFit
        let myListLabel = UILabel()
        myListLabel.text = "My List"
        myListLabel.font = UIFont.systemFont(ofSize: 13)
        myListLabel.textColor =  UIColor(red: 173/255, green: 173/255, blue: 173/255, alpha: 1)
        let myListStackView = UIStackView(arrangedSubviews: [tickIcon,myListLabel])
        myListStackView.distribution = .fillProportionally
        myListStackView.axis = .vertical
        myListStackView.spacing = 19
        
        let rateIcon = UIButton(type: .system)
        rateIcon.setImage(#imageLiteral(resourceName: "like").withRenderingMode(.alwaysOriginal), for: .normal)
        rateIcon.contentMode = .scaleAspectFit
        let myRateLabel = UILabel()
        myRateLabel.text = "Rate"
        myRateLabel.font = UIFont.systemFont(ofSize: 13)
        myRateLabel.textColor =  UIColor(red: 173/255, green: 173/255, blue: 173/255, alpha: 1)
        let myRateStackView = UIStackView(arrangedSubviews: [rateIcon,myRateLabel])
        myRateStackView.distribution = .fillProportionally
        myRateStackView.axis = .vertical
        myRateStackView.spacing = 18
        
        
        let shareIcon = UIButton(type: .system)
        shareIcon.setImage(#imageLiteral(resourceName: "share").withRenderingMode(.alwaysOriginal), for: .normal)
        shareIcon.contentMode = .scaleAspectFit
        let myShareLabel = UILabel()
        myShareLabel.text = "Share"
        myShareLabel.font = UIFont.systemFont(ofSize: 13)
        myShareLabel.textColor =  UIColor(red: 173/255, green: 173/255, blue: 173/255, alpha: 1)
        let myShareStackView = UIStackView(arrangedSubviews: [shareIcon,myShareLabel])
        myShareStackView.distribution = .fillProportionally
        myShareStackView.axis = .vertical
        myShareStackView.spacing = 14

    
         let parentStackView = UIStackView(arrangedSubviews: [myListStackView,myRateStackView,myShareStackView])
        parentStackView.distribution = .fill
        parentStackView.spacing = 58
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
    

    
    
    
    


    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        videoImage.hero.id = "skyWalker"
        videoImage.hero.modifiers = [.fade, .translate(CGPoint(x: 0, y: 600))]

        

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    


   

    func setupLayout() {
          addSubview(backgroundImage)
          addSubview(blackView)
          addSubview(blurEffectView)
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
          blurEffectView.contentView.addSubview(videoImage)
          blurEffectView.contentView.addSubview(blackCancelView)
       
        
        


        NSLayoutConstraint.activate([
            
        
            
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
            playBtn.bottomAnchor.constraint(equalTo: videoDescriptionLabel.topAnchor, constant: -15),
            playBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 13),
            playBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -13),
            playBtn.heightAnchor.constraint(equalToConstant: 36),
            
            videoWatchTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            videoWatchTitle.bottomAnchor.constraint(equalTo: playBtn.topAnchor, constant: -10),
            
            videoStackView.bottomAnchor.constraint(equalTo: videoWatchTitle.topAnchor, constant: -15),
            videoStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            
            videoImage.bottomAnchor.constraint(equalTo: videoStackView.topAnchor, constant: -20),
            videoImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            videoImage.widthAnchor.constraint(equalToConstant: 180),
            videoImage.heightAnchor.constraint(equalToConstant: 180),
            
            
            blurEffectView.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor),
            blurEffectView.topAnchor.constraint(equalTo: backgroundImage.topAnchor),

            blackCancelView.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor, constant: -10),
            blackCancelView.topAnchor.constraint(equalTo: backgroundImage.safeAreaLayoutGuide.topAnchor, constant: 10),
            blackCancelView.widthAnchor.constraint(equalToConstant: 40),
            blackCancelView.heightAnchor.constraint(equalToConstant: 40),
        


            ])
    }
    
    
 
    
    @objc func handleModalDismiss(){
        singleVideoController?.goToHomeScreen()
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

}
    





