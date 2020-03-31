//
//  ImageSelectorController.swift
//  TableViews
//
//  Created by Mezut on 31/03/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit
import Firebase

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
    

    
    
    override func viewDidLoad() {
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
        
        
        self.navigationItem.leftBarButtonItem = leftBarButton
     
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true

    }
    
    
    
    func getFirebaseDatabase(){
        Firebase.Database.database().reference().child("ProfileImagePicker").observeSingleEvent(of: .value, with: { (snaptShot) in
            
            print(snaptShot)
            
            guard let imagePickerTitles = snaptShot.value as? [String: Any] else {return}
            print("IMAGE TITLES == \(imagePickerTitles)")
            
            for (key,value) in imagePickerTitles {
                print("THE KEY == \(key)")
            }
            
        }) { (err) in
            print("ERR occured while getting the images from the database")
        }
    }
    
    
    
    func setupCollectionView(){
        collectionView.backgroundColor = UIColor(red: 27/255, green: 27/255, blue: 27/255, alpha: 1)
        collectionView.register(CustomImagePickerCell.self, forCellWithReuseIdentifier: imageSelectorCellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 200)
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageSelectorCellId, for: indexPath)

        return cell
    }
    
    @objc func goBackBtn(){
        self.dismiss(animated: false, completion: nil)
    }
    
    
    func setupLayout(){
        view.addSubview(blackView)

        NSLayoutConstraint.activate([
            
            blackView.topAnchor.constraint(equalTo: self.view.topAnchor),
            blackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            blackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            blackView.widthAnchor.constraint(equalToConstant: 100),
            blackView.heightAnchor.constraint(equalToConstant: 90),
            

            

            
            ])
    }
}



