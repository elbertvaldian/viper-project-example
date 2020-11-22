//
//  HomeContract.swift
//  DinDinn
//
//  Created by Elbert Valdian Hardika on 17/11/20.
//  Copyright © 2020 Elbert Valdian Hardika. All rights reserved.
//

import Foundation
import UIKit

// MARK: View Output (Presenter -> View)
protocol PresenterToViewHomeProtocol {
   func reloadTable(data: [Food])
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterHomeProtocol {
    
    var view: PresenterToViewHomeProtocol? { get set }
    var interactor: PresenterToInteractorHomeProtocol? { get set }
    var router: PresenterToRouterHomeProtocol? { get set }
	var viewModel: HomeViewModel? {get set}
	
	func fetchData()
	func addToCart(food: Food)
	func goToCart(navigationController: UINavigationController)
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorHomeProtocol {
    
    var presenter: InteractorToPresenterHomeProtocol? { get set }
	var viewModel: HomeViewModel? {get set}
	
	func fetchData()
	func addToCart(food: Food)
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterHomeProtocol {
    func reloadTable(data: [Food])
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterHomeProtocol {
    func goToCart(navigationController: UINavigationController, cartItem: [Food])
}
