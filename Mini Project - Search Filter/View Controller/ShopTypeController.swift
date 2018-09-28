//
//  ShopTypeController.swift
//  Mini Project - Search Filter
//
//  Created by Narayana Wijaya on 28/09/18.
//  Copyright © 2018 Narayana Wijaya. All rights reserved.
//

import UIKit

class ShopTypeController: BaseFilterController {

    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: FilterDelegate?
    
    private let cellIdentifier = "ShopTypeSelectionCell"
    
//    let selections: [String] = ["Gold Merchant", "Official Store"]
    var requestModel: RequestModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ShopTypeSelectionTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.allowsMultipleSelection = true
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    override func closeButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func resetButtonTapped() {
        guard let request = requestModel else { return }
        request.resetBadge()
        tableView.reloadData()
    }

    @IBAction func applyButtonDidTapped(_ sender: Any) {
        if let delegate = delegate, let request = requestModel {
            delegate.didUpdate(requestModel: request)
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension ShopTypeController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let request = requestModel else { return 0 }
        return request.badgeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ShopTypeSelectionTableViewCell
        if let request = requestModel {
            let badge = request.badgeList
            cell.typeNameLabel.text = badge[indexPath.row].title ?? ""
            cell.setSelected(badge[indexPath.row].show ?? false)
//            cell.setSelected(badge[indexPath.row].show ?? false, animated: true)
        }
        
        return cell
    }
}

extension ShopTypeController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ShopTypeSelectionTableViewCell
        cell.setSelected(true)
        if indexPath.row == 0 {
            requestModel?.setGoldMerchat(true)
        } else {
            requestModel?.official = true
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ShopTypeSelectionTableViewCell
        cell.setSelected(false)
        if indexPath.row == 0 {
            requestModel?.setGoldMerchat(false)
        } else {
            requestModel?.official = false
        }
    }
}
