//
//  CollectionViewController.swift
//  GraphNotesOld
//
//  Created by Peter Tang on 9/4/2025.
//
import UIKit

class CollectionViewController: UICollectionViewController {
    private static let CellIdentifier = "Cell"
    private var count: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(Self.userDidPressTRrashButton(_:)))
        navigationItem.leftBarButtonItem?.isEnabled = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(Self.userDidPressAddButton(_:)))
        collectionView.register(ASHCollectionViewCell.self, forCellWithReuseIdentifier: Self.CellIdentifier)
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }
}
extension CollectionViewController {
    @objc func userDidPressAddButton(_ sender: UIBarButtonItem) {
        func traditionApproach() {
            count += 1
            enableBarButtons()
            collectionView.reloadData()
        }
        func incrementalApproach() {
            collectionView.performBatchUpdates { [weak self] in
                guard let self = self else { return }
                self.collectionView.insertItems(at: [IndexPath(item: self.count, section: 0)])
                self.count += 1
                enableBarButtons()
            }
        }
        incrementalApproach()
    }
    @objc func userDidPressTRrashButton(_ sender: UIBarButtonItem) {
        func traditionApproach() {
            if count > 0 {
                count -= 1
                enableBarButtons()
                collectionView.reloadData()
            }
        }
        navigationItem.leftBarButtonItem?.isEnabled = false
        navigationItem.rightBarButtonItem?.isEnabled = false
        
    }
    func enableBarButtons() {
        navigationItem.leftBarButtonItem?.isEnabled = count > 0
        navigationItem.rightBarButtonItem?.isEnabled = count < 10
    }
}
extension CollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.CellIdentifier, for: indexPath) as? ASHCollectionViewCell else { return UICollectionViewCell() }
        cell.contentView.backgroundColor = .systemYellow
        return cell
    }
}

class InfiniteScrollingCollectionViewController: UICollectionViewController {
    // https://www.tothenew.com/blog/infinite-scrolling-using-uicollectionview-in-swift/
}
