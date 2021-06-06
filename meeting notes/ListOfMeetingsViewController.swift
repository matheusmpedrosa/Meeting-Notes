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
        return viewModel.listOfMeetings?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MeetingListItemTableViewCell.self),
                                                 for: indexPath) as? MeetingListItemTableViewCell
            cell?.configureView()
            cell?.setUpCell(title: viewModel.listOfMeetings?[indexPath.row].title ?? "",
                            description: viewModel.listOfMeetings?[indexPath.row].endAt ?? "",
                            accessoryLabelIsHidden: false)
        return cell ?? UITableViewCell()
    }
}

// MARK: - UITableViewDelegate

extension ListOfMeetingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let meetingId: String = viewModel.listOfMeetings?[indexPath.row].id ?? ""
        let meetingViewModel: MeetingViewModel = MeetingViewModel(meetingId: meetingId, service: viewModel.service)
        let meetingViewController: MeetingViewController = MeetingViewController(viewModel: meetingViewModel)
        navigationController?.pushViewController(meetingViewController, animated: true)
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
