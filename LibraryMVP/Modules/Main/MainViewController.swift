//
//  MainViewController.swift
//  LibraryMVP
//
//  Created by Сергей Штейман on 23.03.2022.
//

import UIKit

// MARK: - MainViewProtocol
protocol MainViewProtocol: AnyObject {
    func display(_ books: [Book])
    func routeTo(_ viewController: UIViewController)
    func showAllert(with title: String?, and message: String?)

}

// MARK: - MainViewController
final class MainViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero,
                                        style: .plain)
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var booksViewModel = [Book]()

    var presenter: MainPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
}

// MARK: - MainViewProtocol Impl
extension MainViewController: MainViewProtocol {
    
    func display(_ books: [Book]) {
        booksViewModel = books
        tableView.reloadData()
    }
    
    func routeTo(_ viewController: UIViewController) {
        present(viewController, animated: true)
    }
    
    
    func showAllert(with title: String?, and message: String?) {
        let allertController = UIAlertController(title: title,
                                                 message: message,
                                                 preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) {[weak self] _ in
            self?.viewDidLoad()
        }
        allertController.addAction(action)
        present(allertController, animated: true)
    }
}

// MARK: - UITableViewDelegate Impl
extension MainViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.fetchBookInfoViewController(with: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDataSource Impl
extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return booksViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.myDequeueReusableCell(type: MainTableViewCell.self, indePath: indexPath)
        guard let model = booksViewModel[indexPath.row].properties else {
            return myCell
        }
        myCell.setupCell(with: model)
        return myCell
    }
}

// MARK: - UISearchBarDelegate Impl
extension MainViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchBarIsEmpty = searchText.isEmpty
        presenter?.enabledFilter(!searchBarIsEmpty)
        if searchBarIsEmpty {
            presenter?.fetchLibrary()
        } else {
            presenter?.filterBooks(by: searchText)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter?.fetchLibrary()
    }
}

// MARK: - Private methdods
private extension MainViewController {
    
    func setupViewController() {
        view.backgroundColor = .white
        setupNavigationBar()
        setupSearchController()
        setupTableView()
        addSubViews()
        setupConstraints()
        
        presenter?.fetchLibrary()
    }
    
    func setupNavigationBar() {
        title = "Library"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    func setupSearchController() {
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func setupTableView() {
        tableView.myRegister(MainTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func addSubViews() {
        view.myAddSubView(tableView)
    }
    
    func  setupConstraints() {
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
