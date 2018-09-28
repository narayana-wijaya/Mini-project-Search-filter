//
//  FilterController.swift
//  Mini Project - Search Filter
//
//  Created by Narayana Wijaya on 27/09/18.
//  Copyright © 2018 Narayana Wijaya. All rights reserved.
//

import UIKit
import DoubleSlider

protocol FilterDelegate: class {
    func didUpdate(requestModel: RequestModel)
}

class FilterController: BaseFilterController {

    @IBOutlet weak var minimumPriceTextField: UITextField!
    @IBOutlet weak var maximumPriceTextField: UITextField!
    @IBOutlet weak var sliderView: UIView!
    @IBOutlet weak var wholesaleSwitch: UISwitch!
    @IBOutlet weak var shopTypeButton: UIButton!
    @IBOutlet weak var shopTypeCollectionView: UICollectionView!
    
    private var doubleSlider: DoubleSlider!
    private let maxPrice: Int = 100000000
    private let step: Int = 10000
    
    weak var delegate: FilterDelegate?
    
    private let cellIdentifier = "ShopTypeCell"
    var requestModel: RequestModel?
    var badges: [String] = []
    
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
        
        setupDoubleSlider()
        setupInitialValue()
    }
    
    func setupInitialValue() {
        guard let request = requestModel else { return }
        
        minimumPriceTextField.text = "Rp\(request.pmin?.formattedWithSeparator ?? "0")"
        maximumPriceTextField.text = "Rp\(request.pmax?.formattedWithSeparator ?? maxPrice.formattedWithSeparator)"
        
        doubleSlider.lowerValueStepIndex = (request.pmin ?? 0)/step
        doubleSlider.upperValueStepIndex = (request.pmax ?? maxPrice)/step
        
        wholesaleSwitch.isOn = request.wholesale ?? false
        
        setupShopType()
    }
    
    func setupShopType() {
        guard let request = requestModel else { return }
        badges.removeAll()
        if request.fshop == 2 {
            badges.append(BadgeType.goldMerchant.rawValue)
        }
        if request.official! {
            badges.append(BadgeType.officialStore.rawValue)
        }
        shopTypeCollectionView.reloadData()
    }
    
    func setupDoubleSlider() {
        let height: CGFloat = 38.0
        let width = sliderView.bounds.width
        
        let frame = CGRect(
            x: sliderView.bounds.minX - 2.0,
            y: sliderView.bounds.midY - (height / 2.0),
            width: width,
            height: height
        )
        
        doubleSlider = DoubleSlider(frame: frame)
        doubleSlider.translatesAutoresizingMaskIntoConstraints = false
        doubleSlider.trackHighlightTintColor = .tokopediaGreen
        doubleSlider.numberOfSteps = (maxPrice/step)+1
        doubleSlider.smoothStepping = true
        doubleSlider.labelsAreHidden = true
        
        doubleSlider.lowerValueStepIndex = 0
        doubleSlider.upperValueStepIndex = maxPrice/step

        doubleSlider.valueChangedDelegate = self
        
        sliderView.addSubview(doubleSlider)
    }
    
    override func resetButtonTapped() {
        if let request = requestModel {
            request.reset(max: maxPrice)
        }
    }

    @IBAction func wholeShaleDidSwitch(_ sender: UISwitch) {
        requestModel?.wholesale = sender.isOn
    }
    
    @IBAction func shopTypeSelectDidTapped(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ShopTypeController") as! ShopTypeController
        vc.requestModel = requestModel
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func applyFilterDidTapped(_ sender: UIButton) {
        if let delegate = delegate, let request = requestModel {
            request.start = 0
            delegate.didUpdate(requestModel: request)
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
    }
}

extension FilterController: FilterDelegate {
    func didUpdate(requestModel: RequestModel) {
        self.requestModel = requestModel
        setupShopType()
    }
}

extension FilterController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return badges.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ShopTypeCollectionViewCell
        cell.nameLabel.text = badges[indexPath.row]
        cell.index = indexPath.row
        cell.delegate = self
        return cell
    }
}

extension FilterController: ShopTypeCollectionViewCellDelegate {
    func deleteButtonDidTapped(title: String) {
        if let index = badges.firstIndex(of: title) {
            badges.remove(at: index)
        }
        if title == BadgeType.goldMerchant.rawValue {
            requestModel?.fshop = 1
        }
        if title == BadgeType.officialStore.rawValue {
            requestModel?.official = false
        }
        shopTypeCollectionView.reloadData()
    }
}

extension FilterController: DoubleSliderValueChangedDelegate {
    func valueChanged(for doubleSlider: DoubleSlider) {
        let minPrice = step*doubleSlider.lowerValueStepIndex
        let maxPrice = step*doubleSlider.upperValueStepIndex
        minimumPriceTextField.text = "Rp\(minPrice.formattedWithSeparator)"
        maximumPriceTextField.text = "Rp\(maxPrice.formattedWithSeparator)"
        
        requestModel?.pmax = maxPrice
        requestModel?.pmin = minPrice
    }
}

extension FilterController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let request = requestModel else { return }
        if textField == minimumPriceTextField {
            textField.text = "\(request.pmin ?? 0)"
        }
        if textField == maximumPriceTextField {
            textField.text = "\(request.pmax ?? maxPrice)"
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let value = textField.text.toInt()
        if textField == minimumPriceTextField {
            guard let request = requestModel, let max = request.pmax, value <= max else {
                textField.text = "Rp\(requestModel?.pmin?.formattedWithSeparator ?? "0")"
                present(alert: "minimum price should not exceed maximum price")
                return
            }
            textField.text = "Rp\(value.formattedWithSeparator)"
            requestModel?.pmin = value
            doubleSlider.lowerValueStepIndex = value/step
        }
        if textField == maximumPriceTextField {
            guard let request = requestModel, let min = request.pmin, value >= min else {
                textField.text = "Rp\(requestModel?.pmax?.formattedWithSeparator ?? maxPrice.formattedWithSeparator)"
                present(alert: "maximum price should not less than minimum price")
                return
            }
            textField.text = "Rp\(value.formattedWithSeparator)"
            requestModel?.pmax = value
            doubleSlider.upperValueStepIndex = value/step
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func present(alert message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}


