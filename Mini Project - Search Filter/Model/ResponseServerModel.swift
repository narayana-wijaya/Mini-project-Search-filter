//
//  ResponseServerModel.swift
//  Mini Project - Search Filter
//
//  Created by Narayana Wijaya on 26/09/18.
//  Copyright © 2018 Narayana Wijaya. All rights reserved.
//

import UIKit

struct ResponseServerModel: Decodable {
    let status: ResponseStatusModel?
    let data: [ItemModel]?
}

struct ResponseStatusModel: Decodable {
    let error_code: Int?
    let message: String?
}
