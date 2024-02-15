//
//  GFButton.swift
//  GHFollowers-BySeanAllen
//
//  Created by Gorkem Saka on 30.01.2024.
//

import UIKit

class GFButton: UIButton {
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Custom init
    init(backgroundColor: UIColor, title: String?){
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = Theme.Size.cornerRadius.rawValue
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
    }
}
