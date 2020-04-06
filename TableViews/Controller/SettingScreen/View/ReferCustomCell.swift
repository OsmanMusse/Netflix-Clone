//
//  ReferCustomCell.swift
//  TableViews
//
//  Created by Mezut on 05/04/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit

class ReferCustomCell: UICollectionViewCell {
    
    private let padding: CGFloat = 10
    
    var settingScreen: SettingScreenController?
    
    lazy var referToFriendBtn: CustomButton = {
       let button = CustomButton(type: .system)
        button.setTitle("Tell friend about Netflix.", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 22)
        button.setImage(#imageLiteral(resourceName: "message-icon").withRenderingMode(.alwaysOriginal), for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: padding + 10 , bottom: 0, right: 0)
        button.isUserInteractionEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let underLineView: UIView = {
       let view = UIView()
        view.backgroundColor = Colors.btnGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let textLabel: UITextView = {
        let label = UITextView()
        label.text = "Share this link so your friends can join the conversation about all your favourite TV programmes and films."
        label.textColor = UIColor.white
        label.isUserInteractionEnabled = false
        label.backgroundColor = .clear
        label.font = UIFont.boldSystemFont(ofSize: 15.5)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let termsConditionLabel: UITextView = {
       let label = UITextView()
        label.text = "Terms & Conditions"
        label.textColor = Colors.btnGray
        label.backgroundColor = .clear
        label.isUserInteractionEnabled = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let textFieldContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4.5
        view.layer.masksToBounds = true
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    lazy var textField: CustomTextField = {
        let textField = CustomTextField()
        textField.addTarget(self, action: #selector(handleCopyingLink), for: .touchDown)
        textField.attributedPlaceholder = NSAttributedString(string: "https//www.netflix.com/gb/n/4BYMZ23H-1", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13)])
        textField.backgroundColor = .black
        textField.delegate = self
        textField.padding = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
        
    }()
    
    lazy var copyLinkBtn: UIButton = {
       let button = UIButton(type: .system)
        button.setTitle("Copy link", for: .normal)
        button.addTarget(self, action: #selector(handleCopyingLink), for: .touchUpInside)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.cornerRadius = 3
        button.clipsToBounds = true
        button.backgroundColor = UIColor.white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    lazy var shareBtn: UIButton = {
       let button = UIButton(type: .custom)
        button.setTitle("Refer a friend", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 2
        button.clipsToBounds = true
        button.backgroundColor = .clear
        button.isHighlighted = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let shareIcon: UIImageView = {
       let image = UIImageView(image: #imageLiteral(resourceName: "share").withRenderingMode(.alwaysOriginal))
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var parentStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [referToFriendBtn,textLabel,termsConditionLabel])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 0
        stackView.alignment = UIStackView.Alignment.top
        stackView.layoutMargins = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    @objc func handleCopyingLink(textField: UITextField){
       settingScreen?.showAlert()
    }
    
    func setupLayout(){
        addSubview(parentStackView)
        addSubview(underLineView)
        addSubview(textFieldContainer)
        textFieldContainer.addSubview(textField)
        textFieldContainer.addSubview(copyLinkBtn)
        addSubview(shareBtn)
        addSubview(shareIcon)
        
        NSLayoutConstraint.activate([
            
             parentStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
             parentStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
             parentStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
             
             
             textLabel.widthAnchor.constraint(equalToConstant: self.frame.width),
             textLabel.heightAnchor.constraint(equalToConstant: 65),
             
             termsConditionLabel.widthAnchor.constraint(equalToConstant: self.frame.width),
             termsConditionLabel.heightAnchor.constraint(equalToConstant: 25),
             
             underLineView.widthAnchor.constraint(equalToConstant: 132),
             underLineView.heightAnchor.constraint(equalToConstant: 1),
             underLineView.leadingAnchor.constraint(equalTo: termsConditionLabel.leadingAnchor, constant: padding / 2),
             underLineView.topAnchor.constraint(equalTo: termsConditionLabel.bottomAnchor, constant: -1),
             
             textFieldContainer.widthAnchor.constraint(equalToConstant: self.frame.width - 2 * padding),
             textFieldContainer.heightAnchor.constraint(equalToConstant: 45),
             textFieldContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
             textFieldContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
             textFieldContainer.topAnchor.constraint(equalTo: termsConditionLabel.bottomAnchor, constant: 20),
             

            
             textField.leadingAnchor.constraint(equalTo: textFieldContainer.leadingAnchor),
             textField.trailingAnchor.constraint(equalTo: textFieldContainer.trailingAnchor),
             textField.topAnchor.constraint(equalTo: textFieldContainer.topAnchor),
             textField.bottomAnchor.constraint(equalTo: textFieldContainer.bottomAnchor),
             
         
             
             copyLinkBtn.trailingAnchor.constraint(equalTo: textFieldContainer.trailingAnchor, constant: -padding / 2),
             copyLinkBtn.centerYAnchor.constraint(equalTo: textFieldContainer.centerYAnchor),
             copyLinkBtn.topAnchor.constraint(equalTo: textFieldContainer.topAnchor, constant: padding / 2),
             copyLinkBtn.bottomAnchor.constraint(equalTo: textFieldContainer.bottomAnchor, constant: -padding / 2),
             copyLinkBtn.widthAnchor.constraint(equalToConstant: 82),
             copyLinkBtn.heightAnchor.constraint(equalToConstant: 80),
             
             shareBtn.widthAnchor.constraint(equalToConstant: self.textFieldContainer.frame.width),
             shareBtn.heightAnchor.constraint(equalToConstant: 40),
             shareBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
             shareBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
             shareBtn.topAnchor.constraint(equalTo: self.textFieldContainer.bottomAnchor, constant: 10),
             
             shareIcon.centerXAnchor.constraint(equalTo: shareBtn.centerXAnchor, constant: 75),
             shareIcon.centerYAnchor.constraint(equalTo: shareBtn.centerYAnchor, constant: -2),
             shareIcon.widthAnchor.constraint(equalToConstant: 20),
             shareIcon.heightAnchor.constraint(equalToConstant: 20),
             
             
            
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}



extension ReferCustomCell: UITextFieldDelegate {
    // Prevents the textfield from being editable
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
        
    }
}
