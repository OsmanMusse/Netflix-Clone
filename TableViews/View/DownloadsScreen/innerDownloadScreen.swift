//
//  innerDownloadScreen.swift
//  TableViews
//
//  Created by Mezut on 14/01/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit
import Firebase


class innerDownloadScreen: UICollectionViewController,UICollectionViewDelegateFlowLayout{

    
    let collectionViewCellId = "tableViewCellId"
    let innerHeaderCellId = "innerHeaderCellId"
 
    let downloadCellId = "downloadCellId"
    let headerCellId = "headerCellId"
    let padding: CGFloat = 8
    


    
 
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        view.backgroundColor = Colors.settingBg
        
        setupNavigationBar()
        setupLayout()
    }
    
    
    
    func setupNavigationBar(){
        navigationItem.title = "Available for Download"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]
        let leftArrow = UIBarButtonItem(image: #imageLiteral(resourceName: "back-btn").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(goToDownloadScreen))
        navigationItem.leftBarButtonItems = [leftArrow]
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 30)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: innerHeaderCellId, for: indexPath) as? InnerDownloadHeader
     
        switch indexPath.section {
        case 0: header?.downloadHeaderTitle.text = AvailableDownloadedTitles.Series.rawValue
        case 1: header?.downloadHeaderTitle.text = AvailableDownloadedTitles.Psychological_Trillers.rawValue
        case 2: header?.downloadHeaderTitle.text  = AvailableDownloadedTitles.Young_Adult_Films.rawValue
        case 3: header?.downloadHeaderTitle.text  = AvailableDownloadedTitles.Popular_Netflix.rawValue
        case 4: header?.downloadHeaderTitle.text  = AvailableDownloadedTitles.Netflix_Originals.rawValue
        case 5: header?.downloadHeaderTitle.text  = AvailableDownloadedTitles.Top_Picks.rawValue
        case 6: header?.downloadHeaderTitle.text  = AvailableDownloadedTitles.You_Watched1.rawValue
        case 7: header?.downloadHeaderTitle.text  = AvailableDownloadedTitles.Teen_Programmes.rawValue
        case 8: header?.downloadHeaderTitle.text  = AvailableDownloadedTitles.Thrillers.rawValue
        case 9: header?.downloadHeaderTitle.text  = AvailableDownloadedTitles.TV_Suspense_Dramas.rawValue
        case 10: header?.downloadHeaderTitle.text = AvailableDownloadedTitles.Award_Winning.rawValue
        case 11: header?.downloadHeaderTitle.text = AvailableDownloadedTitles.Spanish_Crime.rawValue
        case 12: header?.downloadHeaderTitle.text = AvailableDownloadedTitles.You_Watched2.rawValue
        case 13: header?.downloadHeaderTitle.text = AvailableDownloadedTitles.New_Releases.rawValue
        case 14: header?.downloadHeaderTitle.text = AvailableDownloadedTitles.You_Watched_3.rawValue
        case 15: header?.downloadHeaderTitle.text = AvailableDownloadedTitles.You_Watched_4.rawValue
        case 16: header?.downloadHeaderTitle.text = AvailableDownloadedTitles.Drama_Soap.rawValue
        case 17: header?.downloadHeaderTitle.text = AvailableDownloadedTitles.Gay_Drama.rawValue
        case 18: header?.downloadHeaderTitle.text = AvailableDownloadedTitles.You_Watched_5.rawValue
         
        default: header?.downloadHeaderTitle.text = AvailableDownloadedTitles.Series.rawValue
        }

        return header!
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return  19
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 2 * padding, height: 150)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: padding, bottom: 10, right: padding)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellId, for: indexPath) as! DownloadCustomCell
        cell.downloadScreen = self
        return cell
    }
    
    
    func goToVideoController(video: VideoData) {
        let layout = StretchyHeaderLayout()
        let singleVideoController = SingleVideoController(collectionViewLayout: layout)
        singleVideoController.video = video
        
        self.present(singleVideoController, animated: true, completion: nil)
    }
    
    

    

            
        
            
    
 

    
    
   
    func setupLayout(){
        
     collectionView.register(DownloadCustomCell.self, forCellWithReuseIdentifier: collectionViewCellId)
     collectionView.register(InnerDownloadHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: innerHeaderCellId)
     collectionView.backgroundColor = Colors.settingBg
                
         
    }
 
    
    @objc func goToDownloadScreen(){
        navigationController?.popViewController(animated: true)
    }

}
