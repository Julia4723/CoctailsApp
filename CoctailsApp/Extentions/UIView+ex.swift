//
//  UIView+ex.swift
//  CoctailsApp
//
//  Created by user on 28.06.2025.
//

import UIKit

extension UIView {
    func addViews(_ view: UIView...) {
        view.forEach{addSubview($0)}
    }
}
