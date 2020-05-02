//
//  ProfileCustomCell.swift
//  TableViews
//
//  Created by Mezut on 19/03/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit

// Hold Reference to the cached images that are already in the app for reuse
var profileCachedImages =  [String: UIImage]()

class ProfileCustomCell: UICollectionViewCell {
    
    var profileNameBottomConstraint: NSLayoutConstraint?
    
    var profileSelectorScreen: ProfileSelector?
    
    var profileInformation: ProfileModel? {
        didSet{
            
         
            
            guard let avatorImage = profileInformation?.profileImage else {return}
            
            if let cachedImage = profileCachedImages[avatorImage] {
                self.profileName.text = self.profileInformation?.profileName
                self.profileImage.image = cachedImage
                return
            }
            
            guard let url = URL(string: avatorImage) else {return}
            
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                if let err = err {
                    print("ISSUE WITH NETWORK", err)
                }
                
                if url.absoluteString != self.profileInformation?.profileImage{
                    return
                }
                
                guard let imageData = data else {return}
                
                guard let imageConstruction = UIImage(data: imageData) else {return}
                
                profileCachedImages[url.absoluteString] = imageConstruction
            
                
                
                DispatchQueue.main.async {
                    self.profileName.text = self.profileInformation?.profileName
                    self.profileImage.image = imageConstruction
                }
                
            }.resume()
        }
    }
    
    
    var profileImage: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var profileAddIcon: UIImageView = {
       let image = UIImageView(image: #imageLiteral(resourceName: "add-icon"))
        image.isHidden = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var profileName: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var shadowView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = .black
        view.alpha = 0.6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var editIcon: UIImageView = {
       let image = UIImageView(image: #imageLiteral(resourceName: "edit-icon"))
        image.isHidden = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupDefaultCell(){
   
        
        self.profileImage.isHidden = false
        self.profileAddIcon.isHidden = true
        self.profileImage.layer.cornerRadius = 4.5
        self.profileImage.layer.masksToBounds = true
        self.profileNameBottomConstraint?.constant = 10
        self.backgroundColor = UIColor.clear
        self.layer.borderColor =  UIColor.clear.cgColor
        self.layer.cornerRadius = 4.5
    }
    
    func setupProfileCell(){
        self.profileImage.hero.id = "skyWalker"
        self.profileName.text = "Add Profile"
        self.profileImage.isHidden = true
        self.editIcon.isHidden = true
        self.shadowView.isHidden = true
        self.profileAddIcon.isHidden = false
        self.profileNameBottomConstraint?.constant = 19
        
        self.frame.origin.x = self.frame.origin.x + 22
        self.backgroundColor = UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1)
        self.layer.borderColor =  UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1).cgColor
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 4.5
    }
    
    
    
    func setupLayout(){
        addSubview(profileImage)
        addSubview(profileAddIcon)
        addSubview(profileName)
        addSubview(shadowView)
        addSubview(editIcon)
        
        profileNameBottomConstraint =  profileName.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10)
        profileNameBottomConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
              profileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
              profileImage.topAnchor.constraint(equalTo: self.topAnchor),
              profileImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
              profileImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
              
              profileAddIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
              profileAddIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
              
              
              profileName.centerXAnchor.constraint(equalTo: profileImage.centerXAnchor),
              
              shadowView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
              shadowView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
              shadowView.topAnchor.constraint(equalTo: self.topAnchor),
              shadowView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            editIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            editIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            ])
        
    }
    
    
    override var isSelected: Bool {

        
        didSet{
            if isSelected == true && profileSelectorScreen?.doneStack.isHidden == false && profileName.text != "Add Profile" {
                print("is selected")
                editIcon.isHidden = false
                shadowView.isHidden = false
            }
            
            
            
            if isSelected == false && profileSelectorScreen?.editStack.isHidden == false && profileName.text != "Add Profile" {
                 print("is not selected 1")
                editIcon.isHidden = true
                shadowView.isHidden = true
            }
        }
        
        
    }
    
    
    

   
}
