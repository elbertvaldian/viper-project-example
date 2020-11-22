//
//  CartPresenter.swift
//  DinDinn
//
//  Created by Elbert Valdian Hardika on 19/11/20.
//  Copyright © 2020 Elbert Valdian Hardika. All rights reserved.
//

import Foundation

class CartPresenter: ViewToPresenterCartProtocol {
	var viewModel: CartViewModel?
	

    // MARK: Properties
    var view: PresenterToViewCartProtocol?
    var interactor: PresenterToInteractorCartProtocol?
    var router: PresenterToRouterCartProtocol?
	
	func calculatePrice() {
		guard let cart = viewModel?.carts else {
			return
		}
		
		var price = 0
		
		for food in cart {
			let foodPrice = food.price ?? 0
			price = price + foodPrice
		}
		
		viewModel?.totalPrice = price
		view?.reloadTable()
	}
	
	func deleteItem(index: Int) {
		guard var cart = viewModel?.carts else {
			return
		}
		
		cart.remove(at: index)
		viewModel?.carts = cart
		calculatePrice()
	}
}

extension CartPresenter: InteractorToPresenterCartProtocol {
	
}
