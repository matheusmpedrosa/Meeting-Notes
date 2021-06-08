//
//  EmptyStateView.swift
//  meeting notes
//
//  Created by Matheus Pedrosa on 07/06/21.
//

import UIKit

enum EmptyStateViewType {
    case emptyList
    case error
}

class EmptyStateView: UIView {

    // MARK: - Properties
    
    fileprivate lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate lazy var emptyStateLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.accessibilityTraits = .staticText
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    fileprivate var commomConstraints: [NSLayoutConstraint] = []
    fileprivate var type: EmptyStateViewType = .error
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Private Methods
    
    func setUp(type: EmptyStateViewType) {
        switch type {
        case .emptyList:
            emptyStateLabel.text = K.Text.emptyListOfMeetingsText
            emptyStateLabel.accessibilityLabel = K.Text.emptyListOfMeetingsText
        case .error:
            emptyStateLabel.text = K.Text.somethingWentWrong
            emptyStateLabel.accessibilityLabel = K.Text.somethingWentWrong
        }
    }
}

extension EmptyStateView: ViewConfiguration {
    func buildViewHierarchy() {
        addSubview(containerView)
        containerView.addSubview(emptyStateLabel)
    }
    
    func setUpConstraints() {
        commomConstraints = [
            containerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo:  bottomAnchor),
            
            emptyStateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: K.Constraint.leading),
            emptyStateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: K.Constraint.trailing),
            emptyStateLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            emptyStateLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ]
        
        updateLayoutConstraints()
    }
    
    func updateLayoutConstraints() {
        NSLayoutConstraint.activate(commomConstraints)
    }
}
