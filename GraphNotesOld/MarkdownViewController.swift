//
//  ExploreViewController.swift
//  GraphNotesOld
//
//  Created by Peter Tang on 14/3/2025.
//
import UIKit

class MarkdownViewController: UIViewController {
    var index: Int
    init?(coder: NSCoder, index: Int) {
        self.index = index
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // navigationController?.hidesBarsOnSwipe = false
        configureSubviews()
        NSLog("\(#function) MarkdownViewController")
    }
}
extension MarkdownViewController {
    func configureSubviews() {
        let textview = UITextView(frame: .zero)
        textview.translatesAutoresizingMaskIntoConstraints = false
        textview.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        view.addSubview(textview)
        NSLayoutConstraint.activate([
            view.layoutMarginsGuide.topAnchor.constraint(equalTo: textview.frameLayoutGuide.topAnchor),
            view.layoutMarginsGuide.bottomAnchor.constraint(equalTo: textview.frameLayoutGuide.bottomAnchor),
            view.layoutMarginsGuide.leadingAnchor.constraint(equalTo: textview.frameLayoutGuide.leadingAnchor),
            view.layoutMarginsGuide.trailingAnchor.constraint(equalTo: textview.frameLayoutGuide.trailingAnchor),
        ])
    }
}
