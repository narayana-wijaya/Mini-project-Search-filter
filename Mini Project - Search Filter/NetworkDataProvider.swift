//
//  NetworkDataProvider.swift
//  Mini Project - Search Filter
//
//  Created by Narayana Wijaya on 26/09/18.
//  Copyright © 2018 Narayana Wijaya. All rights reserved.
//

import UIKit
import Alamofire

class NetworkDataProvider {
    func getData(params: [String: Any], _ completion: @escaping ([ItemModel]) -> Void, failure: @escaping (String) -> Void) {
        let baseUrl = "https://ace.tokopedia.com/search/v2.5/product"
        let request = Alamofire.request(URL(string: baseUrl)!, method: .get, parameters: params, encoding: URLEncoding.queryString, headers: nil)
        request.responseJSON { (response) in
            switch response.result {
            case .success:
                if let serverResponse = response.response {
                    switch serverResponse.statusCode {
                    case 200:
                        do {
                            let responseModel: ResponseServerModel = try JSONDecoder().decode(ResponseServerModel.self, from: response.data!)
                            DispatchQueue.main.async {
                                completion(responseModel.data ?? [])
                            }
                        } catch let jsonErr {
                            failure(jsonErr.localizedDescription)
                        }
                    default:
                        do {
                            let responseModel: ResponseServerModel = try JSONDecoder().decode(ResponseServerModel.self, from: response.data!)
                            failure(responseModel.status?.message ?? "")
                        } catch let jsonErr {
                            failure(jsonErr.localizedDescription)
                        }
                    }
                }
            case let .failure(error):
                failure(error.localizedDescription)
            }
            
        }
    }
}
