//
//  HomePresenter.swift
//  DinDinn
//
//  Created by Elbert Valdian Hardika on 17/11/20.
//  Copyright © 2020 Elbert Valdian Hardika. All rights reserved.
//

import Foundation
import UIKit

class HomePresenter: ViewToPresenterHomeProtocol {

    // MARK: Properties
    var view: PresenterToViewHomeProtocol?
    var interactor: PresenterToInteractorHomeProtocol?
    var router: PresenterToRouterHomeProtocol?
	var viewModel: HomeViewModel?
	
	func fetchData() {
		interactor?.fetchData()
	}
	
	func addToCart(food: Food) {
		interactor?.addToCart(food: food)
	}
	
	func goToCart(navigationController: UINavigationController) {
		guard let cart = viewModel?.carts.value, cart.count > 0 else {
			return
			
		}
		self.router?.goToCart(navigationController: navigationController, cartItem: cart)
		
	}
}

extension HomePresenter: InteractorToPresenterHomeProtocol {
	func reloadTable(data: [Food]) {
		view?.reloadTable(data: data)
	}
}
