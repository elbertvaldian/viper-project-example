//
//  CartInteractor.swift
//  DinDinn
//
//  Created by Elbert Valdian Hardika on 19/11/20.
//  Copyright © 2020 Elbert Valdian Hardika. All rights reserved.
//

import Foundation

class CartInteractor: PresenterToInteractorCartProtocol {
	var viewModel: CartViewModel?
	

    // MARK: Properties
    var presenter: InteractorToPresenterCartProtocol?
}
