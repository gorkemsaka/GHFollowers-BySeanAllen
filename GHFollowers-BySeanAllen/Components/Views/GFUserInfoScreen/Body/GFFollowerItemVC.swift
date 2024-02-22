//
//  GFFollowerItemVC.swift
//  GHFollowers-BySeanAllen
//
//  Created by Gorkem Saka on 20.02.2024.
//

import UIKit

class GFFollowerItemVC: GFItemInfoViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems(){
        itemInfoView1.setElements(itemInfoType: .followers, count: user.followers)
        itemInfoView2.setElements(itemInfoType: .following, count: user.following)
        actionButton.setButton(backgroundColor: .systemGreen, title: Theme.GFItems.followerItem.rawValue)
    }
    
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(user: user)
    }
}
