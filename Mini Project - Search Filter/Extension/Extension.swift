//
//  Extension.swift
//  Mini Project - Search Filter
//
//  Created by Narayana Wijaya on 27/09/18.
//  Copyright © 2018 Narayana Wijaya. All rights reserved.
//

import UIKit

extension UITextField {
    
    func titleLabel(text: String) {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.text = text
        label.textAlignment = self.textAlignment
        self.addSubview(label)
        
        let metrics = ["height": NSNumber(value: 20)]
        let views = ["label": label]
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[label]|",
                                                           options: .init(rawValue: 0),
                                                           metrics: metrics,
                                                           views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label(height)]",
                                                           options: .init(rawValue: 0),
                                                           metrics: metrics,
                                                           views: views))
    }
    
    func setBottomBorder(width: Double) {
        let lineView = UIView()
        lineView.backgroundColor = .gray
        lineView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(lineView)
        
        let metrics = ["width": NSNumber(value: width)]
        let views = ["line": lineView]
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[line]|",
                                                          options: .init(rawValue: 0),
                                                          metrics: metrics,
                                                          views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[line(width)]|",
                                                           options: .init(rawValue: 0),
                                                           metrics: metrics,
                                                           views: views))
    }
}

extension UIColor {
    static var tokopediaGreen: UIColor {
        return UIColor(red: 66/255, green: 181/255, blue: 173/255, alpha: 1)
    }
}

extension Optional where Wrapped == String {
    func toInt() -> Int {
        guard let string = self, let result = Int(string) else { return 0 }
        return result
    }
}
