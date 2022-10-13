//
//  InfoViewController.swift
//  Navigation
//
//  Created by Shalopay on 27.05.2022.
//

import UIKit

class InfoViewController: UIViewController {
    var residentsArray = [String]()
    
    public var myTitle: String?
    public var myMessage: String?
    private lazy var button: UIButton = {
       let button = UIButton()
        button.backgroundColor = UIColor.blue
        button.layer.cornerRadius = 12
        button.setTitle("Нажми на меня", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
       let titleLabel = UILabel()
        titleLabel.text = ""
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    private lazy var residentsTable: UITableView = {
        let residentsTable = UITableView(frame: .zero, style: .grouped)
        residentsTable.register(UITableViewCell.self, forCellReuseIdentifier: "default")
        residentsTable.backgroundColor = .lightGray
        residentsTable.translatesAutoresizingMaskIntoConstraints = false
        residentsTable.separatorEffect = .none
        residentsTable.delegate = self
        residentsTable.dataSource = self
        return residentsTable
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createButton()
        self.view.backgroundColor = UIColor.white
        //MARK: Решение задачи 1
//        NetworkManager.requestBookingConfigure(for: 9, completion: { title in
//            DispatchQueue.main.async {
//                self.titleLabel.text = title ?? "Данные не полученны"
//            }
//        })
        //MARK: Решение задачи 2
        NetworkManager.getFetchPlanets(complited: { orbitalPeriod in
            DispatchQueue.main.async {
                self.titleLabel.text = "Период обращения планеты Татуин вокруг своей звезды составляет \(orbitalPeriod ?? "0") км" 
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NetworkManager.getPlanets(complited: { residents in
            guard let residents = residents else { return print("Ошибка в получении массива Имен") }
            self.residentsArray.append(contentsOf: residents)
            DispatchQueue.main.async {
                self.residentsTable.reloadData()
            }
        })
        
    }
    
    func createButton() {
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            titleLabel.heightAnchor.constraint(equalToConstant: 70)
        ])
        view.addSubview(residentsTable)
        NSLayoutConstraint.activate([
            residentsTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            residentsTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            residentsTable.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            residentsTable.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -15)
        ])
    }
    
    @objc func buttonAction(sender:UIButton) {
        print("Вызываем экшен команду")
        let alert = UIAlertController(title: myTitle, message: myMessage, preferredStyle: .alert)
        let buttonDefault = UIAlertAction(title: "Кабан", style: .default) { _ in
            print("Нажали на кабана")
        }
        let buttonCancel = UIAlertAction(title: "Свинья", style: .cancel) {_ in
            print("Нажали на свинью")
        }
        alert.addAction(buttonCancel)
        alert.addAction(buttonDefault)
        self.present(alert, animated: true) {
            print("Отображаем алерт")
        }
    }
}

extension InfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return residentsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "default", for: indexPath) as? UITableViewCell else { return tableView.dequeueReusableCell(withIdentifier: "default", for: indexPath) }
        let resident = residentsArray[indexPath.row]
        cell.textLabel?.text = "Name: \(resident)"
        cell.selectionStyle = .default
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
