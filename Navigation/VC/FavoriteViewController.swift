//
//  FavoriteViewController.swift
//  Navigation
//
//  Created by Shalopay on 27.11.2022.
//

import UIKit
import CoreData

class FavoriteViewController: UIViewController {
    enum TableViewState {
        case normal, searchPost
    }
    private var nsfetchedResultsController: NSFetchedResultsController<FavoriteItem> = {
        
    }()

    
    
    
    let coreDataManager = CoreDataManager.shared
    var tableViewState: TableViewState = .normal
    
    private lazy var favoriteTableView: UITableView = {
        let tableview = UITableView(frame: .zero, style: .plain)
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "default")
        tableview.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        tableview.alwaysBounceVertical = false
        tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = 40
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.dataSource = self
        tableview.delegate = self
        return tableview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewState = .normal
        setupView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigatonBar()
        favoriteTableView.reloadData()
    }
    
    private func setupView() {
        title = "Сохраненные"
        view.backgroundColor = UIColor.gray
        view.addSubview(favoriteTableView)
        NSLayoutConstraint.activate([
            favoriteTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            favoriteTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            favoriteTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            favoriteTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    private func setupNavigatonBar() {
        let searchPostBarButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchPost))
        let clearFilterBarButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(clearFilter))
        navigationItem.rightBarButtonItems = [clearFilterBarButton, searchPostBarButton]
    }
    
    @objc func searchPost() {
        setupAlertController()
    }
    @objc func clearFilter() {
        tableViewState = .normal
        self.favoriteTableView.reloadData()
    }
    
    private func setupAlertController() {
        let alertController = UIAlertController(title: "Введите имя", message: "", preferredStyle: .alert)
            alertController.addTextField { textfield in
                textfield.placeholder = "имя сортировки"
            }
        let okButton = UIAlertAction(title: "Применить", style: .default) { action in
            let firstTexfield = alertController.textFields![0]
                self.tableViewState = .searchPost
                self.coreDataManager.searchPost(authorName: firstTexfield.text!)
                print(self.coreDataManager.searchPosts.count)
                self.favoriteTableView.reloadData()
        }
        alertController.addAction(okButton)
        present(alertController, animated: true)
    }

}
extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableViewState {
        case .normal:
            return coreDataManager.items.count
        case .searchPost:
            return coreDataManager.searchPosts.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as? PostTableViewCell else { return tableView.dequeueReusableCell(withIdentifier: "defaultcell", for: indexPath) }
        switch tableViewState {
        case .normal:
            let item = coreDataManager.items[indexPath.row]
            cell.setupCoreDataItems(with: item)
            cell.selectionStyle = .none
            cell.isUserInteractionEnabled = false
            return cell
        case .searchPost:
            let item = coreDataManager.searchPosts[indexPath.row]
            cell.setupCoreDataItems(with: item)
            cell.selectionStyle = .none
            cell.isUserInteractionEnabled = false
            return cell
        }
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            switch tableViewState {
            case .normal:
                let item = coreDataManager.items[indexPath.row]
                coreDataManager.deleteFolder(folder: item)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                print("DELETE")
            case .searchPost:
                
                //tableView.deleteRows(at: [indexPath], with: .automatic)
                print("DELETE")
            }
        @unknown default:
            print("DEFAULT")
        }
    }
}
