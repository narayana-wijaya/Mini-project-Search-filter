//
//  FilterController.swift
//  Mini Project - Search Filter
//
//  Created by Narayana Wijaya on 27/09/18.
//  Copyright © 2018 Narayana Wijaya. All rights reserved.
//

import UIKit

class FilterController: BaseFilterController {

    @IBOutlet weak var minimumPriceTextField: UITextField!
    @IBOutlet weak var maximumPriceTextField: UITextField!
    @IBOutlet weak var priceSlider: UISlider!
    @IBOutlet weak var wholesaleSwitch: UISwitch!
    @IBOutlet weak var shopTypeButton: UIButton!
    @IBOutlet weak var shopTypeCollectionView: UICollectionView!
    
    private let cellIdentifier = "ShopTypeCell"
    var requestModel: RequestModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        minimumPriceTextField.setBottomBorder(width: 0.75)
        minimumPriceTextField.titleLabel(text: "Minimum Price")
        maximumPriceTextField.setBottomBorder(width: 0.75)
        maximumPriceTextField.titleLabel(text: "Maximum Price")
        
        shopTypeCollectionView.register(UINib(nibName: "ShopTypeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        if let flowLayout = shopTypeCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.itemSize = CGSize(width: shopTypeCollectionView.bounds.width/2.5, height: shopTypeCollectionView.bounds.height)
            flowLayout.minimumInteritemSpacing = 8
        }
    }
    
    override func resetButtonTapped() {
        
    }

    @IBAction func shopTypeSelectDidTapped(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ShopTypeController") as! ShopTypeController
        vc.requestModel = requestModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension FilterController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ShopTypeCollectionViewCell
        cell.nameLabel.text = "Gold Merchant"
        return cell
    }
}
