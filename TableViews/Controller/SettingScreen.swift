//
//  SettingScreen.swift
//  TableViews
//
//  Created by Mezut on 27/08/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit

class SettingScreen: UICollectionViewController, UICollectionViewDelegateFlowLayout  {

    let settingHeaderCellId = "settingHeaderCellId"
    let settingCustomCellId = "settingCustomCellId"
    
    
    
    override func viewDidLoad() {
     
        setupNavigationBar()
        
        collectionView.register(SettingsHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: settingHeaderCellId)
        collectionView.register(SettingCustomCell.self, forCellWithReuseIdentifier: settingCustomCellId)
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.backgroundColor = UIColor(red: 27/255, green: 27/255, blue: 27/255, alpha: 1)
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
        }

    }
    
    func playBtn(){
        print("PLAY BUTTON")
 
    }
    


    
    func setupNavigationBar(){
        
    
        // Hides the navigation bar when back button is clicked on from the setting option cell
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    
    func goToScreen(title:String){
        
    print("The setting screen text is == \(title)")
        let layout = UICollectionViewFlowLayout()
        let listController = AppSettingScreen(collectionViewLayout: layout)
        listController.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        listController.navigationController?.navigationBar.shadowImage = UIImage()
        listController.navigationController?.navigationBar.isTranslucent = false
        navigationController?.pushViewController(listController, animated: true)
    
    }
    

    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: settingHeaderCellId, for: indexPath) as? SettingsHeader
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 255)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 45)
    }
    
   
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let headerTitle: [String] = ["My List", "App Setting", "Privacy", "Help", "Sign Out", "Version: 11.22.0 (2540) 5.0.1-001"]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: settingCustomCellId, for: indexPath) as?
        SettingCustomCell
        cell?.settingButton.setTitle(headerTitle[indexPath.item], for: .normal)
        let firstCell = indexPath.item == 0
        cell?.blackSeperatorLine.backgroundColor = firstCell ? UIColor.black : UIColor.clear
        if firstCell {
            cell?.settingButton.setImage(#imageLiteral(resourceName: "tick-gray").withRenderingMode(.alwaysOriginal), for: .normal)
            cell?.settingButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -18)
            cell?.rightArrow.isHidden = false
            cell?.settingScreen = self
            
        }
        if indexPath.item == 5 {
            cell?.settingButton.setTitleColor(Colors.btnLightGray, for: .normal)
        } else {
            cell?.settingButton.setTitleColor(Colors.lightGray, for: .normal)
        }
        
        return cell!
    }

    
   
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
}



class SettingCustomCell: UICollectionViewCell {
    
    
    var settingScreen: SettingScreen?
    
    
    let blackSeperatorLine: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let rightArrow: UIImageView = {
      let image = UIImageView(image: #imageLiteral(resourceName: "arrow-point-to-right"))
        image.contentMode = .scaleAspectFill
        image.isHidden = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var settingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("My List", for: .normal)
        button.addTarget(self, action: #selector(goToController), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 27/255, green: 27/255, blue: 27/255, alpha: 1)
        setupLayout()
    }
    
    
    @objc func goToController(){
        settingScreen?.goToScreen(title: "\(settingButton.titleLabel?.text)")
    }
    
    
    func setupLayout(){
        addSubview(settingButton)
        addSubview(blackSeperatorLine)
        addSubview(rightArrow)
        
        NSLayoutConstraint.activate([
            
            settingButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            settingButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            blackSeperatorLine.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            blackSeperatorLine.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            blackSeperatorLine.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            blackSeperatorLine.heightAnchor.constraint(equalToConstant: 2),
            
            rightArrow.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            rightArrow.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
