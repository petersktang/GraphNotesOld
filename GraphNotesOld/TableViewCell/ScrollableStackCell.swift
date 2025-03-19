//
//  Untitled.swift
//  GraphNotesOld
//
//  Created by Peter Tang on 8/3/2025.
//
import UIKit

internal class ScrollableStackCell: UITableViewCell {
    private lazy var childViews: [UILabel] = {
        return (0 ... 2).map { _ in UILabel() }
    }()
    private var action: ((Int) -> (Void))?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSubviews()
    }
    @MainActor required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
extension ScrollableStackCell: ConfigurableCell {
    func configureSubviews() {
        
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: childViews)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 4

        contentView.addSubview(scrollView)
        scrollView.addSubview(stackView)
        NSLayoutConstraint.activate([
            contentView.layoutMarginsGuide.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor),
            contentView.layoutMarginsGuide.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor),
            contentView.layoutMarginsGuide.topAnchor.constraint(equalTo: scrollView.frameLayoutGuide.topAnchor),
            contentView.layoutMarginsGuide.bottomAnchor.constraint(equalTo: scrollView.frameLayoutGuide.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            
            scrollView.contentLayoutGuide.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor),
            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, multiplier: CGFloat(childViews.count))
        ])
        stackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Self.tapToFocus(_:))))
        scrollView.layer.cornerRadius = 20
    }
    
    func configure(_ value: Int, _ action: @escaping (Int) -> (Void)) {
        for (idx, cView) in childViews.enumerated() {
            cView.backgroundColor = [.systemRed, .systemOrange, .systemYellow, .systemGreen, .systemTeal, .systemBlue, .systemPurple].randomElement() ?? .systemBackground
            cView.text = "\(value)-\(idx)"
        }
        self.action = action
    }
    
    @objc func tapToFocus(_ sender: UITapGestureRecognizer) {
        tapped(recognizer: sender, on: childViews, with: action)
    }
    
    @objc func didSwipe(_ gesture: UISwipeGestureRecognizer) {
    }
}
