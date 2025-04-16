//
//  KnowledgeViewController.swift
//  GraphNotesOld
//
//  Created by Peter Tang on 18/3/2025.
//

import UIKit

class MetaDataViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMetaDataView()
    }
    private weak var stackView: UIStackView?
}
extension MetaDataViewController {
    func configureMetaDataView() {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.text = "Hello World"
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Self.tapped(_:))))
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            scrollView.frameLayoutGuide.widthAnchor.constraint(equalTo: scrollView.contentLayoutGuide.widthAnchor),
            
            stackView.layoutMarginsGuide.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            stackView.layoutMarginsGuide.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            stackView.layoutMarginsGuide.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            stackView.layoutMarginsGuide.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        self.stackView = stackView
        
    }
    @objc func tapped(_ sender: UITapGestureRecognizer) {
        NSLog("\(#function)")
        let label = UILabel(frame: .zero)
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        let r = Int.random(in: 0...100)
        label.text = "random \(r)"
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.childTapped(_:))))
        label.isUserInteractionEnabled = true
        label.layer.borderWidth = 0.4
        label.layer.borderColor = UIColor.systemBlue.cgColor
        label.layer.cornerRadius = 15
        stackView?.addArrangedSubview(label)
    }
    @objc func childTapped(_ sender: UITapGestureRecognizer) {
        NSLog("\(#function) child tapped")
        if let targetView = stackView?.arrangedSubviews.first(where: {$0 == sender.view}) {
            targetView.isHidden = true
            DispatchQueue.main.async(execute: { [weak self] in
                self?.stackView?.removeArrangedSubview(targetView)
            })

        }
    }
    func configureMarkdownCanvas() {
        // scrollview
        // stackview
        // pkcanvas
        // imageView
    }
}
