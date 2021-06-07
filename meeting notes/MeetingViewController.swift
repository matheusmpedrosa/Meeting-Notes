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
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    fileprivate lazy var textView: UITextView = {
        var view = UITextView(frame: .zero)
        view.backgroundColor = .white
        view.textColor = .label
        view.isEditable = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
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
        viewModel.fetchMeeting()
        view.backgroundColor = .systemBackground
    }
}

// MARK: - ViewConfiguration

extension MeetingViewController: ViewConfiguration {
    func buildViewHierarchy() {
        view.addSubview(containerView)
        containerView.addSubview(textView)
    }
    
    func setUpConstraints() {
        commomConstraints = [
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: K.Constraint.top),
            containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: K.Constraint.leading),
            containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: K.Constraint.trailing),
            
            textView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 4),
            textView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 4),
            textView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -4),
            textView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -4)
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

// MARK: - MeetingViewModelDelegate

extension MeetingViewController: MeetingViewModelDelegate {
    func meetingViewModelDelegateDidFetchMeeting(_ viewModel: MeetingViewModel) {
        DispatchQueue.main.async {
            self.textView.attributedText = viewModel.meetingModel?.htmlContent?.htmlToAttributedString
        }
    }
}
