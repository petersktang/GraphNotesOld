//
//  ASHNewtonianCollectionViewLayout.swift
//  GraphNotesOld
//
//  Created by Peter Tang on 8/4/2025.
//
import UIKit

class ASHNewtonianCollectionViewLayout: UICollectionViewLayout {
    
    private lazy var dynamicAnimator = UIDynamicAnimator(collectionViewLayout: self)
    private weak var gravityBehavior: UIGravityBehavior?
    private weak var collisionBehavior: UICollisionBehavior?
    
    override init() {
        super.init()
        initBehaviors()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initBehaviors()
    }
    func initBehaviors() {
        let gBehaviour = UIGravityBehavior(items: [])
        dynamicAnimator.addBehavior(gBehaviour)
        gravityBehavior = gBehaviour
        let cBehaviour = UICollisionBehavior(items: [])
        dynamicAnimator.addBehavior(cBehaviour)
        collisionBehavior = cBehaviour
        
        NSLog("\(#function) count: \(dynamicAnimator.behaviors.count)")
    }
    override var collectionViewContentSize: CGSize {
        collectionView?.bounds.size ?? .zero
    }
    
    static let kItemSIze: CGFloat = 100.0
    public var attachmentPoint: CGPoint {
        guard let collectionView = collectionView else { return .zero }
        return CGPoint(x: collectionView.bounds.midX, y: 64)
    }
    override func prepare(forCollectionViewUpdates updateItems: [UICollectionViewUpdateItem]) {
        super.prepare(forCollectionViewUpdates: updateItems)
        guard let collectionView = collectionView else { return }
        for updateItem in updateItems where updateItem.updateAction == .insert {
            if let indexPath = updateItem.indexPathAfterUpdate {
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = CGRect(x: collectionView.frame.maxX + Self.kItemSIze, y: 300, width: Self.kItemSIze, height: Self.kItemSIze)
                
                let attachmentBehaviour = UIAttachmentBehavior(item: attributes, attachedToAnchor: attachmentPoint)
                attachmentBehaviour.length = 300.0
                attachmentBehaviour.damping = 0.4
                attachmentBehaviour.frequency = 1.0
                dynamicAnimator.addBehavior(attachmentBehaviour)
                
                NSLog("\(#function) counts=\(dynamicAnimator.behaviors.count)")
                
                gravityBehavior?.addItem(attributes)
                collisionBehavior?.addItem(attributes)
            }
        }
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        dynamicAnimator.items(in: rect) as? [UICollectionViewLayoutAttributes]
    }
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        dynamicAnimator.layoutAttributesForCell(at: indexPath)
    }
    public func detachItem(at indexPath: IndexPath, completion: @escaping () -> Void) {
        var attachmentBehavior: UIAttachmentBehavior? = nil
        var attributes: UICollectionViewLayoutAttributes? = nil
        NSLog("\(#function) counts=\(dynamicAnimator.behaviors.count)")
        for behavior in dynamicAnimator.behaviors {
            if let behavior = behavior as? UIAttachmentBehavior,
               let attributesList = behavior.items as? [UICollectionViewLayoutAttributes],
                let attr = attributesList.first(where: {$0.indexPath == indexPath}) {
                attachmentBehavior = behavior
                attributes = attr
                NSLog("\(#function) captured \(indexPath)")
                break
            }
        }
        if let attachmentBehavior = attachmentBehavior {
            dynamicAnimator.removeBehavior(attachmentBehavior)
        }
        if let attributes = attributes {
            DispatchQueue.main.async { [weak self] in
                self?.collisionBehavior?.removeItem(attributes)
                self?.gravityBehavior?.removeItem(attributes)
                self?.collectionView?.performBatchUpdates({ [weak self] in
                    completion()
                    self?.collectionView?.deleteItems(at: [indexPath])
                }, completion: nil)
            }
        }
    }
}
