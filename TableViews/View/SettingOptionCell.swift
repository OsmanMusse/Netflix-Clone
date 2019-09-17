
import UIKit

class SettingCustomCell: UICollectionViewCell {
    
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
    
    let settingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("My List", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 27/255, green: 27/255, blue: 27/255, alpha: 1)
        setupLayout()
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

