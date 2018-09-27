//
//  SearchItemCollectionViewCell.swift
//  Mini Project - Search Filter
//
//  Created by Narayana Wijaya on 26/09/18.
//  Copyright © 2018 Narayana Wijaya. All rights reserved.
//

import UIKit
import Kingfisher

class SearchItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    var item: ItemModel? {
        didSet {
            if let name = item?.name {
                nameLabel.text = name
            }
            if let price = item?.price {
                priceLabel.text = price
            }
            if let imageUrl = item?.image_uri {
                if let url = URL(string: imageUrl) {
                    imageView.kf.setImage(with: url)
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}


