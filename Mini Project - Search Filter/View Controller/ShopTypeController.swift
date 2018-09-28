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
    
    private let cellIdentifier = "ShopTypeSelectionCell"
    
    let selections: [String] = ["Gold Merchant", "Official Store"]
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
        
    }

    @IBAction func applyButtonDidTapped(_ sender: Any) {
    }
}

extension ShopTypeController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ShopTypeSelectionTableViewCell
        cell.typeNameLabel.text = selections[indexPath.row]
        return cell
    }
}

extension ShopTypeController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.setSelected(true, animated: true)
    }
}
