//
//  UITableView+Ext.swift
//  GHFollowers-BySeanAllen
//
//  Created by Gorkem Saka on 6.03.2024.
//

import UIKit

extension UITableView {
    // Empty cells doesn't gonna show up
    func removeExcessCells(){
        tableFooterView = UIView(frame: .zero)
    }
    
    // reloadData on Mainthread
    func reloadDataOnMainThread(){
        DispatchQueue.main.async { self.reloadData() }
    }
}
