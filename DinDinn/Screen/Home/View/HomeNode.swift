//
//  HomeNode.swift
//  DinDinn
//
//  Created by Elbert Valdian Hardika on 17/11/20.
//  Copyright © 2020 Elbert Valdian Hardika. All rights reserved.
//

import Foundation
import AsyncDisplayKit
import RxSwift

class HomeNode: ASDisplayNode {
	var onTapAddToCart: ((Food) -> Void)?
	var onTapCart: (() -> Void)?

	let tableNode: ASTableNode = ASTableNode(style: .plain)
	var foodList: [Food] = []
	var viewModel: HomeViewModel
	var cartButton: ASButtonNode = ASButtonNode()
	var cartCount: Int = 0
	
	private let disposeBag: DisposeBag = DisposeBag()

	
	init(viewModel: HomeViewModel) {
		self.viewModel = viewModel
		super.init()
		
		configureCart()
		observeCart()
		automaticallyManagesSubnodes = true

	}
	
	
	override func didLoad() {
		super.didLoad()
		configureTable()
	}
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
//		configureSizing(constrainedSize: constrainedSize)
		
		let cartInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 16), child: makeCartSpec())
		let cartSpec =  ASStackLayoutSpec(direction: .vertical, spacing: 0, justifyContent: .end, alignItems: .end, children: [cartInset])
		
		let layoutElements: ASStackLayoutSpec = ASStackLayoutSpec(direction: .vertical, spacing: 0, justifyContent: .start, alignItems: .start, children: [tableNode])
		
		let overlay = ASOverlayLayoutSpec(child: layoutElements, overlay: cartSpec)
		
		return overlay
	}
	
	private func configureTable() {
		tableNode.style.flexGrow = 1.0
		
		tableNode.backgroundColor = .systemGray6
		tableNode.view.separatorStyle = .none
		tableNode.view.tableFooterView = UIView()
		tableNode.view.bounces = false
		tableNode.view.showsVerticalScrollIndicator = false
		tableNode.view.allowsSelection = false
		tableNode.dataSource = self
		tableNode.delegate = self
				
	}
	
	private func configureCart() {
		let cartImage = UIImage(named: "cart")?.resize(maxWidthHeight: 40)
		
		cartButton.setImage(cartImage, for: [])
		
		cartButton.contentHorizontalAlignment = .middle
		cartButton.contentVerticalAlignment = .center
		cartButton.backgroundColor = .white
		cartButton.cornerRadius = 40
		cartButton.addTarget(self, action: #selector(cartButtonTapped), forControlEvents: .touchUpInside)
		
		cartButton.style.preferredSize = CGSize(width: 80, height: 80)
	}
	
	private func makeCartSpec() -> ASLayoutSpec {
		let cartCountBackground: ASDisplayNode = ASDisplayNode()
		cartCountBackground.backgroundColor = .systemGreen
		cartCountBackground.style.preferredSize = CGSize(width: 16, height: 16)
		cartCountBackground.cornerRadius = 8
		
		let cartCountNode: ASTextNode = ASTextNode()
		let cartCount = "\(self.cartCount)"
		let range = NSMakeRange(0, cartCount.count)
		
		let mutableAttributedString = NSMutableAttributedString.init(string: cartCount)
		mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: range)

		cartCountNode.attributedText = mutableAttributedString
		
		let cardCountCenterSpec = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: .minimumXY, child: cartCountNode)
		let cardCountOverlaySpec = ASOverlayLayoutSpec(child: cartCountBackground, overlay: cardCountCenterSpec)
		
		let cornerSpec = ASCornerLayoutSpec(child: cartButton, corner: cardCountOverlaySpec, location: .topRight)
		cornerSpec.offset = CGPoint(x: -10, y: 10)
		
		let cartOnlySpec = ASStackLayoutSpec(direction: .horizontal, spacing: 0, justifyContent: .start, alignItems: .start, children: [cartButton])
		
		return self.cartCount > 0 ? cornerSpec : cartOnlySpec
	}
	
	private func configureSizing(constrainedSize: ASSizeRange) {
		cartButton.style.layoutPosition = CGPoint(x: constrainedSize.max.width - 16 - 80, y: constrainedSize.max.height - 16 - 80)
	}
	
	private func observeCart() {
		viewModel.carts.asObservable()
			.subscribe(onNext: { [weak self] carts in
				guard let self = self else {
					return
				}
				
				self.cartCount = carts.count
				self.refreshUI()
			}).disposed(by: disposeBag)
	}
	
	private func refreshUI() {
		self.layoutIfNeeded()
		self.setNeedsLayout()
		
	}
	
	@objc private func cartButtonTapped() {
		onTapCart?()
	}
	
}

extension HomeNode: ASTableDataSource, ASTableDelegate {
	
	func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
		
		return foodList.count 
	}
	
	func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
		return {
			let cellNode = FoodListCellNode(food: self.foodList[indexPath.row])
			cellNode.onTapAddToCart = { [weak self] (food: Food) in
				self?.onTapAddToCart?(food)
			}
			
			let cell: ASCellNode
			cell = cellNode
		
			
			cell.selectionStyle = .none
			
			return cell
		}
	}
	
}
