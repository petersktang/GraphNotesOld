//
//  ConfigurableCell.swift
//  GraphNotesOld
//
//  Created by Peter Tang on 8/3/2025.
//
import UIKit

internal protocol ConfigurableCell<Value>: UITableViewCell {
    associatedtype Value
    func configure(_ value: Value, _ action: @escaping (Int) -> (Void))
}
extension ConfigurableCell {
    func tapped(recognizer sender: UITapGestureRecognizer, on childViews: [UIView], `with` action: ((Int) -> Void)?) {
        if let location = (0 ..< sender.numberOfTouches).map({ index in
            sender.location(ofTouch: index, in: sender.view)
        }).first, let childView = childViews.first(where: {
            $0.frame.contains(location)
        }), let scrollView = sender.view?.superview as? UIScrollView {
            let childFrame = childView.frame
            let childFrameContentView = contentView.convert(childFrame, from: sender.view)
            let childFrameScrollView = scrollView.convert(childFrame, from: sender.view)
            if contentView.bounds.contains(childFrameContentView), let index = childViews.firstIndex(of: childView) {
                action?(index)
            } else {
                scrollView.scrollRectToVisible(childFrameScrollView, animated: true)
            }
            
        }
    }
}
