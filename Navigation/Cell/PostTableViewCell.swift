//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Shalopay on 15.06.2022.
//

import UIKit
import StorageService
import iOSIntPackage

class PostTableViewCell: UITableViewCell {
    let imageProcessor = ImageProcessor()
    static var identifier: String = "postTableViewCell"
    
    internal lazy var authorLb: UILabel = {
        let authorLb = UILabel()
        authorLb.font = .systemFont(ofSize: 20, weight: .bold)
        authorLb.textColor = .black
        authorLb.numberOfLines = 2
        authorLb.translatesAutoresizingMaskIntoConstraints = false
        return authorLb
    }()
    private lazy var myImageView: UIImageView = {
       let myImageView = UIImageView()
        myImageView.contentMode = .scaleToFill
        myImageView.backgroundColor = .black
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        return myImageView
    }()
    
    private lazy var descriptionLb: UILabel = {
       let descriptionLb = UILabel()
        descriptionLb.font = .systemFont(ofSize: 14)
        descriptionLb.textColor = .systemGray
        descriptionLb.numberOfLines = 0
        descriptionLb.translatesAutoresizingMaskIntoConstraints = false
        return descriptionLb
    }()
    
    private lazy var likesLb: UILabel = {
       let likesLb = UILabel()
        likesLb.font = .systemFont(ofSize: 16)
        likesLb.text = "Likes:"
        likesLb.textColor = .black
        likesLb.translatesAutoresizingMaskIntoConstraints = false
        return likesLb
    }()
    
    private lazy var likesCount: UILabel = {
       let likesCount = UILabel()
        likesCount.font = .systemFont(ofSize: 16)
        likesCount.textColor = .black
        likesCount.translatesAutoresizingMaskIntoConstraints = false
        return likesCount
    }()
    
    private lazy var viewsLb: UILabel = {
       let viewsLb = UILabel()
        viewsLb.font = .systemFont(ofSize: 16)
        viewsLb.text = "Views:"
        viewsLb.textColor = .black
        viewsLb.translatesAutoresizingMaskIntoConstraints = false
        return viewsLb
    }()
    
    private lazy var viewsCount: UILabel = {
       let viewsCount = UILabel()
        viewsCount.font = .systemFont(ofSize: 16)
        viewsCount.textColor = .black
        viewsCount.translatesAutoresizingMaskIntoConstraints = false
        return viewsCount
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViewCell() {
        contentView.addSubview(authorLb)
        contentView.addSubview(myImageView)
        contentView.addSubview(descriptionLb)
        contentView.addSubview(likesLb)
        contentView.addSubview(likesCount)
        contentView.addSubview(viewsLb)
        contentView.addSubview(viewsCount)
        NSLayoutConstraint.activate([
            authorLb.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            authorLb.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
            authorLb.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -16),
            
            myImageView.topAnchor.constraint(equalTo: authorLb.bottomAnchor, constant: 5),
            myImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            myImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            myImageView.heightAnchor.constraint(equalToConstant: contentView.frame.width),
            //myImageView.widthAnchor.constraint(equalToConstant: contentView.frame.width),
            
            descriptionLb.topAnchor.constraint(equalTo: myImageView.bottomAnchor,constant: 5),
            descriptionLb.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
            descriptionLb.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            likesLb.topAnchor.constraint(equalTo: descriptionLb.bottomAnchor,constant: 5),
            likesLb.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
            likesLb.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            likesCount.topAnchor.constraint(equalTo: descriptionLb.bottomAnchor,constant: 5),
            likesCount.leadingAnchor.constraint(equalTo: likesLb.trailingAnchor, constant: 5),
            likesCount.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            viewsCount.topAnchor.constraint(equalTo: descriptionLb.bottomAnchor,constant: 5),
            viewsCount.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            viewsCount.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            viewsLb.topAnchor.constraint(equalTo: descriptionLb.bottomAnchor,constant: 5),
            viewsLb.trailingAnchor.constraint(equalTo: viewsCount.leadingAnchor,constant: -5),
            viewsLb.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
        ])
    }
    
    func setupCoreDataItems(with post: FavoriteItem) {
        authorLb.text = post.author
        if let tempimage = post.image {
            myImageView.image = UIImage(named: tempimage)
        }
        descriptionLb.text = post.desc
        likesCount.text = post.likes
        viewsCount.text = post.views
    }
    
    func setup(with post: Post) {
        authorLb.text = post.author
        /*
         Задача 3* (необязательная задача)

         Пользуясь материалом лекции, выполните следующие действия:

         установите Swift Package iOSIntPackage
         при установке задайте диапазон версий от 2.0.0, к моменту выполнения домашнего задания тэг может измениться
         используйте интерфейс ImageProcessor для обработки фотографий с помощью встроенных фильтров из фреймворка, код пакета открытый, публичный интерфейс реализован через 1 метод
         */
        //MARK: Решение задачи 3*
        
        guard let sourceImage = UIImage(named: post.image) else { return }
        DispatchQueue.main.async {
            self.imageProcessor.processImage(sourceImage: sourceImage, filter: .fade) { image in
                self.myImageView.image = image
            }
        }
        descriptionLb.text = post.desc
        likesCount.text = String(post.likes)
        viewsCount.text = String(post.views)
    }
    
}
