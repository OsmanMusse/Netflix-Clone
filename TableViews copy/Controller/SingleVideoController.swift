//
//  SingleVideoController.swift
//  TableViews
//
//  Created by Mezut on 08/08/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class SingleVideoController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
    let headerCellId = "headerCellId"
    let CustomVideoCellId = "cellId"
    let videoOptionCellId = "videoOptionCellId"
    
    let trailerHeaderId = "trailerHeaderId"
    
    var video: VideoData? {
        didSet {
        }
    }
    
    
    
    
    
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .clear
        collectionView.register(SingleVideoHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellId)
        collectionView.register(CustomVideoCell.self, forCellWithReuseIdentifier: CustomVideoCellId)
        collectionView.register(VideoOptionCell.self, forCellWithReuseIdentifier: videoOptionCellId)
        collectionView.contentInsetAdjustmentBehavior = .never
        
    
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 2
            
        }
        
        setuplayout()
    }
    
    
    
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 700)
    }
    

 
    
    var singleHeader: SingleVideoHeader?
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        singleHeader =  collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellId, for: indexPath) as? SingleVideoHeader
        singleHeader?.singleVideoController = self
        singleHeader?.video = video
        return singleHeader!
    }
    
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let calculatedNumber = abs(offsetY) / 100
        let newNumber = 1.0 - calculatedNumber
        let osman = CGFloat(0.0)
        
        singleHeader?.blackCancelView.alpha = newNumber

      }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        switch indexPath.row {
        case 0: let cell = collectionView.dequeueReusableCell(withReuseIdentifier: videoOptionCellId, for: indexPath)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomVideoCellId, for: indexPath)
            
            return cell
        }
       
    }
    
    
    func setuplayout(){
      

    }
    
    func goToHomeScreen(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
}





class CustomVideoCell: UICollectionViewCell {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .orange
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

