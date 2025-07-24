//
//  ContainerImageView.swift
//  CoctailsApp
//
//  Created by user on 11.07.2025.
//

import UIKit
import Kingfisher


final class ContainerImageView: UIView {
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(urlImage: String) {
        fetchImage(image: urlImage)
    }
    
    private func fetchImage(image: String) {
        let url = URL(string: image)
        let processor = ResizingImageProcessor(referenceSize: CGSize(width: 300, height: 300))
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: url,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
    
    private func setup() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        setupLayout()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
