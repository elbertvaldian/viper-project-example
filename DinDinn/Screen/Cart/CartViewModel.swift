//
//  CartViewModel.swift
//  DinDinn
//
//  Created by Elbert Valdian Hardika on 20/11/20.
//  Copyright © 2020 Elbert Valdian Hardika. All rights reserved.
//

import RxSwift
import RxCocoa

final class CartViewModel {
	var carts: [Food]?
	var totalPrice: Int = 0
	
	private let disposeBag: DisposeBag = DisposeBag()
	
	init(cartItem: [Food]) {
		carts = cartItem
	}
	
}
