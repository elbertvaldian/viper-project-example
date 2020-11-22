//
//  FoodResponse.swift
//  DinDinn
//
//  Created by Elbert Valdian Hardika on 18/11/20.
//  Copyright © 2020 Elbert Valdian Hardika. All rights reserved.
//

import ObjectMapper

class FoodResponse: Mappable {
    var success: Bool?
    var foodList: [Food]?
    
	required init?(map: Map){

	}
    
    func mapping(map: Map) {
        success <- map["success"]
        foodList <- map["food_list"]
    }
}

class Food: Mappable {
    var id: String?
	var title: String?
	var brief: String?
    var price: Int?
    var imageUrl: String?
    
	required init?(map: Map){

	}
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        brief <- map["brief"]
		price <- map["price"]
        imageUrl <- map["image_url"]
    }
}
