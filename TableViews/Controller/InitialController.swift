//
//  ViewController.swift
//  NetflixApp
//
//  Created by Mezut on 16/07/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit
import Firebase


class initalHomeScreen: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    let cellId = "cellId"
    
    
    // Data of the cells
    
    let carouselData: [CarouselData] = {
        let data1 = CarouselData()
        data1.title = "Watch on any device"
        data1.description = "Stream on your phone, tablet, laptop, and TV without paying more."
        data1.CarouselImage = nil
        
        let data2 = CarouselData()
        data2.title = "Download and go"
        data2.description = "Save your data, watch offline on a plan, train, or submarine..."
        data2.CarouselImage = nil
        
        let data3 = CarouselData()
        data3.title = "No pesky contracts"
        data3.description = "Join today, cancel anytime"
        data3.CarouselImage = nil
        
        
        let data4 = CarouselData()
        data4.title = "Unlimited entertainment, one low price"
        data4.description = "Stream and download as much as you want, no extra fees."
        data4.CarouselImage = nil
        
        return [data1,data2,data3,data4]
    }()
    
    
    let netflixBg: UIImageView = {
       let image = UIImageView(image: #imageLiteral(resourceName: "netflix-profile-1"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var otherView: UIView = {
       let view = UIView(frame: self.view.frame)
        view.backgroundColor = .black
        view.layer.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "netflix-bg")).cgColor
        view.layer.opacity = 0.4
        return view
    }()
    
    
    
    

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Check if theres a currrent user logined in
        
        if Firebase.Auth.auth().currentUser != nil {
            DispatchQueue.main.async {
                let profileSelectorScreen = ProfileSelector()
                let navigationController = UINavigationController(rootViewController: profileSelectorScreen)
                navigationController.modalPresentationStyle = .fullScreen
                self.present(navigationController, animated: false, completion: nil)
                return
            }
        }
 
       collectionView.backgroundColor = UIColor.black
        

        // Configure the navigation bar
        setupNavigationbar()
        
        // Configure the collectionview
        setupCollectionView()
 
    }

    
    
    
    func setupCollectionView() {
        collectionView.register(CustomCellNew.self, forCellWithReuseIdentifier: cellId)
        collectionView.isPagingEnabled = true
        collectionView.insetsLayoutMarginsFromSafeArea = true
    }
 
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    @objc func handleSignIn(){
        self.navigationController?.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(SignUpScreen(), animated: true)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CustomCellNew
        
        cell.cellData = carouselData[indexPath.row]

        if indexPath.item == 3  {
            cell.topConstraint?.constant = -30
            print(cell.topConstraint?.constant as Any)
   
        }
        
        if cell.cellData?.title == carouselData[3].title {
            cell.backgroundView = otherView
        }
        
        cell.signInButton.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)

        
        switch indexPath.row {
        case  0: cell.carouselBtn.currentPage = 0
        case  1: cell.carouselBtn.currentPage = 1
        case  2: cell.carouselBtn.currentPage = 2
        case  3: cell.carouselBtn.currentPage = 3
        default:
            cell.carouselBtn.currentPage = 0
        }
        return cell
    }
    

   
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
  
    
    
    


}

