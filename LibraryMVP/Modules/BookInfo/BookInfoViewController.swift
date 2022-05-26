//
//  BookInfoViewController.swift
//  LibraryMVP
//
//  Created by Сергей Штейман on 18.02.2022.
//

import UIKit

// MARK: - BookInfoViewProtocol
protocol BookInfoViewProtocol: AnyObject {
    func display(properties: Properties)
}

// MARK: - BookInfoViewController
final class BookInfoViewController: UIViewController {

    var presenter: BookInfoPresenterProtocol?
    let bookInfoTableView = UITableView(frame: .zero, style: .plain)
    
    private var properties: Properties?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBookInfoTableView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        bookInfoTableView.reloadData()
    }
}

// MARK: - BookInfoViewProtocol Impl
extension BookInfoViewController: BookInfoViewProtocol {
    
    func display(properties: Properties) {
        self.properties = properties
        bookInfoTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource Impl
extension BookInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.myDequeueReusableCell(type: BookInfoTableViewCell.self, indePath: indexPath)
        if let model = properties {
            myCell.setupCell(with: model)
        }
        return myCell
    }
}

// MARK: - Private methods
private extension BookInfoViewController {
    
    func setupBookInfoTableView() {
        bookInfoTableView.frame = view.bounds
        bookInfoTableView.myRegister(BookInfoTableViewCell.self)
        self.bookInfoTableView.dataSource = self
        view.myAddSubView(bookInfoTableView)
        view.backgroundColor = .white
        bookInfoTableView.allowsSelection = false
        bookInfoTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        setupConstraintsOnTableView()
        presenter?.fetchInfo()
    }
    
    func setupConstraintsOnTableView() {
        NSLayoutConstraint.activate([bookInfoTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     bookInfoTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     bookInfoTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     bookInfoTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }
}
