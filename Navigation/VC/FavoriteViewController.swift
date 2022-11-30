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
    
    let coreDataManager = CoreDataManager.shared
    var tableViewState: TableViewState = .normal
    
    private lazy var favoriteTableView: UITableView = {
        let tableview = UITableView(frame: .zero, style: .plain)
        tableview.backgroundColor = .clear
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "default")
        tableview.register(FavoriteTableViewCell.self, forCellReuseIdentifier: FavoriteTableViewCell.reuseIdentifier)
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
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigatonBar()
        print("CORE count: \(coreDataManager.items.count)")
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
        print(#function)
        setupAlertController()
    }
    @objc func clearFilter() {
        print(#function)
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
            self.coreDataManager.searchPost(name: firstTexfield.text!)
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
            return coreDataManager.searchPost.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.reuseIdentifier, for: indexPath) as? FavoriteTableViewCell else {
            let cellDefault = UITableViewCell(style: .default, reuseIdentifier: "default")
            return cellDefault
        }
        switch tableViewState {
        case .normal:
            let item = coreDataManager.items[indexPath.row]
            cell.favoriteImageView.image = UIImage(named: item.image ?? "COLA")
            cell.selectionStyle = .none
            cell.isUserInteractionEnabled = false
            cell.backgroundColor = .clear
            return cell
        case .searchPost:
            let item = coreDataManager.searchPost[indexPath.row]
            cell.favoriteImageView.image = UIImage(named: item.image ?? "COLA")
            cell.selectionStyle = .none
            cell.isUserInteractionEnabled = false
            cell.backgroundColor = .clear
            return cell
        }
//        let item = coreDataManager.items[indexPath.row]
//        cell.favoriteImageView.image = UIImage(named: item.image ?? "COLA")
//        cell.selectionStyle = .none
//        cell.isUserInteractionEnabled = false
//        cell.backgroundColor = .clear
//        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let item = coreDataManager.items[indexPath.row]
            coreDataManager.deleteFolder(folder: item)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            print("DELETE")
        @unknown default:
            print("DEFAULT")
        }
    }
}
