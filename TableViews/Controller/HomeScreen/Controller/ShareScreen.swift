//
//  rndada.swift
//  TableViews
//
//  Created by Mezut on 27/04/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit
import Lottie



 class ShareScreen: UIViewController {
    
    private let cellID = "cellID"
    
    
    var singleVideoController: SingleVideoController?
    
    var stackViewXAnchor: NSLayoutConstraint?
    var stackViewYAnchor: NSLayoutConstraint?
    
    
    lazy var lottieAnimationView: AnimationView = {
        let view = AnimationView(name: "lf30_editor_th0eIw")
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    var copyAlertLabel: UILabel = {
       let label = UILabel()
        label.text = "Copied. Share away!"
        label.font = UIFont.boldSystemFont(ofSize: 21)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var shareToLabel: UILabel = {
       let label = UILabel()
        label.text = "Share to..."
        label.font = UIFont.boldSystemFont(ofSize: 23)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let whatsAppBtn: CustomButton = {
        let button = CustomButton(type: .custom)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        button.titleEdgeInsets =  UIEdgeInsets(top: 0, left: 35, bottom: 0, right: 0)
        button.setTitle(SharingApp.whatsApp.text, for: .normal)
        button.setImage(SharingApp.whatsApp.icon, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.adjustsImageWhenHighlighted = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let messageBtn: CustomButton = {
        let button = CustomButton(type: .custom)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        button.titleEdgeInsets =  UIEdgeInsets(top: 0, left: 35, bottom: 0, right: 0)
        button.setTitle(SharingApp.Messages.text, for: .normal)
        button.setImage(SharingApp.Messages.icon, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.adjustsImageWhenHighlighted = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let instagramBtn: CustomButton = {
        let button = CustomButton(type: .custom)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        button.titleEdgeInsets =  UIEdgeInsets(top: 0, left: 35, bottom: 0, right: 0)
        button.setTitle(SharingApp.InstagramStories.text, for: .normal)
        button.setImage(SharingApp.InstagramStories.icon, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.adjustsImageWhenHighlighted = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let messengerBtn: CustomButton = {
        let button = CustomButton(type: .custom)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        button.titleEdgeInsets =  UIEdgeInsets(top: 0, left: 35, bottom: 0, right: 0)
        button.setTitle(SharingApp.Messenger.text, for: .normal)
        button.setImage(SharingApp.Messenger.icon, for: .normal)
        button.contentMode = .scaleAspectFit
        button.setTitleColor(UIColor.white, for: .normal)
        button.adjustsImageWhenHighlighted = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let snapchatBtn: CustomButton = {
        let button = CustomButton(type: .custom)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        button.titleEdgeInsets =  UIEdgeInsets(top: 0, left: 35, bottom: 0, right: 0)
        button.setTitle(SharingApp.Snapchat.text, for: .normal)
        button.setImage(SharingApp.Snapchat.icon, for: .normal)
        button.contentMode = .scaleAspectFit
        button.adjustsImageWhenHighlighted = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let twitterBtn: CustomButton = {
        let button = CustomButton(type: .custom)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        button.titleEdgeInsets =  UIEdgeInsets(top: 0, left: 35, bottom: 0, right: 0)
        button.setTitle(SharingApp.Twitter.text, for: .normal)
        button.setImage(SharingApp.Twitter.icon, for: .normal)
        button.adjustsImageWhenHighlighted = false
        button.contentMode = .scaleAspectFit
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var copylinkBtn: CustomButton = {
        let button = CustomButton(type: .custom)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        button.titleEdgeInsets =  UIEdgeInsets(top: 0, left: 35, bottom: 0, right: 0)
        button.setTitleColor(Colors.lightGraylighter, for: .normal)
        button.setTitle(SharingApp.Copylink.text, for: .normal)
        button.setImage(SharingApp.Copylink.icon, for: .normal)
        button.addTarget(self, action: #selector(linkSharedAlert), for: .touchUpInside)
        button.isUserInteractionEnabled = true
        button.adjustsImageWhenHighlighted = false
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var moreOptionBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("More Options", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        button.setTitleColor(Colors.whiteGray, for: .normal)
        button.addTarget(self, action: #selector(showShareSheet), for: .touchUpInside)
        button.adjustsImageWhenHighlighted = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var cancelImageView:UIImageView = {
       let cancelImage = UIImageView(image: #imageLiteral(resourceName: "cancel-icon").withRenderingMode(.alwaysOriginal))
        cancelImage.translatesAutoresizingMaskIntoConstraints = false
        return cancelImage
    }()
    
    lazy var cancelBtn: UIView = {
       let view = UIView()
        view.layer.cornerRadius = 30
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleExitingScreen)))
        view.isUserInteractionEnabled = true
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [shareToLabel,whatsAppBtn, messageBtn,instagramBtn, messengerBtn,snapchatBtn,twitterBtn,copylinkBtn,moreOptionBtn])
        stack.spacing = 25
        stack.alpha = 0
        stack.axis = .vertical
        stack.alignment = .center
        
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        view.backgroundColor = .clear
    }

    
    func setupLayout(){
        view.addSubview(blurView)
        view.addSubview(lottieAnimationView)
        lottieAnimationView.addSubview(copyAlertLabel)
        blurView.contentView.addSubview(cancelBtn)
        cancelBtn.addSubview(cancelImageView)
        blurView.contentView.addSubview(stackView)
        
        stackViewXAnchor = stackView.centerXAnchor.constraint(equalTo: cancelBtn.centerXAnchor)
        stackViewXAnchor?.isActive = true
        stackViewYAnchor?.isActive = true
        NSLayoutConstraint.activate([
            
            
            blurView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            blurView.topAnchor.constraint(equalTo: self.view.topAnchor),
            blurView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            blurView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            lottieAnimationView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            lottieAnimationView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            lottieAnimationView.widthAnchor.constraint(equalToConstant: self.view.frame.width),
            lottieAnimationView.heightAnchor.constraint(equalToConstant: 125),
            
            copyAlertLabel.centerXAnchor.constraint(equalTo: self.lottieAnimationView.centerXAnchor),
            copyAlertLabel.topAnchor.constraint(equalTo: self.lottieAnimationView.bottomAnchor, constant: -23),
            
            cancelBtn.widthAnchor.constraint(equalToConstant: 60),
            cancelBtn.heightAnchor.constraint(equalToConstant: 60),
            cancelBtn.centerXAnchor.constraint(equalTo: blurView.centerXAnchor),
            cancelBtn.bottomAnchor.constraint(equalTo: blurView.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            cancelImageView.centerXAnchor.constraint(equalTo: cancelBtn.centerXAnchor),
            cancelImageView.centerYAnchor.constraint(equalTo: cancelBtn.centerYAnchor),
            

            stackView.widthAnchor.constraint(equalToConstant: self.view
                .frame.width - 50),
            stackView.bottomAnchor.constraint(equalTo: cancelBtn.topAnchor, constant: 225),
            stackView.heightAnchor.constraint(equalToConstant: 600),
            
            
        ])
    }
    

        @objc func showShareSheet(){
            if let videoTitle = singleVideoController?.video?.videoTitle {
                let shareSheetController = UIActivityViewController(activityItems: [videoTitle], applicationActivities: nil)
                self.dismiss(animated: false) {
                    self.singleVideoController?.present(shareSheetController, animated: true, completion: nil)
                }

            }
    }
    
    @objc func handleExitingScreen(){
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc func linkSharedAlert(){
        stackView.alpha = 0
        lottieAnimationView.alpha = 1
        lottieAnimationView.play()
        UIPasteboard.general.string = "https://www.netflix.com"
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.50) {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        UIView.animate(withDuration: 0.45) {
          self.stackView.alpha = 1
          self.stackView.transform = CGAffineTransform(translationX: 0, y: -245)
        }
    }

}


