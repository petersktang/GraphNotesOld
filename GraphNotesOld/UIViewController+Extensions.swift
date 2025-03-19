//
//  UIViewController+Extensions.swift
//  GraphNotesOld
//
//  Created by Peter Tang on 16/3/2025.
//

import UIKit

extension UIViewController {
    var main: UIStoryboard {
        UIStoryboard(name: "Main", bundle: nil)
    }
    class var uniqueIdentifier: String {
        String(describing: self)
    }
}
