//
//  ASHCollectionViewCell.swift
//  GraphNotesOld
//
//  Created by Peter Tang on 8/4/2025.
//
import UIKit

class ASHCollectionViewCell: UICollectionViewCell {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: bounds.insetBy(dx: 5, dy: 5))
        imageView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
    public func setImage(_ image: UIImage) {
        self.imageView.image = image
    }
}
