//
//  ImageSelectorController.swift
//  TableViews
//
//  Created by Mezut on 31/03/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

protocol ImageSelectorDelegate {
    func didSelectImage()
}
class ImageSelectorController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let imageSelectorCellId = "imageSelectorCellId"
    
    let blackView: UIView = {
       let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let navigationTitle: UIButton = {
       let button = UIButton(type: .system)
        button.setTitle("Choose Icon", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 17)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    

    var imagePickerData: [ImagePicker] = []
    var blackViewHeightConstraint: NSLayoutConstraint?
    
    
    override func viewDidLoad() {
        print("Image Selector Screen Called")
        setupNavBar()
        getFirebaseDatabase()
        setupCollectionView()
        setupLayout()
        
    
    }
    
    func setupNavBar(){
        
        navigationItem.title = "Choose Icon"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                                                        NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 18)]
        let leftBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "back-btn").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(goBackBtn))
        
        leftBarButton.imageInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)

        self.navigationItem.leftBarButtonItem = leftBarButton
     
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true

    }
    
    
    
    func getFirebaseDatabase(){
     
        if imagePickerData.count == 0 {
            Firebase.Database.database().reference().child("ProfileImagePicker").observeSingleEvent(of: .value) { (snapShot) in
                
                guard let dictionary = snapShot.value as? [String: [String: String]] else {return}
                for (key,value) in dictionary {
                    
                    let imagePickerCategory = key
                    
                    guard let imatePickerImages =  value as? [String: String] else {return}
                    
                    let finalDictionary = [imagePickerCategory: imatePickerImages]
                    
                    let createImagePicker =  ImagePicker(dictionary: finalDictionary)
                    self.imagePickerData.append(createImagePicker)
                    
                    
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0, execute: {
                        SVProgressHUD.dismiss()
                            self.collectionView.reloadData()

                    })
                    
           
                    
                }
            }

        }
      
    }
 
    
    func setupCollectionView(){
        collectionView.backgroundColor = Colors.settingBg
        collectionView.register(CustomImagePickerCell.self, forCellWithReuseIdentifier: imageSelectorCellId)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return imagePickerData.count
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 185)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Index Path Section == \(indexPath.section) Index Path item == \(indexPath.section)")
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageSelectorCellId, for: indexPath) as! CustomImagePickerCell
        cell.selectorController = self
        cell.customPickerDelegate = self
        cell.imagePickerInformation = imagePickerData[indexPath.section]
        return cell
    }
    
    
    
    func goToCreateControllerWithImage(image: String){
        guard let viewController = self.navigationController?.viewControllers[0] else {return}
        guard let createController = viewController as? CreateProfileController else {return}
        createController.setupProfileImage(profilePicture: image)
        createController.profileImageURL = image
        self.navigationController?.popToViewController(createController, animated: false)
    }
    
    
    
    @objc func goBackBtn(){
        guard let viewController = self.navigationController?.viewControllers[0] else {return}
        
        if let firstViewController = viewController as? EditProfileController {
            firstViewController.imageSelectorData = self.imagePickerData
            self.navigationController?.popToViewController(firstViewController, animated: false)
        } else {
            guard let viewController = self.navigationController?.viewControllers[0] else {return}
            guard let createController = viewController as? CreateProfileController else {return}
            self.navigationController?.popToViewController(createController, animated: false)
        }
    
    }
    
    
    func setupLayout(){
        view.addSubview(blackView)
        blackViewHeightConstraint = blackView.heightAnchor.constraint(equalToConstant: 90)
        blackViewHeightConstraint?.isActive = true

        NSLayoutConstraint.activate([
    
            blackView.topAnchor.constraint(equalTo: self.view.topAnchor),
            blackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            blackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            blackView.widthAnchor.constraint(equalToConstant: 100)
            
            ])
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if ((self.navigationController?.viewControllers[0] as? EditProfileController) != nil), modalPresentationStyle == .pageSheet {
             blackViewHeightConstraint?.constant = 55
        }
        else if ((self.navigationController?.viewControllers[0] as? CreateProfileController) != nil), modalPresentationStyle == .pageSheet {
             blackViewHeightConstraint?.constant = 55
        }
}
    
}


extension ImageSelectorController: CustomImageCellDelegate {
    
    func didTapInnerCell(tappedImageString: String) {
        guard let viewController = self.navigationController?.viewControllers[0] else {return}
        guard let editController = viewController as? EditProfileController else {return}
        editController.profileImage.image = profileCachedImages[tappedImageString]
        editController.profileImageURL = tappedImageString
        editController.oldProfileURL = tappedImageString
        self.navigationController?.popToViewController(editController, animated: false)
    }
    
    
}

