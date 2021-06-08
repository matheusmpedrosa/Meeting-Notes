//
//  MeetingViewController.swift
//  meeting notes
//
//  Created by Matheus Pedrosa on 05/06/21.
//

import UIKit

class MeetingViewController: UIViewController {
    
    // MARK: - Properties
    
    fileprivate lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        view.layer.cornerRadius = K.UI.cornerRadius
        view.layer.borderWidth = K.UI.borderWidth
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    fileprivate lazy var textView: UITextView = {
        var view = UITextView(frame: .zero)
        view.backgroundColor = .white
        view.layer.cornerRadius = K.UI.cornerRadius
        view.layer.borderWidth = K.UI.borderWidth
        view.textColor = .label
        view.isEditable = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    fileprivate lazy var loadingView = LoadingView(frame: .zero)
    fileprivate lazy var emptyStateView = EmptyStateView(frame: .zero)
    fileprivate var viewModel: MeetingViewModel!
    fileprivate var commomConstraints: [NSLayoutConstraint] = []
    
    // MARK: - Initializer
    
    init(viewModel: MeetingViewModel, title: String) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.title = title
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        viewModel.viewDelegate = self
        fetchMeeting()
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIAccessibility.post(notification: .screenChanged, argument: navigationController?.navigationBar)
    }
    
    // MARK: - Private Methods
    
    fileprivate func setUpUI() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = K.Color.hugoBlue
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.backgroundColor = .systemBackground
        showEmptyStateView(false)
    }
    
    fileprivate func showLoading(_ isLoading: Bool) {
        DispatchQueue.main.async {
            self.loadingView.isHidden = !isLoading
            isLoading ? self.loadingView.startLoading() : self.loadingView.stopLoading()
        }
    }
    
    fileprivate func showEmptyStateView(_ show: Bool = true, type: EmptyStateViewType = .error) {
        DispatchQueue.main.async {
            self.emptyStateView.setUp(type: type)
            self.emptyStateView.isHidden = !show
            self.showReloadButton(show)
        }
    }
    
    fileprivate func showReloadButton(_ show: Bool) {
        if show {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "arrow.counterclockwise"), style: .plain, target: self, action: #selector(fetchMeeting))
        } else {
            navigationItem.backBarButtonItem = nil
        }
    }
    
    @objc fileprivate func fetchMeeting() {
        viewModel.fetchMeeting()
    }
}

// MARK: - MeetingViewModelDelegate

extension MeetingViewController: MeetingViewModelDelegate {
    
    func meetingViewModelDelegateDidFetchMeeting(_ viewModel: MeetingViewModel) {
        DispatchQueue.main.async {
            self.textView.attributedText = viewModel.meetingModel?.htmlContent?.htmlToAttributedString
        }
        self.showEmptyStateView(false)
    }
    
    func meetingViewModelDelegateIsLoading(_ viewModel: MeetingViewModel, isLoading: Bool) {
        showLoading(isLoading)
    }
    
    func meetingViewModelDelegateError(_ viewModel: MeetingViewModel) {
        showEmptyStateView()
    }
}

// MARK: - ViewConfiguration

extension MeetingViewController: ViewConfiguration {
    func buildViewHierarchy() {
        view.addSubview(containerView)
        view.addSubview(loadingView)
        view.addSubview(emptyStateView)
        containerView.addSubview(textView)
    }
    
    func setUpConstraints() {
        commomConstraints = [
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: K.Constraint.top),
            containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: K.Constraint.leading),
            containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: K.Constraint.trailing),
            
            loadingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo:  view.bottomAnchor),
            
            emptyStateView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            emptyStateView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            emptyStateView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            emptyStateView.bottomAnchor.constraint(equalTo:  view.bottomAnchor),
            
            textView.topAnchor.constraint(equalTo: containerView.topAnchor),
            textView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ]
        
        if UIDevice.current.hasNotch {
            commomConstraints.append(containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        } else {
            commomConstraints.append(containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: K.Constraint.bottom))
        }
        
        updateLayoutConstraints()
    }
    
    func updateLayoutConstraints() {
        NSLayoutConstraint.activate(commomConstraints)
    }
}
