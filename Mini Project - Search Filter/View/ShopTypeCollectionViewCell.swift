//
//  ShopTypeCollectionViewCell.swift
//  Mini Project - Search Filter
//
//  Created by Narayana Wijaya on 28/09/18.
//  Copyright © 2018 Narayana Wijaya. All rights reserved.
//

import UIKit

protocol ShopTypeCollectionViewCellDelegate: class {
    func deleteButtonDidTapped(title: String)
}

class ShopTypeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    weak var delegate: ShopTypeCollectionViewCellDelegate?
    var index: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bgView.layer.borderColor = UIColor.gray.cgColor
        bgView.layer.borderWidth = 0.5
        bgView.layer.cornerRadius = bounds.height/2
        bgView.layer.masksToBounds = true
        
        deleteButton.layer.masksToBounds = true
        deleteButton.layer.cornerRadius = deleteButton.bounds.height/2
    }

    @IBAction func deleteButtonDidTapped(_ sender: UIButton) {
        if let delegate = delegate {
            delegate.deleteButtonDidTapped(title: nameLabel.text ?? "")
        }
    }
}
