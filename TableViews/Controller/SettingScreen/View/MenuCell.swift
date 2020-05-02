//
//  MenuCell.swift
//  TableViews
//
//  Created by Mezut on 05/04/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

protocol MenuCellDelegate {
    func didTapProfileBtn(viewControllerToPresent: UIViewController)
}

class MenuCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout{
   
    var cellDelegate: MenuCellDelegate?
    
    private let innerCellID = "innerCellID"
    private let cellPadding: CGFloat = 9
    private var profileName: String = ""
    private var didRemoveProfile: Bool = false

    var profileData = [ProfileModel]()
    var settingHeader: SettingScreenHeader?
    
    lazy var innerCollectionView: UICollectionView =  {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.alwaysBounceHorizontal = false
        cv.alwaysBounceVertical = false
        cv.delegate = self
        cv.dataSource = self
        cv.isScrollEnabled = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    lazy var manageProfileBtn: UIButton = {
       let button = UIButton(type: .system)
        button.setTitle("Manage Profiles", for: .normal)
        button.setTitleColor(Colors.btnGray, for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 15)
        button.setImage(#imageLiteral(resourceName: "pencil-2").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleManageBtn), for: .touchUpInside)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right:0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        fetchRemovedProfile()
        fetchNewProfile()
        fetchEditedProfiles()
        setupCollectionView()
        setupLayout()
        
   
    }
    
    
    func didTapProfile(profileName: String) {
        self.profileName = profileName
    }
    

    
    func fetchRemovedProfile(){
        guard let userID = Firebase.Auth.auth().currentUser?.uid else {return}
        
        Firebase.Database.getUpdatedUserProfile(userID: userID, dataEventType: .childRemoved) { (removedProfile) in
            var removeArray = [ProfileModel]()
            removeArray.append(removedProfile)
            
            // Removes the deleted profile from the profileData array list
            let indexes = self.profileData.enumerated().filter {
                $0.element.profileName == removedProfile.profileName
                }.map{$0.offset}
            
                self.profileData.remove(at: indexes[0])
                self.didRemoveProfile = true
                DispatchQueue.main.async {
                    self.innerCollectionView.reloadData()
                }

           
        }
        
    }
    
    
    func fetchNewProfile(){
      guard let userID = Firebase.Auth.auth().currentUser?.uid else {return}
        
        Firebase.Database.getUpdatedUserProfile(userID: userID, dataEventType: .childAdded) { (addedProfile) in
            
            self.profileData.append(addedProfile)
            self.didRemoveProfile = true
            DispatchQueue.main.async {
                self.innerCollectionView.reloadData()
            }
        }
    }
    
    func fetchEditedProfiles(){
      guard let userID = Firebase.Auth.auth().currentUser?.uid else {return}
        
        Firebase.Database.getUpdatedUserProfile(userID: userID, dataEventType: .childChanged) { (editedProfile) in
            var EditedArray = [ProfileModel]()
             EditedArray.append(editedProfile)
             
             // Removes the deleted profile from the profileData array list
             let indexes = self.profileData.enumerated().filter {
                 $0.element.userIdentifier == editedProfile.userIdentifier
                 }.map{$0.offset}
            
                 self.profileData.remove(at: indexes[0])
                 self.profileData.insert(editedProfile, at: indexes[0])
            DispatchQueue.main.async {
                self.innerCollectionView.reloadData()
            }
            
        }
        
    }
    
   
    
    func setupCollectionView(){
        innerCollectionView.register(InnerMenuCell.self, forCellWithReuseIdentifier: innerCellID)
        
        if let layout = innerCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
            layout.minimumLineSpacing = 22
            layout.scrollDirection = .vertical
        }
      
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if profileData.count <= 6 {
           return profileData.count + 1
        }
        
        return profileData.count
    }
        
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let profileCount = CGFloat(self.innerCollectionView.numberOfItems(inSection: 0))
        
        switch profileData.count {
        case 4:  return  CGSize(width: self.frame.width / 5 - cellPadding * 2 , height: 65)
        case 3:  return  CGSize(width: self.frame.width / 5 - cellPadding * 2 , height: 65)
        case 2:  return  CGSize(width: self.frame.width / 3 - cellPadding * 2 , height: 65)
        default: return  CGSize(width: self.frame.width / profileCount - cellPadding, height: 65)
        }
        
    }

    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        

        guard let userID = Firebase.Auth.auth().currentUser?.uid else {return}
        let cell = innerCollectionView.cellForItem(at: indexPath) as! InnerMenuCell
        guard let profileBtnText = cell.profileName.titleLabel?.text else {return}
        
        // Add Profile Btn Trigger
       let lastItem = indexPath.item + 1 == innerCollectionView.numberOfItems(inSection: 0)
        if lastItem == true && profileBtnText == "Add Profile" {
          settingHeader?.goToCreatController()
          return
       }
        
        guard let clickedProfileName = cell.profileName.titleLabel?.text else {return}
        
        let activeProfileArray = self.profileData.enumerated().filter {
            $0.element.isActive == true
        }.map{$0.element}
        
        let clickedProfileArray = self.profileData.enumerated().filter {
            $0.element.profileName == clickedProfileName
        }.map{$0.element}
        
  
        let activeProfile = activeProfileArray[0]
        guard let activeProfileIdentifier = activeProfile.userIdentifier else {return}
        
        let clickedProfile = clickedProfileArray[0]
        guard let clickedProfileIdentifier = clickedProfile.userIdentifier else {return}
        
        print(clickedProfileIdentifier)
        
        // Prevents the creation of a profile being selected and active user
        if profileName != "Add Profile" && clickedProfile.isActive == false{
            
            SVProgressHUD.show()
            SVProgressHUD.setBackgroundLayerColor(UIColor.black.withAlphaComponent(0.4))
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.80) {
                self.settingHeader?.goToRootViewController()
                SVProgressHUD.dismiss()
            }
            
          
    Firebase.Database.database().reference().child("Users").child(userID).child("Profiles").child(activeProfileIdentifier).updateChildValues(["isActive": false])
            
        
            
    Firebase.Database.database().reference().child("Users").child(userID).child("Profiles").child(clickedProfileIdentifier).updateChildValues(["isActive": true])
            
        }
    
    }
    

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = innerCollectionView.dequeueReusableCell(withReuseIdentifier: innerCellID, for: indexPath) as! InnerMenuCell
        
        let lastItem = indexPath.item + 1 == innerCollectionView.numberOfItems(inSection: 0)
        
        if lastItem == true && indexPath.item != 0 && indexPath.item != 5 {
            cell.setupAddProfile()
            return cell
        }
        if lastItem == false {
            cell.profileInformation = profileData[indexPath.item]
            cell.profileImage.isHidden = false
            cell.addIcon.isHidden = true
            cell.layer.borderColor = UIColor.clear.cgColor
            return cell
        }
        
        if profileData.count > 4 {
            cell.profileImage.isHidden = true
            return cell
        }
   
        return cell
    }
    
    
    
    @objc func handleManageBtn(){
        
        // Find out the active user
        let activeProfileArray = self.profileData.enumerated().filter {
             $0.element.isActive == true
         }.map{$0.element}
         
          let activeProfile = activeProfileArray[0]
        
        let profileSelector = ProfileSelector()
        profileSelector.activeProfile = activeProfile
        profileSelector.modalPresentationStyle = .pageSheet
        cellDelegate?.didTapProfileBtn(viewControllerToPresent: profileSelector)
    }
    
    
    
    func setupLayout(){
        addSubview(innerCollectionView)
        addSubview(manageProfileBtn)
        
        NSLayoutConstraint.activate([
            innerCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            innerCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            innerCollectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 25),
            innerCollectionView.heightAnchor.constraint(equalToConstant: 125),
            
            manageProfileBtn.bottomAnchor.constraint(equalTo: innerCollectionView.bottomAnchor, constant: 30),
            manageProfileBtn.centerXAnchor.constraint(equalTo: innerCollectionView.centerXAnchor, constant:0)
        
            
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    
}


