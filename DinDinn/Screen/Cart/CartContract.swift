//
//  CartContract.swift
//  DinDinn
//
//  Created by Elbert Valdian Hardika on 19/11/20.
//  Copyright © 2020 Elbert Valdian Hardika. All rights reserved.
//

import Foundation


// MARK: View Output (Presenter -> View)
protocol PresenterToViewCartProtocol {
   func reloadTable()
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterCartProtocol {
    
    var view: PresenterToViewCartProtocol? { get set }
    var interactor: PresenterToInteractorCartProtocol? { get set }
    var router: PresenterToRouterCartProtocol? { get set }
	var viewModel: CartViewModel? {get set}
	
	func calculatePrice()
	func deleteItem(index: Int)
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorCartProtocol {
    
    var presenter: InteractorToPresenterCartProtocol? { get set }
	var viewModel: CartViewModel? {get set}
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterCartProtocol {
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterCartProtocol {
    
}
