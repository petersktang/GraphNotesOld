//
//  MyCustomHeader.swift
//  GraphNotesOld
//
//  Created by Peter Tang on 8/3/2025.
//
import UIKit

class MyCustomHeader: UITableViewHeaderFooterView {
    let title = UILabel()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContents() {
        title.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(title)
        // Center the image vertically and place it near the leading
        // edge of the view. Constrain its width and height to 50 points.
        NSLayoutConstraint.activate([
            title.heightAnchor.constraint(equalToConstant: 30),
            title.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 8),
            title.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Self.tapped(_:))))
    }
}
extension MyCustomHeader {
    @objc func tapped(_ gesture: UITapGestureRecognizer) {

    }
}
