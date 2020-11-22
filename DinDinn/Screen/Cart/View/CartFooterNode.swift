//
//  CartFooterNode.swift
//  DinDinn
//
//  Created by Elbert Valdian Hardika on 21/11/20.
//  Copyright © 2020 Elbert Valdian Hardika. All rights reserved.
//

import Foundation
import AsyncDisplayKit

final class CartFooterNode: ASCellNode {
	
	private var deliveryPriceTextNode: ASTextNode = ASTextNode()
	private var totalPriceNode: ASTextNode = ASTextNode()
	
	private var totalPrice: Int
	
	init(totalPrice: Int) {
		self.totalPrice = totalPrice
		super.init()
		
		setupDeliveryPriceTextNode()
		setupTotalPriceNode()
		
		automaticallyManagesSubnodes = true
		selectionStyle = .none
	}
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		let mainStackSpec = ASStackLayoutSpec(direction: .vertical, spacing: 4, justifyContent: .start, alignItems: .start, children: [deliveryPriceTextNode, totalPriceNode])
		
		let mainInsetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 24, left: 24, bottom: 0, right: 24), child: mainStackSpec)
		
		return mainInsetSpec
	}
	
	
	private func setupDeliveryPriceTextNode() {
		let descriptionString = "Delivery is free"
		let range = NSMakeRange(0, descriptionString.count)
		
		let mutableAttributedString = NSMutableAttributedString.init(string: descriptionString)
		mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemGray3, range: range)

		deliveryPriceTextNode.attributedText = mutableAttributedString
	}
	
	private func setupTotalPriceNode() {
		let attributedText = NSMutableAttributedString(string: "Value: ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
		attributedText.append(NSAttributedString(string: "SGD \(totalPrice)", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)]))
		
		totalPriceNode.attributedText = attributedText
	}
	
}
