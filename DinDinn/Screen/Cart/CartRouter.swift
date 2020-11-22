//
//  CartRouter.swift
//  DinDinn
//
//  Created by Elbert Valdian Hardika on 19/11/20.
//  Copyright © 2020 Elbert Valdian Hardika. All rights reserved.
//

import Foundation
import UIKit

class CartRouter: PresenterToRouterCartProtocol {
    
    // MARK: Static methods
	static func createModule(cartItem: [Food]) -> UIViewController {
		
        let viewModel = CartViewModel(cartItem: cartItem)
		
        let viewController = CartViewController(viewModel: viewModel)
        
        let presenter: ViewToPresenterCartProtocol & InteractorToPresenterCartProtocol = CartPresenter()
        
		viewController.presenter = presenter
		viewController.presenter?.viewModel = viewModel
		viewController.presenter?.router = CartRouter()
		viewController.presenter?.view = viewController
		viewController.presenter?.interactor = CartInteractor()
		viewController.presenter?.interactor?.presenter = presenter
		viewController.presenter?.interactor?.viewModel = viewModel
        
        return viewController
    }
    
}
