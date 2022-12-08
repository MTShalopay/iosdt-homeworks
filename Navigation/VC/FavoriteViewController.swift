//
//  FavoriteViewController.swift
//  Navigation
//
//  Created by Shalopay on 27.11.2022.
//

import UIKit
import CoreData

class FavoriteViewController: UIViewController {

    let coreDataManager = CoreDataManager.shared
    var tableViewState: TableViewState = .normal
    var filterArray: [FavoriteItem] = []
    
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
        print("FavoriteViewController: \(tableViewState)")
        switch tableViewState {
        case .normal:
            print("viewWillAppear SWITCH tableViewState: \(tableViewState)")
        case .nsfetchedResultsController:
            print("viewWillAppear SWITCH tableViewState: \(tableViewState)")
        case .searchPost:
            print("viewWillAppear SWITCH tableViewState: \(tableViewState)")
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        setupNavigatonBar()
        
        print("viewWillAppear tableViewState: \(tableViewState)")
        switch tableViewState {
        case .normal:
            coreDataManager.reloadFolders()
            self.favoriteTableView.tableFooterView = UIView(frame: CGRect.zero)
            print("viewWillAppear SWITCH tableViewState: \(tableViewState)")
            self.favoriteTableView.reloadData()
        case .nsfetchedResultsController:
            self.favoriteTableView.tableFooterView = UIView(frame: CGRect.zero)
            print("viewWillAppear SWITCH tableViewState: \(tableViewState)")
            setupNSFetchResultsController()
            self.favoriteTableView.reloadData()
        case .searchPost:
            self.favoriteTableView.tableFooterView = UIView(frame: CGRect.zero)
            print("viewWillAppear SWITCH tableViewState: \(tableViewState)")
            self.favoriteTableView.reloadData()
        }
    }
    
    private func setupView() {
        coreDataManager.reloadFolders()
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
    private func setupNSFetchResultsController() {
        do {
            try coreDataManager.nsfetchedResultsController.performFetch()
            self.coreDataManager.nsfetchedResultsController.delegate = self
        } catch {
            print("ERROR for NSFetchResultsController: \(error)")
        }
    }
    private func setupNavigatonBar() {
        let searchPostBarButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchPost))
        let clearFilterBarButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(clearFilter))
        navigationItem.rightBarButtonItems = [clearFilterBarButton, searchPostBarButton]
    }
    
    @objc func searchPost() {
        switch tableViewState {
        case .normal:
            print("tableViewState: \(tableViewState)")
        case .searchPost:
            print("tableViewState: \(tableViewState)")
        case .nsfetchedResultsController:
            print("tableViewState: \(tableViewState)")
        }
        setupAlertController()
    }
    
    @objc func clearFilter() {
        switch tableViewState {
        case .normal:
            coreDataManager.reloadFolders()
            print("clearFilter tableViewState: \(tableViewState)")
            self.favoriteTableView.reloadData()
        case .searchPost:
            tableViewState = .normal
            coreDataManager.reloadFolders()
            print("clearFilter tableViewState: \(tableViewState)")
            self.favoriteTableView.reloadData()
        case .nsfetchedResultsController:
            tableViewState = .nsfetchedResultsController
        print("clearFilter tableViewState: \(tableViewState)")
            self.favoriteTableView.reloadData()
        }
    }
    
    private func setupAlertController() {
        let alertController = UIAlertController(title: "Сортировка по автору", message: "", preferredStyle: .alert)
            alertController.addTextField { textfield in
                textfield.placeholder = "имя автора"
            }
        let okButton = UIAlertAction(title: "Применить", style: .default) { action in
            let firstTexfield = alertController.textFields![0]
            guard firstTexfield.text != "" else {
                print("EMPTY textfiled")
                return
            }
            switch self.tableViewState {
            case .normal:
                print("SWITCH for normal")
                self.filterArray = self.coreDataManager.searchPost(authorName: firstTexfield.text!)
                self.tableViewState = .searchPost
                self.favoriteTableView.reloadData()
            case .searchPost:
                print("SWITCH for searchPost")
            case .nsfetchedResultsController:
                self.filterArray = self.coreDataManager.searchPost(authorName: firstTexfield.text!)
                print("SWITCH for nsfetchedResultsController")
            }
        }
        alertController.addAction(okButton)
        present(alertController, animated: true)
    }
}
    
extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableViewState {
        case .normal:
            print("NORMAL")
            return coreDataManager.items.count
        case .searchPost:
            print("SEARCHPOST")
            return filterArray.count
        case .nsfetchedResultsController:
            print("NSFETCHRESULTCONTROLLER")
            return coreDataManager.nsfetchedResultsController.sections?[section].numberOfObjects ?? 0
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
            let item = filterArray[indexPath.row]
            cell.setupCoreDataItems(with: item)
            cell.selectionStyle = .none
            cell.isUserInteractionEnabled = false
            return cell
        case .nsfetchedResultsController:
            let item = coreDataManager.nsfetchedResultsController.object(at: indexPath)
            cell.setupCoreDataItems(with: item)
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
                coreDataManager.reloadFolders()
                tableView.reloadData()
                print("DELETE in normal")
            case .searchPost:
                let item = filterArray[indexPath.row]
                filterArray.remove(at: indexPath.row)
                coreDataManager.deletePost(author: item)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.reloadData()
                print("DELETE in searchPost")
            case .nsfetchedResultsController:
                print("DELETE in nsfetchedResultsController")
                let item = coreDataManager.nsfetchedResultsController.object(at: indexPath)
                coreDataManager.deleteFolder(folder: item)
            }
        @unknown default:
            print("DEFAULT")
        }
    }
}


extension FavoriteViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
            switch tableViewState {
            case .nsfetchedResultsController:
                switch type {
                case .delete:
                    if let indexPath = indexPath {
                        print("delete NSFetchedResultsControllerDelegate")
                        return favoriteTableView.deleteRows(at: [indexPath], with: .automatic)
                    }
                case .insert:
                    if let indexPath = indexPath {
                    print("insert NSFetchedResultsControllerDelegate")
                    return favoriteTableView.insertRows(at: [indexPath], with: .automatic)
                    }
                case .move:
                    if let indexPath = indexPath {
                    print("move NSFetchedResultsControllerDelegate")
                    return favoriteTableView.moveRow(at: indexPath, to: newIndexPath!)
                    }
                case .update:
                    if let indexPath = indexPath {
                    return favoriteTableView.reloadRows(at: [indexPath], with: .automatic)
                    print("update NSFetchedResultsControllerDelegate")
                    }
                @unknown default:
                    print("default")
            }
            @unknown default:
                print("DEFAULT")
        }
    }
}

