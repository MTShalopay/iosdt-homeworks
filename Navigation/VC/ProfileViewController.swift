//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Shalopay on 27.05.2022.
//

import UIKit
import StorageService
import SnapKit

class ProfileViewController: UIViewController {
    let coreDataManager = CoreDataManager.shared
    var indexSelectedRow: Int?
    
    private lazy var tappingImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "addFavorite")
        imageView.alpha = 0
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let post = Post.setupPost()
    let headerView = ProfileHeaderView()
    var startPointAvatar: CGPoint?
    var cornerRadiusAvatar: CGFloat?
    
    public lazy var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.image = headerView.user.avatar
        avatarImageView.layer.cornerRadius = 40
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.alpha = 0
        avatarImageView.isUserInteractionEnabled = true
        return avatarImageView
    }()
    
    private lazy var cancelButton: UIImageView = {
        let cancelButton = UIImageView()
        cancelButton.image = UIImage(systemName: "multiply")
        cancelButton.isUserInteractionEnabled = true
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        return cancelButton
    }()
    
    private lazy var fullscreenBackView: UIView = {
        let fullscreenBackView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        fullscreenBackView.alpha = 0
        fullscreenBackView.backgroundColor = .black
        fullscreenBackView.isUserInteractionEnabled = true
        fullscreenBackView.translatesAutoresizingMaskIntoConstraints = false
        return fullscreenBackView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 100
        tableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: ProfileHeaderView.identifier)
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "defaultcell")
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.alwaysBounceVertical = false
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
         Задача 2

         Создайте дубликат текущей схемы (Scheme) проекта и назовите его Release. Для этой новой схемы в пункте меню Product > Scheme > Edit scheme установите build configuration как Release. В зависимости от выбранной схемы ваш проект должен запускаться или в Debug или в Release конфигурации.
         Для фона экрана в ProfileViewController настройте разный цвет фона для Debug и Release конфигурации с помощью специального флага компиляции DEBUG.
         Запустите проект в обеих схемах и проверьте, что цвет фона автоматически меняется в зависимости от выбранной конфигурации.
        */
        //MARK: Решиение задачи 2
        #if DEBUG
        view.backgroundColor = .white
        #else
        view.backgroundColor = .red
        #endif
        setupView()
        setupGestures()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.tabBarItem.title = "Профиль"
        navigationController?.tabBarItem.image = UIImage(systemName: "person.crop.square")
        navigationController?.tabBarItem.tag = 1
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        startPointAvatar = self.avatarImageView.center
        cornerRadiusAvatar = avatarImageView.frame.width / 2
        avatarImageView.layer.cornerRadius = cornerRadiusAvatar!
        
    }
    
    private func setupView() {
        view.addSubview(tableView)
        tableView.addSubview(tappingImage)
        view.addSubview(fullscreenBackView)
        view.addSubview(avatarImageView)
        fullscreenBackView.addSubview(cancelButton)
        /**
         Задача 1:

         Пользуясь материалом лекции, выполните следующие действия:

         инициализируйте Podfile.
         пропишите 1 pod - SnapKit, можете раскомментировать (убрать символ '#') строку с версией target iOS и прописать там актуальную версию.
         pod install / открыть .xcworkspace.
         перепишите autolayout для ProfileView и всех его subview при помощи библиотеки SnapKit.
         Чтобы воспользоваться SnapKit в проекте, нужно подключить его с помощью инструкции import.
         Если статический анализатор сначала выдаст ошибку после импорта, воспользуйтесь Cmd-B (build).
         */
        //MARK: Решение задачи 1
        tableView.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        avatarImageView.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().inset(16)
            make.width.height.equalTo(80)
        }
        fullscreenBackView.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        cancelButton.snp.makeConstraints { (make) in
            make.top.equalTo(fullscreenBackView).inset(35)
            make.trailing.equalTo(fullscreenBackView).inset(10)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        NSLayoutConstraint.activate([
            tappingImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tappingImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tappingImage.widthAnchor.constraint(equalToConstant: 300),
            tappingImage.heightAnchor.constraint(equalToConstant: 300)
        ])
        
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
//            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            avatarImageView.widthAnchor.constraint(equalToConstant: 80),
//            avatarImageView.heightAnchor.constraint(equalToConstant: 80),
//            fullscreenBackView.topAnchor.constraint(equalTo: view.topAnchor),
//            fullscreenBackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            fullscreenBackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            fullscreenBackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//            cancelButton.topAnchor.constraint(equalTo: fullscreenBackView.topAnchor, constant: view.bounds.width * 0.05),
//            cancelButton.trailingAnchor.constraint(equalTo: fullscreenBackView.trailingAnchor, constant: -1 * view.bounds.width * 0.05),
//            cancelButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1),
//            cancelButton.heightAnchor.constraint(equalTo: cancelButton.widthAnchor),
//        ])
        
    }
    
    private func setupGestures() {        
        let tapOnfullscreenBackView = UITapGestureRecognizer(target: self, action: #selector(tapOnFullScreen))
        fullscreenBackView.addGestureRecognizer(tapOnfullscreenBackView)
        let tapCancel = UITapGestureRecognizer(target: self, action: #selector(tapCancelButton))
        cancelButton.addGestureRecognizer(tapCancel)
    }
    
    @objc func doubleTap(sender: UITapGestureRecognizer) {
        print(#function)
        let touchPoint = sender.location(in: sender.view)
        guard let indexPath = tableView.indexPathForRow(at: touchPoint) else { return }
            self.indexSelectedRow = indexPath.row
        
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       options: .allowUserInteraction) {
            self.tappingImage.alpha = 0.8
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                self.tappingImage.alpha = 0
            }
            let favoritePostAuth = self.post[self.indexSelectedRow!].author
            let favoritePostImage = self.post[self.indexSelectedRow!].image
            self.coreDataManager.addNewItem(author: favoritePostAuth, imagePath: favoritePostImage)
            //self.coreDataManager.checkDuplicate(image: favoritePostImage)


        }
    }
    
    @objc func tapOnAvatarImage() {
        print(#function)
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       options: .allowUserInteraction) {
            self.avatarImageView.alpha = 1
            self.fullscreenBackView.alpha = 0.5
            self.avatarImageView.transform = CGAffineTransform(scaleX: 4, y: 4)
            self.avatarImageView.center = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                self.avatarImageView.layer.cornerRadius = 0
            }
        }
    }
    
    @objc func tapOnFullScreen() {
        print(#function)
    }
    
    @objc func tapCancelButton() {
        print(#function)
        UIView.animate(withDuration: 0.3,
                       delay: 0.0,
                       options: .curveEaseInOut) {
            self.avatarImageView.transform = .identity
            self.avatarImageView.center = self.startPointAvatar ?? CGPoint(x: 0, y: 0)
            self.avatarImageView.layer.cornerRadius = self.cornerRadiusAvatar ?? 2
            self.avatarImageView.alpha = 0
        } completion: { _ in
            self.fullscreenBackView.alpha = 0
        }
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : post.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cellOne = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.identifier) as? PhotosTableViewCell else { return tableView.dequeueReusableCell(withIdentifier: "defaultcell", for: indexPath) }
        guard let cellTwo = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as? PostTableViewCell else { return tableView.dequeueReusableCell(withIdentifier: "defaultcell", for: indexPath) }
            let myPost = post[indexPath.row]
            cellTwo.setup(with: myPost)
            cellTwo.selectionStyle = .none
            let doubleTapping = UITapGestureRecognizer(target: self, action: #selector(doubleTap))
            doubleTapping.numberOfTouchesRequired = 2
            tableView.addGestureRecognizer(doubleTapping)
            doubleTapping.delaysTouchesBegan = true
        
            cellTwo.isUserInteractionEnabled = false
        return indexPath.section == 0 ? cellOne : cellTwo
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Section \(indexPath.section) - Row \(indexPath.row)")
        tableView.deselectRow(at: indexPath, animated:true)
            let vc = PhotosViewController()
        if indexPath.section == 0 {
            vc.textTitle = "Photo Gallery"
            indexPath.section == 0 ? navigationController?.pushViewController(vc, animated: true) : nil
        }
    }
    
   func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    switch section {
    case 0:
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileHeaderView.identifier) as? ProfileHeaderView else { return nil }
        let tapOnAvatarImageGusture = UITapGestureRecognizer(target: self, action: #selector(tapOnAvatarImage))
        header.avatarImageView.addGestureRecognizer(tapOnAvatarImageGusture)
        header.avatarImageView.isUserInteractionEnabled = true
            return header
    default:
        return nil
    }
   }
}
