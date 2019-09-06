
import UIKit


class RecentlyAddedCell: BaseListViewCell<RecentlyCollectionViewCell> {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class RecentlyCollectionViewCell: BaseCollectionViewCell {
    
}
