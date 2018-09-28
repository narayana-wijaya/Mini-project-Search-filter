//
//  RequestModel.swift
//  Mini Project - Search Filter
//
//  Created by Narayana Wijaya on 26/09/18.
//  Copyright © 2018 Narayana Wijaya. All rights reserved.
//

import UIKit

class RequestModel {
    let q: String = "samsung"
    var pmin: Int?
    var pmax: Int?
    var wholesale: Bool?
    var official: Bool?
    var fshop: Int?
    var start: Int?
    let rows: Int = 10
    
    required init(from decoder: Decoder) throws {}
    
    enum CodingKeys: String, CodingKey {
        case q
        case pmin
        case pmax
        case wholesale
        case official
        case fshop
        case start
        case rows
    }
    
    init(minPrice: Int, maxPrice: Int, wholesale: Bool, official: Bool, fshop: Int, start: Int) {
        self.pmin = minPrice
        self.pmax = maxPrice
        self.wholesale = wholesale
        self.official = official
        self.fshop = fshop
        self.start = start
    }
    
    func reset(max: Int) {
        self.pmin = 0
        self.pmax = max
        self.wholesale = false
        self.official = false
        self.fshop = 1
        self.start = 0
    }
    
    func resetBadge() {
        self.official = false
        self.fshop = 1
    }
    
    var badgeList: [BadgeModel] {
        var badge: [BadgeModel] = []
        if let value = fshop {
            let goldBadge = BadgeModel(title: BadgeType.goldMerchant.rawValue, show: value == 2 ? true : false)
            badge.append(goldBadge)
        }
        if let official = official {
            let officialBadge = BadgeModel(title: BadgeType.officialStore.rawValue, show: official)
            badge.append(officialBadge)
        }
        return badge
    }
    
    func setGoldMerchat(_ bool: Bool?) {
        guard let bool = bool else { return }
        self.fshop = bool ? 2 : 1
    }
}

extension RequestModel: Codable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(q, forKey: .q)
        try container.encode(pmin, forKey: .pmin)
        try container.encode(pmax, forKey: .pmax)
        try container.encode(wholesale.toString(), forKey: .wholesale)
        try container.encode(official.toString(), forKey: .official)
        try container.encode(fshop, forKey: .fshop)
        try container.encode(start, forKey: .start)
        try container.encode(rows, forKey: .rows)
    }
}

enum BadgeType: String {
    case goldMerchant = "Gold Merchant"
    case officialStore = "Official Store"
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
