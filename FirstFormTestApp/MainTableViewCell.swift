//
//  MainTableViewCell.swift
//  FirstFormTestApp
//
//  Created by Ильдар Аглиуллов on 27.01.2023.
//

import UIKit

final class MainTableViewCell: UITableViewCell {
    
    weak var viewModel: TableViewCellViewModelProtocol? {
        willSet(viewModel) {
            setupValues(with: viewModel)
        }
    }
    
    private var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 64, height: 64))
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.style = .medium
        activityIndicatorView.backgroundColor = .white
        activityIndicatorView.startAnimating()
        return activityIndicatorView
    }()
    
    private var mainImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var mainTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var mainSubTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        return label
    }()
    
    private var rightArrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage.init(systemName: "arrow.right")
        imageView.tintColor = .gray
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupViews() {
        addSubview(activityIndicatorView)
        addSubview(mainImage)
        addSubview(mainTitle)
        addSubview(mainSubTitle)
        addSubview(rightArrowImage)
    }
    
    private func setupConstraints() {
        let constraints: [NSLayoutConstraint] = [
            activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            activityIndicatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30.0),
            
            mainImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 4.0),
            mainImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4.0),
            mainImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4.0),
            mainImage.heightAnchor.constraint(equalToConstant: 64.0),
            mainImage.widthAnchor.constraint(equalToConstant: 64.0),
            
            mainTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 12.0),
            mainTitle.leadingAnchor.constraint(equalTo: mainImage.trailingAnchor, constant: 8.0),
            
            mainSubTitle.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 4.0),
            mainSubTitle.leadingAnchor.constraint(equalTo: mainTitle.leadingAnchor),
            
            rightArrowImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            rightArrowImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30.0)
        ]
        addConstraints(constraints)
    }
}

extension MainTableViewCell {
    
    func setupValues(with data: TableViewCellViewModelProtocol?) {
        guard let data = data else { return }
        mainTitle.text = data.title
        mainSubTitle.text = data.subTitle
        mainImage.image = UIImage(named: data.imageName)
    }
}
