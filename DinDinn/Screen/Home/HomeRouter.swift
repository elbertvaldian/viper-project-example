//
//  HomeRouter.swift
//  DinDinn
//
//  Created by Elbert Valdian Hardika on 17/11/20.
//  Copyright © 2020 Elbert Valdian Hardika. All rights reserved.
//

import Foundation
import UIKit

class HomeRouter: PresenterToRouterHomeProtocol {
    
    // MARK: Static methods
	static func createModule() -> UIViewController {
		let viewModel = HomeViewModel()
		let presenter: ViewToPresenterHomeProtocol & InteractorToPresenterHomeProtocol = HomePresenter()
		
		let viewController = HomeViewController(viewModel: viewModel)
		
		viewController.viewModel = viewModel
		viewController.presenter = presenter
		viewController.presenter?.viewModel = viewModel
		viewController.presenter?.router = HomeRouter()
		viewController.presenter?.view = viewController
		viewController.presenter?.interactor = HomeInteractor()
		viewController.presenter?.interactor?.presenter = presenter
		viewController.presenter?.interactor?.viewModel = viewModel
		
		let navigationController = UINavigationController(rootViewController: viewController)
		
		navigationController.navigationBar.prefersLargeTitles = false
		
		return navigationController
	}
	
	func goToCart(navigationController: UINavigationController, cartItem: [Food]) {
		let viewController = CartRouter.createModule(cartItem: cartItem)
        viewController.hidesBottomBarWhenPushed = true
		
        navigationController.pushViewController(viewController, animated: true)
	}
	
}
