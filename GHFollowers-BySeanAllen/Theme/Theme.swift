//
//  Theme.swift
//  GHFollowers-BySeanAllen
//
//  Created by Gorkem Saka on 30.01.2024.
//

import Foundation

struct Theme {
    enum AppTitle: String {
        case searchBarTitle = "Search"
        case favoriteBarTitle = "Favorite"
        case textFieldPlaceHolder = "Enter a username"
    }
    enum Size: CGFloat {
        case cornerRadius = 10
    }
    enum GFTextField: CGFloat {
        case minimumFontSize = 12
        case borderWith = 2
    }
}
