//
//  VideoOptionCell.swift
//  TableViews
//
//  Created by Mezut on 13/08/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit


class VideoOptionCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
    let cellId = "cellId"
    let padding: CGFloat = 40
    
    var blackSeperatorLine: UIView = {
       let blackView = UIView()
        blackView.backgroundColor = .black
        blackView.translatesAutoresizingMaskIntoConstraints = false
        return blackView
    }()
    
    
    var redSliderView: UIView = {
        let redView = UIView()
        redView.backgroundColor = .red
        redView.isHidden = true
        redView.translatesAutoresizingMaskIntoConstraints = false
        return redView
    }()
    
    
    var randomSlider: UIView = {
        let redView = UIView()
        redView.backgroundColor = .orange
        redView.isHidden = true
        redView.translatesAutoresizingMaskIntoConstraints = false
        return redView
    }()

    lazy var mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
       let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.showsHorizontalScrollIndicator = false
        cv.dataSource = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 24/255, green: 24/255, blue: 24/255, alpha: 1)
        setupLayout()
        backgroundColor = UIColor(red: 24/255, green: 24/255, blue: 24/255, alpha: 1)
        mainCollectionView.register(InnerVideoOptionCell.self, forCellWithReuseIdentifier: cellId)
        
        // Indicates to us that this should be the first items selected when launched
        
        let firstIndicator = IndexPath(item: 0, section: 0)
        mainCollectionView.selectItem(at: firstIndicator, animated: false, scrollPosition: .centeredHorizontally)

        
        if let layout = mainCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 5.0
            layout.minimumLineSpacing = 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.row {
        case 0: return CGSize(width: 115, height: self.frame.height)
        case 1,2: return CGSize(width: 155, height: self.frame.height)
        default:
            return CGSize(width: self.frame.width, height: self.frame.height)
        }
  
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let optionTitles: [String] = ["Episodes", "Trailer & More", "Trailer & More"]
        let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! InnerVideoOptionCell
        
        cell.videoOptionBtn.setTitle(optionTitles[indexPath.item].uppercased(), for: .normal)
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("items == \(indexPath.item) clicked" )
    }
    
    
    var horizontalBarLeft: NSLayoutConstraint?
    
    func setupLayout(){
        addSubview(blackSeperatorLine)
        addSubview(mainCollectionView)
        addSubview(redSliderView)
        addSubview(randomSlider)
        
        horizontalBarLeft = redSliderView.leftAnchor.constraint(equalTo: self.leftAnchor)
        horizontalBarLeft?.isActive = true
        NSLayoutConstraint.activate([
            
             blackSeperatorLine.leadingAnchor.constraint(equalTo: self.leadingAnchor),
             blackSeperatorLine.trailingAnchor.constraint(equalTo: self.trailingAnchor),
             blackSeperatorLine.heightAnchor.constraint(equalToConstant: 3),
             blackSeperatorLine.topAnchor.constraint(equalTo: self.topAnchor),
             
             mainCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
             mainCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
             mainCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
             mainCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
             
             
            redSliderView.bottomAnchor.constraint(equalTo: blackSeperatorLine.bottomAnchor, constant: 5),
            redSliderView.heightAnchor.constraint(equalToConstant: 6),
            redSliderView.widthAnchor.constraint(equalToConstant: self.frame.width/3),
            
            randomSlider.topAnchor.constraint(equalTo: blackSeperatorLine.bottomAnchor, constant: 5),
            randomSlider.heightAnchor.constraint(equalToConstant: 6),
            randomSlider.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


class InnerVideoOptionCell: UICollectionViewCell {
    

   
    
    lazy var videoOptionBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("", for: .normal)
        button.addTarget(self, action: #selector(handleUnderline), for: .touchUpInside)
        button.setTitleColor(UIColor.white, for: .normal)
        button.isUserInteractionEnabled = false
        button.titleLabel?.font = UIFont(name: "SFUIDisplay-Bold", size: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    var redView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.alpha = 0.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
   
    
    @objc func handleUnderline(){
        isUserInteractionEnabled = true
     }
    
    override var isHighlighted: Bool {
        didSet{
            UIView.animate(withDuration: 0.5) {
                self.redView.alpha = self.isHighlighted ? 1.0 : 0.0
            }
            
        }
        
    }

    override var isSelected: Bool {
        didSet{
            UIView.animate(withDuration: 0.5) {
                self.redView.alpha = self.isSelected ? 1.0 : 0.0
            }
            
        }
        
    }


    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    func setupLayout(){
        addSubview(videoOptionBtn)
        addSubview(redView)
        
        
        NSLayoutConstraint.activate([
            
           
            videoOptionBtn.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            videoOptionBtn.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            redView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            redView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            redView.topAnchor.constraint(equalTo: self.topAnchor),
            redView.heightAnchor.constraint(equalToConstant: 5)
            
          
            
            
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

