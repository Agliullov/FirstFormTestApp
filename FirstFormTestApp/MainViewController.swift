//
//  MainViewController.swift
//  FirstFormTestApp
//
//  Created by Ильдар Аглиуллов on 27.01.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    private let imageLoader: ImageLoader = ImageLoader()
    
    private var viewModel: TableViewViewModelProtocol?
    
    private var searchController: UISearchController = {
       let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Искать в плейлистах"
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }()
    
    private var tableView: UITableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Плейлисты"
        configureSearchController()
        configureTableView()
        fetchViewModel()
    }
    
    //MARK: - Private methods
    
    private func configureSearchController() {
        searchController.searchResultsUpdater = self
        self.navigationItem.searchController = self.searchController
        self.navigationItem.searchController?.searchBar.sizeToFit()
    }
    
    private func configureTableView() {
        self.view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.backgroundColor = UIColor.systemGroupedBackground
        tableView.estimatedRowHeight = 64.0
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: String(describing: MainTableViewCell.self))
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func fetchViewModel() {
        viewModel = TableViewViewModel()
        viewModel?.fetchData(completion: { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
    }
    
    private func showAlertForModel(at indexPath: IndexPath) {
        guard let title = self.viewModel?.getTitleForIndex(index: indexPath.row) else { return }
        let alertViewController = UIAlertController(title: "Редактировать название", message: "", preferredStyle: .alert)
        alertViewController.addTextField { textField in
            textField.text = title
            textField.placeholder = "Введите текст"
            textField.becomeFirstResponder()
        }
        let saveAction = UIAlertAction(title: "Готово", style: .default) { [weak self] alertAction in
            guard let self = self else { return }
            let textField = alertViewController.textFields![0] as UITextField
            let text = textField.text
            self.viewModel?.change(title: text, at: indexPath.row)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alertViewController.addAction(saveAction)
        alertViewController.addAction(cancelAction)
        self.present(alertViewController, animated: true, completion: nil)
    }
}

//MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numbersOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel, let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MainTableViewCell.self), for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        cell.setup(title: cellViewModel?.title, subTitle: cellViewModel?.subTitle, imageURL: cellViewModel?.imageURL, imageLoader: imageLoader)
        return cell
    }
}

//MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let editAction = UIAction(title: "Редактировать", image: UIImage(systemName: "pencil")) { _ in
            self.showAlertForModel(at: indexPath)
        }
        let cancelAction = UIAction(title: "Скрыть", image: UIImage(systemName: "arrowshape.turn.up.backward.circle")) { _ in }
        
        let actionProvider: UIContextMenuActionProvider = { _ in
            return UIMenu(title: "", image: nil, identifier: nil, options: .singleSelection, children: [editAction, cancelAction])
        }
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: actionProvider)
    }
}

//MARK: - UISearchResultsUpdating
extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        self.viewModel?.filterBy(text: searchController.searchBar.text ?? "")
        self.tableView.reloadData()
    }
}
