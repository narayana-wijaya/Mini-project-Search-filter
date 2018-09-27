//
//  RequestModel.swift
//  Mini Project - Search Filter
//
//  Created by Narayana Wijaya on 26/09/18.
//  Copyright © 2018 Narayana Wijaya. All rights reserved.
//

import UIKit

class RequestModel: Encodable {
    let q: String = "samsung"
    var pmin: Int?
    var pmax: Int?
    var wholesale: Bool?
    var official: Bool?
    var fshop: Int?
    var start: Int?
    let rows: Int = 10
    
    init(minPrice: Int, maxPrice: Int, wholesale: Bool, official: Bool, fshop: Int, start: Int) {
        self.pmin = minPrice
        self.pmax = maxPrice
        self.wholesale = wholesale
        self.official = official
        self.fshop = fshop
        self.start = start
    }
}

extension Encodable {
    func encode() -> Data? {
        let encoder = JSONEncoder()
        return try? encoder.encode(self)
    }
    
    func toKeyVal() -> [String: Any]? {
        if let data = self.encode() {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return [:]
    }
}
