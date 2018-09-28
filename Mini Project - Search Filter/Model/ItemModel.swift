//
//  ItemModel.swift
//  Mini Project - Search Filter
//
//  Created by Narayana Wijaya on 26/09/18.
//  Copyright © 2018 Narayana Wijaya. All rights reserved.
//

import UIKit

struct ItemModel: Decodable {
    let id: Int?
    let name: String?
    let uri: String?
    let image_uri: String?
    let image_uri_700: String?
    let price: String?
    let price_range: String?
    let category_breadcrumb: String?
    let shop: ShopModel?
    let badges: [BadgeModel]?
    let original_price: String?
}

struct ShopModel: Decodable {
    let id: Int?
    let name: String?
    let uri: String?
    let is_gold: Int?
    let rating: Int?
    let location: String?
    let reputation_image_uri: String?
    let shop_lucky: String?
    let city: String?
}

class BadgeModel: Decodable {
    let title: String?
    let image_url: String?
    let show: Bool?
    
    init(title: String, show: Bool) {
        self.title = title
        self.image_url = ""
        self.show = show
    }
}
