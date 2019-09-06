//
//  EpisodeController.swift
//  TableViews
//
//  Created by Mezut on 17/08/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit

class EpisodeController: UICollectionViewController , UICollectionViewDelegateFlowLayout {
    
    let episodeHeaderCellId = "episodeHeaderCellId"
    let episodesCellId = "episodesCellId"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupLayout()
        collectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: episodeHeaderCellId)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: episodesCellId)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: episodeHeaderCellId, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
   
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 250)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 13
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: episodesCellId, for: indexPath)
        cell.backgroundColor = .orange
        return cell
    }
    
    
    func setupLayout(){
        
    }
    


}
