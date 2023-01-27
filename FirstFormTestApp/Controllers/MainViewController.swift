//
//  MainViewController.swift
//  FirstFormTestApp
//
//  Created by Ильдар Аглиуллов on 27.01.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    private var viewModel: TableViewViewModelProtocol?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: String(describing: MainTableViewCell.self))
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
        fetchViewModel()
    }
    
    private func addSubviews() {
        view.backgroundColor = .white
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        let constraints: [NSLayoutConstraint] = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 4.0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4.0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -4.0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -4.0)
        ]
        
        view.addConstraints(constraints)
    }
    
    private func fetchViewModel() {
        viewModel = TableViewViewModel()
        viewModel?.fetchData(completion: { [weak self] model in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel, let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MainTableViewCell.self), for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        cell.viewModel = cellViewModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numbersOfRows() ?? 0
    }
}
