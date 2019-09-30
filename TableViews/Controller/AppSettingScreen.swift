//
//  AppSettingScreen.swift
//  TableViews
//
//  Created by Mezut on 25/09/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit

class AppSettingScreen: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    
    let cellId = "cellId"
    let VideoPlayBackCellId = "appSettingCellId"
    let downloadCellId = "downloadCellId"
    let cellHeaderId = "cellHeaderId"
    
    
    let blackTopView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1)
        view.isOpaque = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        collectionView.backgroundColor = Colors.settingBg
        setupCollectionView()
        setupNavigationBar()
        setupLayout()
    }
    
    func setupNavigationBar(){
        
        self.navigationItem.title = "App Settings"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]
        
        let leftArrow  = UIBarButtonItem(image: #imageLiteral(resourceName: "back-btn").withRenderingMode(.alwaysOriginal), style: .plain
            , target: self, action: #selector(handleBackBtn))
        leftArrow.imageInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        navigationItem.leftBarButtonItems = [leftArrow]
    }
    
    
    func setupCollectionView(){
        collectionView.alwaysBounceVertical = true
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionHeadersPinToVisibleBounds = true
        }
        collectionView.register(VideoPlayBackCell.self, forCellWithReuseIdentifier: VideoPlayBackCellId)
        collectionView.register(DownloadCell.self, forCellWithReuseIdentifier: downloadCellId)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(AppSettingHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: cellHeaderId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let appSettingTitles: [String] = ["Video Playback", "Downloads"]
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: cellHeaderId, for: indexPath) as? AppSettingHeader
        if indexPath.section == 0 {
            cell?.headerLabel.text = appSettingTitles[0].uppercased()
            return cell!
        } else {
            cell?.headerLabel.text = appSettingTitles[1].uppercased()
            return cell!
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 58)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
             return CGSize(width: self.view.frame.width, height: 65)
            
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 4
            
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var downloadTitles: [String] = ["Wi-Fi Only", "Smart Downloads", "Video Quality"]
        if indexPath.section == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoPlayBackCellId, for: indexPath) as? VideoPlayBackCell
            
            return cell!
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: downloadCellId, for: indexPath) as? DownloadCell
            
            if indexPath.item == 0 {
                cell?.settingDescription.isHidden = true
            }
            
            switch indexPath.item {
            case 0: cell?.settingDescription.isHidden = true
            case 1: cell?.settingLabel.text = "Smart Downloads";
                    cell?.centerYConstraint?.isActive = false;
                    cell?.topConstraint?.isActive = true
            case 2: cell?.settingLabel.text = "Video Quality";
                    cell?.settingDescription.text = "Standard";
                    cell?.topConstraint?.isActive = false
                    cell?.centerYConstraint?.isActive = true
            case 3: cell?.settingLabel.text = "Delete All Downloads";
                    cell?.centerYConstraint?.isActive = false;
                    cell?.topConstraint?.isActive = true
                    cell?.switchIcon.isHidden = true
            default: break
            }
            
            if indexPath.item == 3 {
              cell?.trashIcon.isHidden = false
            }
            return cell!
        }
    }
    
    @objc func handleBackBtn(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupLayout(){
        view.addSubview(blackTopView)
        
        NSLayoutConstraint.activate([
            blackTopView.topAnchor.constraint(equalTo: self.view.topAnchor),
            blackTopView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            blackTopView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            blackTopView.widthAnchor.constraint(equalToConstant: self.view.frame.width),
            blackTopView.heightAnchor.constraint(equalToConstant: 90),
            
            ])
    }
}
