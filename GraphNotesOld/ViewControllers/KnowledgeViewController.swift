//
//  KnowledgeViewController.swift
//  GraphNotesOld
//
//  Created by Peter Tang on 18/3/2025.
//

import UIKit

class KnowledgeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
    }
    private var stackview: UIStackView?
}
extension KnowledgeViewController {
    func configureSubviews() {
        let question = UITextField(frame: .zero)
        question.text = "Question"
        question.backgroundColor = .systemYellow
        question.font = UIFont.preferredFont(forTextStyle: .title3)
        let answer = UITextView(frame: .zero)
        answer.text = "Answer"
        answer.layer.borderColor = UIColor.systemRed.cgColor
        answer.font = UIFont.preferredFont(forTextStyle: .body)
        answer.layer.borderWidth = 0.4
        let stackview = UIStackView(arrangedSubviews: [question, answer])
        stackview.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackview)
        NSLayoutConstraint.activate([
            stackview.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            stackview.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            stackview.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            stackview.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
        self.stackview = stackview
        configureAxis()
    }
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        configureAxis()
    }
    func configureAxis() {
        stackview?.axis = UIDevice.current.orientation.isPortrait ? .vertical : .horizontal
    }
}
