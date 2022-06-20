//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Shalopay on 15.06.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    static var identifier: String = "postTableViewCell"
    
    private lazy var authorLb: UILabel = {
        let authorLb = UILabel()
        authorLb.font = .systemFont(ofSize: 20, weight: .bold)
        authorLb.textColor = .black
        authorLb.numberOfLines = 2
        authorLb.translatesAutoresizingMaskIntoConstraints = false
        return authorLb
    }()
    private lazy var myImageView: UIImageView = {
       let myImageView = UIImageView()
        myImageView.contentMode = .scaleAspectFit
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
            myImageView.widthAnchor.constraint(equalToConstant: contentView.frame.width),
            
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
    
    func setup(with post: Post) {
        authorLb.text = post.author
        myImageView.image = UIImage(named: post.image)
        descriptionLb.text = post.description
        likesCount.text = String(post.likes)
        viewsCount.text = String(post.views)
    }
    
}
