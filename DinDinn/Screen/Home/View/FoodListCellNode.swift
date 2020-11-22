//
//  FoodListCellNode.swift
//  DinDinn
//
//  Created by Elbert Valdian Hardika on 17/11/20.
//  Copyright © 2020 Elbert Valdian Hardika. All rights reserved.
//

import Foundation
import AsyncDisplayKit

final class FoodListCellNode: ASCellNode {
	
	var onTapAddToCart: ((Food) -> Void)?
	
	private var food: Food
	private var sidePadding: CGFloat = 24
	
	private var backgroundNode: ASDisplayNode = ASDisplayNode()
	private var imageNode: ASNetworkImageNode = ASNetworkImageNode()
	private var titleNode: ASTextNode = ASTextNode()
	private var descriptionNode: ASTextNode = ASTextNode()
	
	private var buyButtonNode: ASButtonNode = ASButtonNode()
	
	init(food: Food) {
		self.food = food
		super.init()
		
		setupBackgroundNode()
		setupImageNode()
		setupTitleNode()
		setupDescriptionNode()
		setupBuyButtonNode()
		
		automaticallyManagesSubnodes = true
		selectionStyle = .none
	}
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		setupSizing(constrainedSize: constrainedSize)
		
		let contentNode = ASStackLayoutSpec(direction: .vertical, spacing: 8, justifyContent: .start, alignItems: .start, children: [titleNode, descriptionNode, makeBuyButton(constrainedSize: constrainedSize)])
		let contentInsetNode = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16), child: contentNode)
		
		let stack = ASStackLayoutSpec(direction: .vertical, spacing: 0, justifyContent: .start, alignItems: .start, children: [imageNode, contentInsetNode])
		
		let overlayNode = ASOverlayLayoutSpec(child: backgroundNode, overlay: stack)
		
		let mainNode = ASStackLayoutSpec(direction: .vertical, spacing: 0, justifyContent: .start, alignItems: .center, children: [overlayNode])
		let mainInsetNode = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0), child: mainNode)
		
		return mainInsetNode
	}
	
	private func setupBackgroundNode() {
	
		backgroundNode.backgroundColor = .white
		backgroundNode.cornerRadius = 12
	}
	
	private func setupImageNode() {
		
		imageNode.url = URL(string: food.imageUrl ?? "")
		imageNode.cornerRadius = 12
		imageNode.clipsToBounds = true
	}
	
	private func setupTitleNode() {
		
		let attrs = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 18.0)]

		let string = NSAttributedString(string: food.title ?? "", attributes: attrs)

		titleNode.attributedText = string
	}
	
	private func setupDescriptionNode() {
		let descriptionString = food.brief ?? ""
		let range = NSMakeRange(0, descriptionString.count)
		
		let mutableAttributedString = NSMutableAttributedString.init(string: descriptionString)
		mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemGray3, range: range)

		descriptionNode.attributedText = mutableAttributedString
	}
	
	private func setupBuyButtonNode() {
		
		let font = UIFont.systemFont(ofSize: 14, weight: .semibold)
		let defaultTitleAttributes: [NSAttributedString.Key: Any] = [
			NSAttributedString.Key.font: font,
			NSAttributedString.Key.foregroundColor: UIColor.white
		]
		
		let attributedTitle = NSAttributedString(
			string: "SGD \(food.price ?? 0)",
			attributes: defaultTitleAttributes
		)
		
		buyButtonNode.setAttributedTitle(attributedTitle, for: [])
		buyButtonNode.contentHorizontalAlignment = .middle
		buyButtonNode.contentVerticalAlignment = .center
		buyButtonNode.backgroundColor = .black
		buyButtonNode.cornerRadius = 20
		buyButtonNode.addTarget(self, action: #selector(buyButtonTapped), forControlEvents: .touchUpInside)
		
		buyButtonNode.style.preferredSize = CGSize(width: 80, height: 40)
	}
	
	private func makeBuyButton(constrainedSize: ASSizeRange) -> ASLayoutSpec {
		let stack = ASStackLayoutSpec(direction: .horizontal, spacing: 0, justifyContent: .end, alignItems: .end, children: [buyButtonNode])
		stack.style.preferredSize = CGSize(width: constrainedSize.max.width, height: 40)
		
		return stack
	}
	
	@objc private func buyButtonTapped() {
		buyButtonNode.backgroundColor = .systemGreen
		self.onTapAddToCart?(food)
		
		Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(revertBuyButtonTapped), userInfo: nil, repeats: false)

	}
	
	@objc private func revertBuyButtonTapped() {
		buyButtonNode.backgroundColor = .black

	}

	private func setupSizing(constrainedSize: ASSizeRange) {
		let containerWidth = constrainedSize.max.width - 2 * sidePadding
		
		backgroundNode.style.preferredSize = CGSize(width: containerWidth, height: containerWidth + 80)
		imageNode.style.preferredSize = CGSize(width: containerWidth, height: containerWidth - 40)
	}
	
}
