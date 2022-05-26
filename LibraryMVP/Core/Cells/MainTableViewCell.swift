//
//  NewTestViewCell.swift
//  LibraryMVP
//
//  Created by Сергей Штейман on 14.02.2022.
//

import UIKit

// MARK: - NewTestViewCell
final class MainTableViewCell: UITableViewCell {
        
    private lazy var booksIdLabel: Label = {
        let label = Label()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    private lazy var booksNameLabel: Label = {
        let label = Label()
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var authorLabel: Label = {
        let label = Label()
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private lazy var iconBookImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var ageLimitLabel: Label = {
        let label = Label()
        label.font = .italicSystemFont(ofSize: 17)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public methods
extension MainTableViewCell {
    
    func setupCell(with model: Properties) {
        booksIdLabel.text = "\(model.id ?? 0)"
        booksNameLabel.text = model.title ?? ""
        authorLabel.text = model.autor ?? ""
        ageLimitLabel.text = "\(model.age ?? 0)+"
        iconBookImageView.image = UIImage(named: model.type.imageName) 
    }
}

// MARK: - Private methods
private extension MainTableViewCell {
    
    func setupCell() {
        addSubViews()
        addConstraints()
    }

    
    func addSubViews() {
        let arrayOfSubViews = [booksIdLabel,
                               booksNameLabel,
                               iconBookImageView,
                               authorLabel,
                               ageLimitLabel]
        myAddSubViews(from: arrayOfSubViews)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            ageLimitLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            ageLimitLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            ageLimitLabel.widthAnchor.constraint(equalToConstant: 30),
            
            iconBookImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconBookImageView.trailingAnchor.constraint(equalTo: ageLimitLabel.leadingAnchor, constant: -8),
            iconBookImageView.widthAnchor.constraint(equalToConstant: 40),
            iconBookImageView.heightAnchor.constraint(equalToConstant: 35),
            
            booksIdLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            booksIdLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            booksIdLabel.trailingAnchor.constraint(equalTo: iconBookImageView.leadingAnchor, constant: -16),
            
            booksNameLabel.topAnchor.constraint(equalTo: booksIdLabel.bottomAnchor, constant: 16),
            booksNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            booksNameLabel.trailingAnchor.constraint(equalTo: iconBookImageView.leadingAnchor, constant: -16),
            
            authorLabel.topAnchor.constraint(equalTo: booksNameLabel.bottomAnchor, constant: 16),
            authorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            authorLabel.trailingAnchor.constraint(equalTo: iconBookImageView.leadingAnchor, constant: -16),
            authorLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}

