//
//  UIImageView+ex.swift
//  CoctailsApp
//
//  Created by user on 10.07.2025.
//

import UIKit

extension UIImageView {
    static func makeImage(named imageName: String = "image", cornerRadius: CGFloat) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = cornerRadius
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
}
