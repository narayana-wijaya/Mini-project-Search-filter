//
//  ShopTypeSelectionTableViewCell.swift
//  Mini Project - Search Filter
//
//  Created by Narayana Wijaya on 28/09/18.
//  Copyright © 2018 Narayana Wijaya. All rights reserved.
//

import UIKit

class ShopTypeSelectionTableViewCell: UITableViewCell {

    @IBOutlet weak var checkBoxImageView: UIImageView!
    @IBOutlet weak var typeNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func setSelected(_ selected: Bool) {
        checkBoxImageView.image = selected ? UIImage(named: "box selected") : UIImage(named: "box unselected")
    }
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        checkBoxImageView.image = selected ? UIImage(named: "box selected") : UIImage(named: "box unselected")
//    }
    
}
