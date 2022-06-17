//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Shalopay on 27.05.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var post: [Post] = [
        Post(author: "Табак Dark Side Core - SUPERNOVA (Холодок, 100 грамм)", description: "Отнесись с осторожностью! Взрывает мозг, как взрывается суперновая звезда. Концентрированный аромат ментолового льда, который невозможно курить соло. Применяется только в миксах в очень скромных пропорциях. Если переборщить, можно почувствовать себя Саб-Зиро.", image: "SUPERNOVA", likes: 112312, views: 13435345),
        Post(author: "Табак Dark Side Core - DARKSIDE COLA (Кола, 100 грамм)", description: "Столь насыщенной и яркой колы мы давненько уже не пробовали. По сути, сам вкус прост: сладость и кислинка. В том-то и дело, что эти два компонента должны объединяться в реально крутое сочетание, которое не оставляет никого равнодушным. И в данном случае у создателей это получилось. Убедись сам!", image: "COLA", likes: 112311, views: 13311),
        Post(author: "Табак Dark Side Core - BERGAMONSTR (Бергамонстр, 100 грамм)", description: "Один из топовых ароматов, который идеально миксуется с кислыми цитрусовыми табаками. Прекрасный бергамот, который, совсем не Эрл Грей, а только лишь отдаленно на него похож. Слегка терпковатый аромат с ярким послевкусием. Отлично сочетается с хорошим черным чаем!", image: "BERGAMONSTR ", likes: 222, views: 222),
        Post(author: "Табак Dark Side Core - MANGO LASSI (Манговый коктейль, 100 грамм)", description: "Насыщенный аромат тропического манго - спелого и сочного, освежающего и сладкого. Вкус, реально, прикольный, может показаться слегка приторным, но это лишь на первый взгляд. В целом, же удачный тропический вкус, которому, однако не хватает легкой кислинки.", image: "MANGOLASSI", likes: 333, views: 333)
    ]
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        //tableView.estimatedRowHeight = 220
        tableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: ProfileHeaderView.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "defaultcell")
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Профиль"
        self.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: "person.crop.square"), tag: 1)
        view.backgroundColor = .white
        setupView()
    }
    
    private func setupView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as? PostTableViewCell else { return tableView.dequeueReusableCell(withIdentifier: "defaultcell", for: indexPath) }
        let myPost = post[indexPath.row]
        cell.setup(with: myPost)
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileHeaderView.identifier) as? ProfileHeaderView else {return nil }
            return header
        default:
            return nil
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        220
    }
    
    
}
