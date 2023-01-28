//
//  MainTableViewCell.swift
//  FirstFormTestApp
//
//  Created by Ильдар Аглиуллов on 27.01.2023.
//

import UIKit

final class MainTableViewCell: UITableViewCell {
    
    private var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(frame: .zero)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.style = .medium
        activityIndicatorView.backgroundColor = .white
        return activityIndicatorView
    }()
    
    private var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemFill
        imageView.layer.cornerRadius = 6.0
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private var mainTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
    private var mainSubTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
    private var containerView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {
        self.backgroundColor = .secondarySystemGroupedBackground
        contentView.backgroundColor = .clear
        self.accessoryType = .disclosureIndicator
        
        contentView.addSubview(activityIndicatorView)
        contentView.addSubview(iconImageView)
        containerView.addArrangedSubview(mainTitle)
        containerView.addArrangedSubview(mainSubTitle)
        contentView.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            iconImageView.leftAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leftAnchor, constant: 4.0),
            contentView.layoutMarginsGuide.bottomAnchor.constraint(equalTo: iconImageView.bottomAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 64.0),
            iconImageView.widthAnchor.constraint(equalToConstant: 64.0),
            
            activityIndicatorView.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            activityIndicatorView.centerXAnchor.constraint(equalTo: iconImageView.centerXAnchor),
            
            containerView.topAnchor.constraint(greaterThanOrEqualTo: iconImageView.topAnchor),
            containerView.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 12.0),
            contentView.layoutMarginsGuide.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            iconImageView.bottomAnchor.constraint(greaterThanOrEqualTo: containerView.bottomAnchor),
            containerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func setup(title: String?, subTitle: String?, imageURL: URL?, imageLoader: ImageLoader) {
        self.mainTitle.text = title
        self.mainSubTitle.text = subTitle
        if let imageURL = imageURL {
            activityIndicatorView.startAnimating()
            let _ = imageLoader.loadImage(from: imageURL).sink { [weak self] image in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.activityIndicatorView.stopAnimating()
                    self.iconImageView.image = image
                }
            }
        } else {
            self.iconImageView.image = nil
            activityIndicatorView.startAnimating()
        }
    }
}
