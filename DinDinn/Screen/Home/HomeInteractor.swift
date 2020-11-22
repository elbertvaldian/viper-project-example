//
//  HomeInteractor.swift
//  DinDinn
//
//  Created by Elbert Valdian Hardika on 17/11/20.
//  Copyright © 2020 Elbert Valdian Hardika. All rights reserved.
//

import Foundation
//import AlamofireObjectMapper
import Alamofire
import ObjectMapper

class HomeInteractor: PresenterToInteractorHomeProtocol {

    // MARK: Properties
    var presenter: InteractorToPresenterHomeProtocol?
	var viewModel: HomeViewModel?
	
	func fetchData() {
		let URL = "https://pastebin.com/raw/4Pfkzkrn"
		
		AF.request(URL).responseString { [weak self] response in
			guard let responseString = response.value,
				let respond = Mapper<FoodResponse>().map(JSONString: responseString),
				let foodList = respond.foodList else {
				return
			}
			print(foodList)
			self?.presenter?.reloadTable(data: foodList)
		}
		
	}
	
	func addToCart(food: Food) {
		guard var cart = viewModel?.carts.value else {
			return
		}
		
		cart.append(food)
		viewModel?.carts.accept(cart)
	}
}
