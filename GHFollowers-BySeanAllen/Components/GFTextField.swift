//
//  GFTextField.swift
//  GHFollowers-BySeanAllen
//
//  Created by Gorkem Saka on 30.01.2024.
//

import UIKit

class GFTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = Theme.Size.cornerRadius.rawValue
        layer.borderWidth = Theme.GFTextField.borderWith.rawValue
        layer.borderColor = UIColor.systemGray4.cgColor
        
        textColor = .label
        tintColor = .label
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title2)
        
        //MARK: - if input gets longer, it's gonna resize itself
        adjustsFontSizeToFitWidth = true
        minimumFontSize = Theme.GFTextField.minimumFontSize.rawValue
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        
        placeholder = Theme.AppTitle.textFieldPlaceHolder.rawValue
    }
}
