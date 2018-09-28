//
//  BaseFilterController.swift
//  Mini Project - Search Filter
//
//  Created by Narayana Wijaya on 28/09/18.
//  Copyright © 2018 Narayana Wijaya. All rights reserved.
//

import UIKit

class BaseFilterController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.isTranslucent = false
        
        let closeButton = UIBarButtonItem(image: UIImage(named: "close button"), style: .done, target: self, action: #selector(closeButtonTapped))
        closeButton.tintColor = .black
        navigationItem.leftBarButtonItem = closeButton
        
        let resetButton = UIBarButtonItem(title: "Reset", style: .done, target: self, action: #selector(resetButtonTapped))
        resetButton.tintColor = .green
        resetButton.setTitleTextAttributes([.font : UIFont.systemFont(ofSize: 14)], for: .normal)
        navigationItem.rightBarButtonItem = resetButton
    }
    
    @objc func closeButtonTapped() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func resetButtonTapped() {
        
    }
}
