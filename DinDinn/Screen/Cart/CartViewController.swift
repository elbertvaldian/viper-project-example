//
//  CartViewController.swift
//  DinDinn
//
//  Created by Elbert Valdian Hardika on 19/11/20.
//  Copyright © 2020 Elbert Valdian Hardika. All rights reserved.
//

import AsyncDisplayKit

class CartViewController: ASViewController<ASDisplayNode> {
    
	// MARK: - Properties
	var presenter: ViewToPresenterCartProtocol?
	var viewModel: CartViewModel
	
	var mainNode: CartNode
	
	init(viewModel: CartViewModel) {
		self.viewModel = viewModel
		
		mainNode = CartNode(viewModel: self.viewModel)
		
		super.init(node: mainNode)
		configureMainNode()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
		
		presenter?.calculatePrice()
    }
	
	private func configureMainNode() {
		mainNode.onTapDeleteButton = { [weak self] (index: Int) in
			self?.presenter?.deleteItem(index: index)
		}
	}
    
}

extension CartViewController: PresenterToViewCartProtocol{
    // TODO: Implement View Output Methods
	func reloadTable() {
		mainNode.tableNode.reloadData()
	}
}
