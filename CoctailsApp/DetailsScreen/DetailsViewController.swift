//
//  DetailsViewController.swift
//  CoctailsApp
//
//  Created by user on 16.07.2025.
//

import UIKit

protocol IDetailsViewController: AnyObject {
    func configure(item: DetailsModel)
    func configureIngredients(array: [String])
}

final class DetailsViewController: UIViewController {
    var presenter: IDetailsViewPresenter!
    
    private let imageView = ContainerImageView()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let titleText = UILabel.makeLabel(text: "Title", font: UIFont.systemFont(ofSize: 32, weight: .bold), textColor: .black)
    private let instructionText = UILabel.makeLabel(text: "Description", font: UIFont.systemFont(ofSize:17, weight: .regular), textColor: .black)
    private let tableView = UITableView()
    private var arrayIngredients: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        presenter.render()
        presenter.renderIngredients()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.heightAnchor.constraint(equalToConstant: tableView.contentSize.height).isActive = true
    }

    
    private func setupTableView() {
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
}

private extension DetailsViewController {
    func setupView() {
        view.backgroundColor = .systemBackground
        addSubViews()
        setupLayout()
    }
    
    func addSubViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addViews(imageView, titleText, instructionText, tableView)
    }
}

extension DetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayIngredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.textProperties.color = .black
        content.textProperties.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        content.text = arrayIngredients[indexPath.row]
        cell.contentConfiguration = content
        return cell
        
    }
}

private extension DetailsViewController {
    func setupLayout() {
        [
            scrollView,
            contentView,
            imageView,
            titleText,
            instructionText,
            tableView
        ].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
        
        NSLayoutConstraint.activate([
            titleText.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 24),
            titleText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            titleText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            imageView.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 32),
            imageView.leadingAnchor.constraint(equalTo: titleText.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: titleText.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            
            instructionText.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24),
            instructionText.leadingAnchor.constraint(equalTo: titleText.leadingAnchor),
            instructionText.trailingAnchor.constraint(equalTo: titleText.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: instructionText.bottomAnchor, constant: 12),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}


extension DetailsViewController: IDetailsViewController {
    func configureIngredients(array: [String]) {
        arrayIngredients = array
        tableView.reloadData()
    }
    
    func configure(item: DetailsModel) {
        titleText.text = item.title
        instructionText.text = item.instruction
        imageView.configure(urlImage: item.image ?? "")
        imageView.configureData(data: item.imageCore)
    }
}
