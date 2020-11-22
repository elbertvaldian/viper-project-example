//
//  CartListCellNode.swift
//  DinDinn
//
//  Created by Elbert Valdian Hardika on 20/11/20.
//  Copyright © 2020 Elbert Valdian Hardika. All rights reserved.
//

import Foundation
import AsyncDisplayKit

final class CartListCellNode: ASCellNode {
	
	var onTapDeleteButton: (() -> Void)?
	
	private var food: Food
	private var sidePadding: CGFloat = 8
	
	private var imageNode: ASNetworkImageNode = ASNetworkImageNode()
	private var titleNode: ASTextNode = ASTextNode()
	private var priceNode: ASTextNode = ASTextNode()
	
	private var deleteButtonNode: ASButtonNode = ASButtonNode()
	
	init(food: Food) {
		self.food = food
		super.init()
		
		setupImageNode()
		setupTitleNode()
		setupPriceNode()
		setupDeleteButtonNode()
		
		automaticallyManagesSubnodes = true
		selectionStyle = .none
	}
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		setupSizing(constrainedSize: constrainedSize)
		
		let mainStackSpec = ASStackLayoutSpec(direction: .horizontal, spacing: 8, justifyContent: .start, alignItems: .center, children: [imageNode, titleNode, priceNode, deleteButtonNode])
		
		let mainInsetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: sidePadding*2, left: 24, bottom: 0, right: 24), child: mainStackSpec)
		
		return mainInsetSpec
	}
	
	private func setupImageNode() {
		
		imageNode.url = URL(string: food.imageUrl ?? "")
	}
	
	private func setupTitleNode() {
		
		let attrs = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-medium", size: 14.0)]

		let string = NSAttributedString(string: food.title ?? "", attributes: attrs)

		titleNode.style.flexGrow = 1
		titleNode.attributedText = string
	}
	
	private func setupPriceNode() {
		let attrs = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-medium", size: 14.0)]

		let string = NSAttributedString(string: "SGD \(food.price ?? 0)", attributes: attrs)

		priceNode.attributedText = string
	}
	
	private func setupDeleteButtonNode() {
		
		let deleteImage = UIImage(named: "deleteBtn")?.resize(maxWidthHeight: 16)
		
		deleteButtonNode.setImage(deleteImage, for: [])
		
		deleteButtonNode.contentHorizontalAlignment = .middle
		deleteButtonNode.contentVerticalAlignment = .center
		deleteButtonNode.backgroundColor = .white
		deleteButtonNode.addTarget(self, action: #selector(deleteButtonTapped), forControlEvents: .touchUpInside)
		
		deleteButtonNode.style.preferredSize = CGSize(width: 16, height: 16)
	}
	
	private func makeBuyButton(constrainedSize: ASSizeRange) -> ASLayoutSpec {
		let stack = ASStackLayoutSpec(direction: .horizontal, spacing: 0, justifyContent: .end, alignItems: .end, children: [deleteButtonNode])
		stack.style.preferredSize = CGSize(width: constrainedSize.max.width, height: 40)
		
		return stack
	}
	
	@objc private func deleteButtonTapped() {
		self.onTapDeleteButton?()
		
	}

	private func setupSizing(constrainedSize: ASSizeRange) {
		imageNode.style.preferredSize = CGSize(width: 60, height: 60)
	}
	
}
