//
//  Label.swift
//  LibraryMVP
//
//  Created by Сергей Штейман on 15.02.2022.
//

import UIKit

final class Label: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        numberOfLines = 3
        lineBreakMode = .byWordWrapping
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
