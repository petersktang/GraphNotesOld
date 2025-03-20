//
//  PKCanvasViewController.swift
//  GraphNotesOld
//
//  Created by Peter Tang on 18/3/2025.
//
import UIKit
import PencilKit

class DrawingViewController: UIViewController {
    private lazy var toolPicker = PKToolPicker()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
extension DrawingViewController {
    func configureCanvas() {
        let pkcanvas = PKCanvasView(frame: .zero)
        pkcanvas.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pkcanvas)
        NSLayoutConstraint.activate([
            view.layoutMarginsGuide.topAnchor.constraint(equalTo: pkcanvas.frameLayoutGuide.topAnchor),
            view.layoutMarginsGuide.bottomAnchor.constraint(equalTo: pkcanvas.frameLayoutGuide.bottomAnchor),
            view.layoutMarginsGuide.leadingAnchor.constraint(equalTo: pkcanvas.frameLayoutGuide.leadingAnchor),
            view.layoutMarginsGuide.trailingAnchor.constraint(equalTo: pkcanvas.frameLayoutGuide.trailingAnchor),
        ])
        view.backgroundColor = .systemTeal
    }
}
