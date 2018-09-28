//
//  ViewController.swift
//  Mini Project - Search Filter
//
//  Created by Narayana Wijaya on 26/09/18.
//  Copyright © 2018 Narayana Wijaya. All rights reserved.
//

import UIKit
import Alamofire

class SearchController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var filterButton: UIButton!
    
    private let cellId = "SearchItemCollectionViewCell"
    let provider = NetworkDataProvider()
    
    var items: [ItemModel] = []
    var startRow: Int = 0
    
    var requestModel: RequestModel?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        requestModel = RequestModel(minPrice: 0, maxPrice: 1000000, wholesale: true, official: true, fshop: 2, start: startRow)
        loadData(requestModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: cellId, bundle: nil), forCellWithReuseIdentifier: cellId)
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
    }
    
    func loadData(_ model: RequestModel?) {
        provider.getData(params: model.toKeyVal() ?? [:], { (newItems) in
            guard newItems.count > 0 else { return }
            
            self.items.append(contentsOf: newItems)
            self.collectionView.reloadData()
        }) { (errorMsg) in
            debugPrint(errorMsg)
        }
    }
    
    @IBAction func filterButtonDidTapped(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FilterController") as! FilterController
        vc.requestModel = requestModel
        self.navigationController?.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
}



extension SearchController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchItemCollectionViewCell
        cell.item = items[indexPath.item]
        cell.contentView.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addConstraint(NSLayoutConstraint(item: cell.contentView,
                                                              attribute: .width,
                                                              relatedBy: .equal,
                                                              toItem: nil,
                                                              attribute: .notAnAttribute, multiplier: 1.0,
                                                              constant: (collectionView.bounds.width-2)/2))
        return cell
    }
    
}

extension SearchController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let model = requestModel, indexPath.row%10 == 0 else {
            return
        }
        model.start = items.count
        loadData(model)
    }
}

extension SearchController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.frame.width - 2)/2
        return CGSize(width: width, height: width*233/166)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}

