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
        case getFollowersButton = "Get Followers"
        case alertButtonTitle = "Ok"
        case alertTitle = "Empty Username"
        case bodyTitle = "Please enter a username. Wee need to know who to look for 😁."
        
    }
    enum Size: CGFloat {
        case cornerRadius = 10
    }
    enum GFTextField: CGFloat {
        case minimumFontSize = 12
        case borderWith = 2
    }
}
