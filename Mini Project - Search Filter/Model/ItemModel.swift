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
//    let wholesale_price: [
//    {
//    "count_min": 2,
//    "count_max": 5,
//    "price": "Rp 27.500"
//    }
//    ],
//    "condition": 1,
//    "preorder": 0,
//    "department_id": 71,
//    "rating": 100,
//    "is_featured": 0,
//    "count_review": 2,
//    "count_talk": 0,
//    "count_sold": 0,
//    "labels": [
//    {
//    "title": "Grosir",
//    "color": "#ffffff"
//    }
//    ],
//    "top_label": null,
//    "bottom_label": null,
    
    let original_price: String?
//    "discount_expired": "",
//    "discount_start": "",
//    "discount_percentage": 0,
//    "stock": 0
    
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

struct BadgeModel: Decodable {
    let title: String?
    let image_url: String?
    let show: Bool?
}
