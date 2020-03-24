//
//  ProfileCustomCell.swift
//  TableViews
//
//  Created by Mezut on 19/03/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit

class ProfileCustomCell: UICollectionViewCell {
    
    var profileSelectorScreen: ProfileSelector?
    
    var profileInformation: ProfileModel? {
        didSet{
            guard let avatorImage = profileInformation?.profileImage else {return}
            
            guard let url = URL(string: avatorImage) else {return}
            
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                if let err = err {
                    print("ISSUE WITH NETWORK", err)
                }
                
                
                
                guard let imageData = data else {return}
                
                guard let imageConstruction = UIImage(data: imageData) else {return}
                
                print("image name == \(imageData)")
                print("image construct == \(imageConstruction)")
                
                
                DispatchQueue.main.async {
                    self.profileImage.image = imageConstruction
                }
                
            }.resume()
            profileName.text = profileInformation?.profileName
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
        label.text = "Ok"
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
        backgroundColor = .orange
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout(){
        addSubview(profileImage)
        addSubview(profileAddIcon)
        addSubview(profileName)
        addSubview(shadowView)
        addSubview(editIcon)
        
        NSLayoutConstraint.activate([
              profileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
              profileImage.topAnchor.constraint(equalTo: self.topAnchor),
              profileImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
              profileImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
              
              profileAddIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
              profileAddIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
              
              profileName.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10),
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
            if isSelected == true && profileSelectorScreen?.doneStack.isHidden == false {
                print("is selected")
                editIcon.isHidden = false
                shadowView.isHidden = false
            }
            
            if isSelected == false && profileSelectorScreen?.editStack.isHidden == false {
                 print("is not selected 1")
                
                print("profile Edit Btn == \(profileSelectorScreen?.editStack.isHidden)")
                editIcon.isHidden = true
                shadowView.isHidden = true
            }
        }
        
        
    }
    
    
    

   
}
