//
//  HomeViewController.swift
//  DinDinn
//
//  Created by Elbert Valdian Hardika on 17/11/20.
//  Copyright © 2020 Elbert Valdian Hardika. All rights reserved.
//

import AsyncDisplayKit

class HomeViewController: ASViewController<ASDisplayNode> {
	
	// MARK: - Properties
	var presenter: ViewToPresenterHomeProtocol?
	var viewModel: HomeViewModel
	
	var mainNode: HomeNode
	
	init(viewModel: HomeViewModel) {
		self.viewModel = viewModel
		mainNode = HomeNode(viewModel: self.viewModel)
		super.init(node: mainNode)
		
		configureMainNode()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Lifecycle Methods
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "Menu"
		presenter?.fetchData()
		
	}
	
	private func configureMainNode() {
		mainNode.onTapAddToCart = { [weak self] (food: Food) in
			self?.presenter?.addToCart(food: food)
		}
		
		mainNode.onTapCart = { [weak self] in
			self?.presenter?.goToCart(navigationController: self?.navigationController ?? UINavigationController())
		}
	}
	
}

extension HomeViewController: PresenterToViewHomeProtocol{
    // TODO: Implement View Output Methods
	func reloadTable(data: [Food]) {
		mainNode.foodList = data
		mainNode.tableNode.reloadData()
	}
}
