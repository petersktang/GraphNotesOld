//
//  ScrollableCell.swift
//  GraphNotesOld
//
//  Created by Peter Tang on 11/3/2025.
//
import UIKit

internal class ScrollableCell: UITableViewCell {
    private lazy var childViews: [UILabel] = {
        return (0 ... 2).map { item in
            let v = UILabel()
            v.tag = item
            return v
        }
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
extension ScrollableCell: ConfigurableCell {
    func configureSubviews() {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        // scrollView.delegate = self

        contentView.addSubview(scrollView)
        NSLayoutConstraint.activate([
            contentView.layoutMarginsGuide.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor),
            contentView.layoutMarginsGuide.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor),
            contentView.layoutMarginsGuide.topAnchor.constraint(equalTo: scrollView.frameLayoutGuide.topAnchor),
            contentView.layoutMarginsGuide.bottomAnchor.constraint(equalTo: scrollView.frameLayoutGuide.bottomAnchor),
            scrollView.contentLayoutGuide.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor),
            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, multiplier: CGFloat(childViews.count))
        ])
        var prior: UIView?
        for child in childViews {
            child.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(child)

            if let prior = prior {
                NSLayoutConstraint.activate([
                    prior.trailingAnchor.constraint(equalTo: child.leadingAnchor)
                ])
            } else {
                NSLayoutConstraint.activate([
                    scrollView.contentLayoutGuide.leadingAnchor.constraint(equalTo: child.leadingAnchor)
                ])
            }
            
            NSLayoutConstraint.activate([
                child.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, multiplier: 1.0),
                child.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
                child.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor)
            ])
            
            if child == childViews.last {
                NSLayoutConstraint.activate([
                    child.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: 0)
                ])
            }
            prior = child
        }
        scrollView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Self.tapToFocus(_:))))
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
}
// extension ScrollableCell: UIScrollViewDelegate {
//     func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//         for (idx, child) in childViews.enumerated() {
//             let childCenter = contentView.convert(child.center, from: scrollView)
//             NSLog("\(#function) \(idx): \(childCenter) of \(contentView.bounds) \(contentView.bounds.contains(childCenter))")
//         }
//     }
// }
