//
//  CartNode.swift
//  DinDinn
//
//  Created by Elbert Valdian Hardika on 20/11/20.
//  Copyright © 2020 Elbert Valdian Hardika. All rights reserved.
//

import Foundation
import AsyncDisplayKit
import RxSwift

class CartNode: ASDisplayNode {
	var onTapDeleteButton: ((Int) -> Void)?
	
	let tableNode: ASTableNode = ASTableNode(style: .plain)
	
	var viewModel: CartViewModel
	
	init(viewModel: CartViewModel) {
		self.viewModel = viewModel
		super.init()
		
		backgroundColor = .white
		automaticallyManagesSubnodes = true

	}
	
	
	override func didLoad() {
		super.didLoad()
		configureTable()
	}
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {

		let layoutElements: ASStackLayoutSpec = ASStackLayoutSpec(direction: .vertical, spacing: 0, justifyContent: .start, alignItems: .start, children: [tableNode])

		return layoutElements
	}
	
	private func configureTable() {
		tableNode.style.flexGrow = 1.0
		
		tableNode.backgroundColor = .white
		tableNode.view.separatorStyle = .none
		tableNode.view.bounces = false
		tableNode.view.showsVerticalScrollIndicator = false
		tableNode.view.showsHorizontalScrollIndicator = false
		tableNode.view.allowsSelection = false
		tableNode.dataSource = self
		tableNode.delegate = self
				
	}
	
	private func refreshUI() {
		self.layoutIfNeeded()
		self.setNeedsLayout()
		
	}
	
}

extension CartNode: ASTableDataSource, ASTableDelegate {

	func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {

		return (viewModel.carts?.count ?? 0) + 1
	}

	func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
		return {
			
			guard let carts = self.viewModel.carts else {
				return ASCellNode()
			}
			
			
			
			
			var cell: ASCellNode = ASCellNode()
			
			if indexPath.row == carts.count {
				let totalNode = CartFooterNode(totalPrice: self.viewModel.totalPrice)
				
				cell = totalNode
			} else {
				let cellNode = CartListCellNode(food: carts[indexPath.row])
				cellNode.onTapDeleteButton = { [weak self] in
					self?.onTapDeleteButton?(indexPath.row)
				}
				
				cell = cellNode
			}
			
			
			cell.selectionStyle = .none
			
			return cell
		}
	}

}
