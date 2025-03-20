//
//  ViewController.swift
//  GraphNotesOld
//
//  Created by Peter Tang on 22/1/2025.
//

import UIKit

class TableViewController: UIViewController {
    static let reuseCellIdentifier = "DefaultCell"
    static let reuseSectionHeader = "sectionHeader"
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var datasource = configureDatasource(tableView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        DispatchQueue.main.async { [weak self] in
            self?.populateDatasource()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnSwipe = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.hidesBarsOnSwipe = false
    }
}

extension TableViewController {
    func configureTableView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: tableView.topAnchor),
            view.bottomAnchor.constraint(equalTo: tableView.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor)
        ])
        tableView.register(ScrollableStackCell.self, forCellReuseIdentifier: Self.reuseCellIdentifier)
        tableView.register(MyCustomHeader.self, forHeaderFooterViewReuseIdentifier: Self.reuseSectionHeader)
        
        tableView.delegate = self
        self.tableView = tableView
    }
    func configureDatasource(_ tableView: UITableView) -> UITableViewDiffableDataSource<String, Int> {
        UITableViewDiffableDataSource(tableView: tableView) { tableView, indexPath, itemValue in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Self.reuseCellIdentifier, for: indexPath) as? any ConfigurableCell<Int> else {
                fatalError("\(#function) unable to dequeue cell \(Self.reuseCellIdentifier) that conforms to ConfigurableCell")
            }
            cell.configure(itemValue) { [weak self] index in
                self?.pushChildController(index)
            }
            return cell
        }
    }
    func populateDatasource() {
        var snapshot = NSDiffableDataSourceSnapshot<String, Int>()
        snapshot.appendSections(["AA", "BB"])
        snapshot.appendItems([1,2,3,4,5], toSection: "AA")
        snapshot.appendItems([6,7,8,9,10], toSection: "BB")
        datasource.apply(snapshot)
    }
}

extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        view.layoutMarginsGuide.layoutFrame.size.height*0.9
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: Self.reuseSectionHeader) as? MyCustomHeader else {
            return nil
        }
        view.title.text = "Section: \(section)"
        view.title.font = UIFont.preferredFont(forTextStyle: .extraLargeTitle)
        return view
    }
}
extension TableViewController {
    func pushChildController(_ index: Int) {
        NSLog("\(#function) \(index) pushed")
        let vc: UIViewController
        switch index {
        case 0: vc = main.instantiateViewController(identifier: MarkdownViewController.uniqueIdentifier, creator: { coder in
            return MarkdownViewController(coder: coder, index: index)
        })
        case 1: vc = main.instantiateViewController(identifier: DrawingViewController.uniqueIdentifier, creator: { coder in
            return DrawingViewController(coder: coder)
        })
        case 2: vc = main.instantiateViewController(identifier: KnowledgeViewController.uniqueIdentifier, creator: { coder in
            return KnowledgeViewController(coder: coder)
        })
        default:
            fatalError("\(#function) unexpected child view controller to push")
        }
        navigationController?.pushViewController(vc, animated: false)
    }
}
