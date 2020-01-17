//
//  FoodApiManager.swift
//  RiviFood
//
//  Created by mysmac_adm!n on 15/01/20.
//  Copyright © 2020 Mridula. All rights reserved.
//

import Foundation
import ObjectMapper

class FoodApiManager : ApiManager
{
    typealias getFoodDetailsCallback = (DataModel?, Error?) -> Void
    class func getFoodDetails(onCompletion: @escaping getFoodDetailsCallback) {
        
        let url = ApiUrl
        executeRequest1(url) { (response) in
            switch response {
            case .Success(let json):
                print("Success")
                if let Response = Mapper<DataModel>().map(JSONString: json as! String){
                    onCompletion(Response, nil)
                }
            case .Failure(let error):
                onCompletion(nil, error)
            }
        }
    }
}


