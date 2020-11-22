//
//  HomeViewModel.swift
//  DinDinn
//
//  Created by Elbert Valdian Hardika on 18/11/20.
//  Copyright © 2020 Elbert Valdian Hardika. All rights reserved.
//

import RxSwift
import RxCocoa

final class HomeViewModel {
	var carts: BehaviorRelay<[Food]> = BehaviorRelay<[Food]>(value: [])
	
	private let disposeBag: DisposeBag = DisposeBag()
	
	init() {
		
	}
	
}
