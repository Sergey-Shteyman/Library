//
//  UITableViewCell.swift
//  LibraryMVP
//
//  Created by Сергей Штейман on 15.02.2022.
//

import UIKit

extension UITableViewCell {
    
    class var myReuseId: String {
        return String(describing: Self.self)
    }
}

