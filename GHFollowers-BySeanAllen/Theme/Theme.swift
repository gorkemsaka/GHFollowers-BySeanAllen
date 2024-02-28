//
//  Theme.swift
//  GHFollowers-BySeanAllen
//
//  Created by Gorkem Saka on 30.01.2024.
//

import UIKit

struct Theme {
    enum AppTitle: String {
        case searchBarTitle = "Search"
        case favoriteBarTitle = "Favorite"
        case textFieldPlaceHolder = "Enter a username"
        case getFollowersButton = "Get Followers"
        case alertButtonTitle = "Ok"
    }
    enum GFError: String, Error{
        case alertTitle = "Empty Username"
        case alertBodyTitle = "Please enter a username. We need to know who to look for 😁."
        case urlErrorTitle = "This username created an invalid request. Please try again."
        case requestErrorTitle = "Unable to complete your request. Please check your internet connection"
        case responseErrorTtitle = "Invalid response from the server. Please try again."
        case dataErrorTitle = "The data received from the server was invalid. Please try again."
        case unableToFavorite = "There was an error when add favorite on this user. Please try again."
        case alreadyInFavorites = "You've already favorited this user."
    }
    enum SFSymbols{
        static let location = "mappin.and.ellipse"
        static let repos = "folder"
        static let gist = "text.alignleft"
        static let followers = "heart"
        static let following = "person.2"
    }
    enum Images {
        static let ghLogo = UIImage(named: "gh-logo")
    }
    enum GFItems: String {
        case repoItem = "Github Profile"
        case followerItem = "Get Followers"
    }
    enum Identifier: String {
        case followerCellID = "FollowerCell"
        case favoritesCellID = "FavoritesCell"
    }
    enum Size: CGFloat {
        case cornerRadius = 10
    }
    enum GFTextField: CGFloat {
        case minimumFontSize = 12
        case borderWith = 2
    }
}
