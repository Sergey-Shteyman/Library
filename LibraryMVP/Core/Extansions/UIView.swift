//
//  UIView.swift
//  LibraryMVP
//
//  Created by Сергей Штейман on 14.02.2022.
//

import UIKit

extension UIView {
    
    func myAddSubView(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
    }
    
    func myAddSubViews(from array: [UIView]) {
        for view in array {
            myAddSubView(view)
        }
    }
    
    func addGradientLayer(with view: UIView) {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.cyan.cgColor,
                           UIColor.white.cgColor]
        gradient.locations = [0, 1]
        gradient.cornerRadius = 20.0
        self.layer.addSublayer(gradient)
    }
}
