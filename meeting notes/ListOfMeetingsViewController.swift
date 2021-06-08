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
    fileprivate lazy var loadingView = LoadingView(frame: .zero)
    fileprivate lazy var emptyStateView = EmptyStateView(frame: .zero)
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
        configureView()
        viewModel.viewDelegate = self
        fetchListOfMeetings()
        setUpUI()
    }
    
    // MARK: - Private Methods
    
    fileprivate func setUpUI() {
        title = K.Text.listOfMeetingsViewControllerTitle
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = K.Color.hugoBlue
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.backgroundColor = .systemBackground
    }
    
    
    fileprivate func showLoadingView(_ isLoading: Bool) {
        DispatchQueue.main.async {
            self.loadingView.isHidden = !isLoading
            isLoading ? self.loadingView.startLoading() : self.loadingView.stopLoading()
        }
    }
    
    fileprivate func showEmptyStateView(_ show: Bool, type: EmptyStateViewType) {
        DispatchQueue.main.async {
            self.emptyStateView.setUp(type: type)
            self.emptyStateView.isHidden = !show
            self.showReloadButton(show)
        }
    }
    
    fileprivate func showReloadButton(_ show: Bool) {
        if show {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "arrow.counterclockwise"),
                                                                style: .plain,
                                                                target: self,
                                                                action: #selector(fetchListOfMeetings))
        } else {
            navigationItem.backBarButtonItem = nil
        }
    }
    
    @objc fileprivate func fetchListOfMeetings() {
        viewModel.fetchListOfMeetings()
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
                            description: viewModel.getMeetingDate(from: viewModel.listOfMeetings?[indexPath.row].startAt,
                                                                  to: viewModel.listOfMeetings?[indexPath.row].endAt),
                            accessoryLabelIsHidden: viewModel.shoudHideAccessoryLabelAt(at: indexPath.row))
        return cell ?? UITableViewCell()
    }
}

// MARK: - UITableViewDelegate

extension ListOfMeetingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let meetingId: String = viewModel.listOfMeetings?[indexPath.row].id ?? ""
        let meetingViewModel: MeetingViewModel = MeetingViewModel(meetingId: meetingId, service: viewModel.service)
        let meetingViewController: MeetingViewController = MeetingViewController(viewModel: meetingViewModel,
                                                                                 title: viewModel.listOfMeetings?[indexPath.row].title ?? "")
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
    
    func listOfMeetingsViewModelDelegateIsLoading(_ viewModel: ListOfMeetingsViewModel, isLoading: Bool) {
        showLoadingView(isLoading)
    }
    
    func listOfMeetingsViewModelDelegateIsEmpty(_ viewModel: ListOfMeetingsViewModel, isEmpty: Bool) {
        showEmptyStateView(isEmpty, type: .emptyList)
    }

    func listOfMeetingsViewModelDelegateError(_ viewModel: ListOfMeetingsViewModel) {
        showEmptyStateView(true, type: .error)
    }
}

// MARK: - ViewConfiguration

extension ListOfMeetingsViewController: ViewConfiguration {
    func buildViewHierarchy() {
        view.addSubview(tableView)
        view.addSubview(loadingView)
        view.addSubview(emptyStateView)
    }
    
    func setUpConstraints() {
        commomConstraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo:  view.bottomAnchor),
            
            loadingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo:  view.bottomAnchor),
            
            emptyStateView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            emptyStateView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            emptyStateView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            emptyStateView.bottomAnchor.constraint(equalTo:  view.bottomAnchor)
        ]
        
        updateLayoutConstraints()
    }
    
    func updateLayoutConstraints() {
        NSLayoutConstraint.activate(commomConstraints)
    }
}
