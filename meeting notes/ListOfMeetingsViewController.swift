//
//  ListOfMeetingsViewController.swift
//  meeting notes
//
//  Created by Matheus Pedrosa on 05/06/21.
//

import UIKit

final class ListOfMeetingsViewController: UIViewController {
    
    // MARK: - Properties
    
    fileprivate var viewModel: ListOfMeetingsViewModel!
    fileprivate lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView(frame: .zero)
        tableView.backgroundColor = .systemBackground
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.alwaysBounceVertical = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MeetingListItemTableViewCell.self, forCellReuseIdentifier: String(describing: MeetingListItemTableViewCell.self))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: K.EmptyState.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    fileprivate var commomConstraints: [NSLayoutConstraint] = []
    
    // MARK: - Initializer
    
    init(viewModel: ListOfMeetingsViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDelegate = self
        configureView()
        setUpUI()
        viewModel.fechListOfMeetings()
    }
    
    // MARK: - Private Methods
    
    fileprivate func setUpUI() {
        title = K.Title.listOfMeetingsViewControllerTitle
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = K.Color.hugo
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.backgroundColor = .systemBackground
    }
}

// MARK: - UITableViewDataSource

extension ListOfMeetingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let numberOfMeetings = viewModel.listOfMeetings?.count, numberOfMeetings > 0 else {
            return 1
        }
        return numberOfMeetings
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let numberOfMeetings = viewModel.listOfMeetings?.count, numberOfMeetings > 0 else {
            let cell = tableView.dequeueReusableCell(withIdentifier: K.EmptyState.identifier, for: indexPath)
            cell.selectionStyle = .none
            cell.textLabel?.text = K.EmptyState.title
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MeetingListItemTableViewCell.self),
                                                 for: indexPath) as? MeetingListItemTableViewCell
        DispatchQueue.main.async {
            cell?.configureView()
            cell?.setUpCell(title: self.viewModel.listOfMeetings?[indexPath.row].title ?? "",
                            description: self.viewModel.listOfMeetings?[indexPath.row].endAt ?? "",
                            accessoryLabelIsHidden: false)
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

// MARK: - UITableViewDelegate

extension ListOfMeetingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - ListOfMeetingsViewModelDelegate

extension ListOfMeetingsViewController: ListOfMeetingsViewModelDelegate {
    func listOfMeetingsViewModelDelegateDidFetchMeetings(_ viewModel: ListOfMeetingsViewModel) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - ViewConfiguration

extension ListOfMeetingsViewController: ViewConfiguration {
    func buildViewHierarchy() {
        view.addSubview(tableView)
    }
    
    func setUpConstraints() {
        commomConstraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo:  view.bottomAnchor)
        ]
        
        updateLayoutConstraints()
    }
    
    func updateLayoutConstraints() {
        NSLayoutConstraint.activate(commomConstraints)
    }
}
