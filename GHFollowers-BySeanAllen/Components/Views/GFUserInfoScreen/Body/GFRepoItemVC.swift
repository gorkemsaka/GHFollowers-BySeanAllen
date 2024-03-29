//
//  GFRepoItemVC.swift
//  GHFollowers-BySeanAllen
//
//  Created by Gorkem Saka on 20.02.2024.
//

import UIKit

class GFRepoItemVC: GFItemInfoViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems(){
        itemInfoView1.setElements(itemInfoType: .repos, count: user.publicRepos)
        itemInfoView2.setElements(itemInfoType: .gists, count: user.publicGists)
        actionButton.setButton(color: .systemPurple, title: Theme.GFItems.repoItem.rawValue, systemImageName: "person.3" )
    }
    
    override func actionButtonTapped() {
        delegate.didTapGithubProfile(user: user)
    }
}
