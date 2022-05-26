//
//  BookInfoTableViewCell.swift
//  LibraryMVP
//
//  Created by Сергей Штейман on 18.02.2022.
//

import UIKit

// MARK: - BookInfoTableViewCell
final class BookInfoTableViewCell: UITableViewCell {
    
    let gradient = CAGradientLayer()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var titleLabel: Label = {
        let label = Label()
        label.font = .init(name: "Bodoni 72 Oldstyle", size: 33)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var genreLable: Label = {
        let label = Label()
        label.text = "Жанр:"
        label.font = .init(name: "Bodoni 72 Oldstyle", size: 18)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var genreDescriptionLabel: Label = {
        let label = Label()
        label.font = .init(name: "Bodoni 72 Oldstyle", size: 18)
        label.textAlignment = .right
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var autorLabel: Label = {
        let label = Label()
        label.textAlignment = .center
        label.font = .init(name: "Bodoni 72 Oldstyle", size: 23)
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var iconBookImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var labelAge: Label = {
        let label = Label()
        label.font = .systemFont(ofSize: 30)
        return label
    }()
    
    private lazy var priceLabel: Label = {
        let label = Label()
        label.textAlignment = .right
        label.font = .init(name: "Arial Rounded MT Bold", size: 50)
        label.textColor = .systemGreen
        return label
    }()
    
    private lazy var issueBeforeLable: Label = {
        let label = Label()
        label.font = .systemFont(ofSize: 18)
        label.text = "Выдана до:"
        return label
    }()
    
    private lazy var issueBeforeDescriptionLable: Label = {
        let label = Label()
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .right
        return label
    }()
    
    private lazy var recipeData: Label = {
        let label = Label()
        label.text = "Дата поступления:"
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var recipeDataDescription: Label = {
        let label = Label()
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .right
        return label
    }()
    
    private lazy var dateOfDebitingLabel: Label = {
        let label = Label()
        label.text = "Дата списания:"
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var dateOfDebitingDescriptionLabel: Label = {
        let label = Label()
        label.text = "-"
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .right
        return label
    }()
    
    private lazy var issuesCountLabel: Label = {
        let label = Label()
        label.text = "Всего выдач:"
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var issueCountLabelDescription: Label = {
        let label = Label()
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = containerView.bounds
    }
}

// MARK: - Public methods
extension BookInfoTableViewCell {

    func setupCell(with model: Properties) {
        setupTitleLabel(with: model)
        genreDescriptionLabel.text = model.genre
        autorLabel.text = model.autorFulName
        iconBookImageView.image = UIImage(named: model.type.imageName)
        setupAgeLabel(with: model)
        setupPriceLabel(with: model)
        setupIssueBeForeLabel(with: model)
        recipeDataDescription.text = model.recipeData
        setupIssueCountLabel(with: model)
    }
}

// MARK: Private methods
private extension BookInfoTableViewCell {
    
    func setupCell() {
        gradient.frame = containerView.bounds
        addSubViews()
        addConstraints()
        gradient.colors = [UIColor.cyan.cgColor,
                           UIColor.white.cgColor]
        containerView.layer.insertSublayer(gradient, at: 0)
    }
    
    func setupTitleLabel(with model: Properties) {
        let attributedString = NSMutableAttributedString(string: model.title ?? " ")
        attributedString.addAttribute(NSAttributedString.Key.kern,
                                      value: CGFloat(10.0),
                                      range: NSRange(location: 0,
                                                     length: attributedString.length))
        titleLabel.attributedText = attributedString
    }
    
    func setupAgeLabel(with model: Properties) {
        guard let age = model.age else {
            return
        }
        labelAge.text = String(age) + "+"
    }
    
    func setupPriceLabel(with model: Properties?) {
        if let price = model?.recipePrice {
            if price / Double(Int(price)) == 1.0 {
                let intPrice = Int(price)
                priceLabel.text = String(intPrice) + " p"
            } else {
                priceLabel.text = String(price) + " p"
            }
        }
    }
    
    func setupIssueBeForeLabel(with model: Properties?) {
        if model == nil {
            issueBeforeDescriptionLable.text = "-"
        } else {
            issueBeforeDescriptionLable.text = model?.issueBefore
        }
    }
    
    func setupIssueCountLabel(with model: Properties?) {
        if let issuesCount = model?.issuesCount {
            if String(issuesCount) == "0" {
                issueCountLabelDescription.text = "-"
            } else {
                issueCountLabelDescription.text = String(issuesCount)
            }
        }
    }
    
    func addSubViews() {
        let arraySubViewws = [containerView, titleLabel, genreLable,
                              genreDescriptionLabel, autorLabel,
                              iconBookImageView, labelAge, priceLabel,
                              issueBeforeLable, issueBeforeDescriptionLable,
                              recipeData, recipeDataDescription, dateOfDebitingLabel,
                              dateOfDebitingDescriptionLabel, issuesCountLabel,
                              issueCountLabelDescription]
        myAddSubViews(from: arraySubViewws)
    }
    
    func addConstraints() {
        let screenWidth = UIScreen.main.bounds.size.width
        print(screenWidth) // 390.0
        let containerViewWigth = screenWidth * 0.77
        NSLayoutConstraint.activate([containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
                                     containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
                                     containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -(screenWidth - containerViewWigth )),
                                     containerView.heightAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1.19),
                                     
                                     titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
                                     titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
                                     titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
                                     titleLabel.widthAnchor.constraint(equalToConstant: 300),
                                     titleLabel.heightAnchor.constraint(equalToConstant: 180),
                                     
                                     genreLable.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
                                     genreLable.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
                                     genreLable.widthAnchor.constraint(equalToConstant: 50),
                                     genreLable.heightAnchor.constraint(equalToConstant: 25),
                                     
                                     genreDescriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
                                     genreDescriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
                                     genreDescriptionLabel.leadingAnchor.constraint(equalTo: genreLable.trailingAnchor, constant: 20),
                                     genreDescriptionLabel.heightAnchor.constraint(equalToConstant: 50),
                                     
                                     autorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 60),
                                     autorLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
                                     autorLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
                                     autorLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
                                     
                                     iconBookImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: +70),
                                     iconBookImageView.leadingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 15),
                                     iconBookImageView.widthAnchor.constraint(equalToConstant: 50),
                                     iconBookImageView.heightAnchor.constraint(equalToConstant: 50),
                                    
                                     labelAge.topAnchor.constraint(equalTo: iconBookImageView.bottomAnchor, constant: 40),
                                     labelAge.leadingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 18),
                                     labelAge.widthAnchor.constraint(equalToConstant: 55),
                                     labelAge.heightAnchor.constraint(equalToConstant: 50),
                                     
                                     priceLabel.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 20),
                                     priceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
                                     priceLabel.heightAnchor.constraint(equalToConstant: 70),
                                     priceLabel.widthAnchor.constraint(equalToConstant: 200),
                                     
                                     issueBeforeLable.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 25),
                                     issueBeforeLable.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
                                     issueBeforeLable.heightAnchor.constraint(equalToConstant: 20),
                                    
                                     issueBeforeDescriptionLable.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 25),
                                     issueBeforeDescriptionLable.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
                                    
                                     recipeData.topAnchor.constraint(equalTo: issueBeforeLable.bottomAnchor, constant: 20),
                                     recipeData.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
                                     recipeData.trailingAnchor.constraint(equalTo: recipeDataDescription.leadingAnchor),
                                    
                                     recipeDataDescription.topAnchor.constraint(equalTo: issueBeforeDescriptionLable.bottomAnchor, constant: 20),
                                     recipeDataDescription.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
                                     recipeDataDescription.widthAnchor.constraint(equalToConstant: 180),
                                     recipeDataDescription.heightAnchor.constraint(equalToConstant: 20),

                                     dateOfDebitingLabel.topAnchor.constraint(equalTo: recipeData.bottomAnchor, constant: 20),
                                     dateOfDebitingLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),

                                     dateOfDebitingDescriptionLabel.topAnchor.constraint(equalTo: dateOfDebitingLabel.topAnchor),
                                     dateOfDebitingDescriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
                                     
                                     issuesCountLabel.topAnchor.constraint(equalTo: dateOfDebitingLabel.bottomAnchor, constant: 20),
                                     issuesCountLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
                                     issuesCountLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),

                                     issueCountLabelDescription.topAnchor.constraint(equalTo: dateOfDebitingDescriptionLabel.bottomAnchor, constant: 20),
                                     issueCountLabelDescription.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
                                     issueCountLabelDescription.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
                                    ])
    }
}

