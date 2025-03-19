//
//  ViewController.swift
//  GraphNotesOld
//
//  Created by Peter Tang on 19/3/2025.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
    }
}
extension ViewController {
    func configureSubviews() {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tap me"
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        view.addSubview(label)
        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: label.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: label.centerYAnchor)
        ])
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Self.tapped(_:))))
    }
    @objc func tapped(_ sender: UITapGestureRecognizer) {
        let vc = main.instantiateViewController(identifier: TableViewController.uniqueIdentifier)
        navigationController?.pushViewController(vc, animated: true)
    }
}
