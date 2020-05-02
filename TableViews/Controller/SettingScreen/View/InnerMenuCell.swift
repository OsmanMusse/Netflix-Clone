//
//  InnerMenuCell.swift
//  TableViews
//
//  Created by Mezut on 05/04/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit

class InnerMenuCell: UICollectionViewCell {
    
    
    var profileInformation: ProfileModel? {
        didSet{
           
            
            guard let imageURL = profileInformation?.profileImage else {return}
            
                 self.profileName.setTitle(self.profileInformation?.profileName, for: .normal)
            
            // indicates which user is profile with a white border color
            if self.profileInformation?.isActive == true {
               self.profileImage.layer.borderColor = UIColor.white.cgColor
               self.profileImage.layer.borderWidth = 2
               self.profileImage.layer.masksToBounds = true
            } else {
                self.profileImage.layer.borderColor = UIColor.clear.cgColor
            }
            
            if let cachedImage = profileCachedImages[imageURL]{
                self.profileImage.image = cachedImage
                return
            }
            
           
            
            guard let url = URL(string: imageURL) else {return}
            
            URLSession.shared.dataTask(with: url) { (data, response, err) in
             
                if let err = err {
                    print("ISSUE WITH NETWORK", err)
                }
                
                
                if url.absoluteString != self.profileInformation?.profileImage {
                    return
                }
                
                guard let imageData = data else {return}
                guard let constructedImage = UIImage(data: imageData) else {return}

                
                DispatchQueue.main.async {
                    self.profileImage.image = constructedImage
                }
                
            }.resume()
        }
    }
    
    
   
    
     var profileImage: UIImageView = {
       let image = UIImageView()
        image.layer.cornerRadius = 4.5
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let addIcon: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "add"))
        image.isHidden = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
     var profileName: UIButton = {
        let button = UIButton(type: .custom)
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byTruncatingTail
        button.setTitleColor(Colors.btnGray, for: .normal)
        button.titleLabel?.font =  UIFont(name: "Helvetica", size: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    
    }
    
    
    func setupAddProfile(){
      self.addIcon.isHidden = false
      self.profileImage.isHidden = true
      self.profileName.setTitle("Add Profile", for: .normal)
      self.layer.borderColor =  UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1).cgColor
      self.layer.borderWidth = 2
      self.layer.cornerRadius = 4.5
      
    }
    
    
    
    
 
    
    func setupLayout(){
        addSubview(profileImage)
        addSubview(addIcon)
        addSubview(profileName)
        
        NSLayoutConstraint.activate([
            
            profileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            profileImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            profileImage.topAnchor.constraint(equalTo: self.topAnchor),
            profileImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            addIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            addIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            profileName.topAnchor.constraint(equalTo: self.profileImage.bottomAnchor, constant: 4),
            profileName.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            profileName.widthAnchor.constraint(equalTo: self.widthAnchor)
            
            ])
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
