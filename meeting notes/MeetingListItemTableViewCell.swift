//
//  MeetingListItemTableViewCell.swift
//  meeting notes
//
//  Created by Matheus Pedrosa on 05/06/21.
//

import UIKit

class MeetingListItemTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    fileprivate lazy var titleLabel: UILabel = {
        var label: UILabel = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.accessibilityTraits = .staticText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    fileprivate lazy var descriptionLabel: UILabel = {
        var label: UILabel = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.accessibilityTraits = .staticText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return label
    }()
    
    fileprivate lazy var accessoryLabel: UILabel = {
        var label: UILabel = UILabel(frame: .zero)
        label.text = K.Title.accessoryLabelTitle
        label.textAlignment = .right
        label.accessibilityLabel = K.Title.accessoryLabelTitle
        label.accessibilityTraits = .staticText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        return label
    }()
    fileprivate var commomConstraints: [NSLayoutConstraint] = []
    fileprivate var regularConstraints: [NSLayoutConstraint] = []
    fileprivate var largeTextConstraints: [NSLayoutConstraint] = []

    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Public Methods
    
    func setUpCell(title: String?, description: String?, accessoryLabelIsHidden: Bool) {
        titleLabel.text = title
        titleLabel.accessibilityLabel = title
        descriptionLabel.text = description
        if accessoryLabelIsHidden {
            accessoryLabel.text = nil
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        let accessibilityCategory = traitCollection
                                    .preferredContentSizeCategory
                                    .isAccessibilityCategory
        if accessibilityCategory != previousTraitCollection?
                                    .preferredContentSizeCategory
                                    .isAccessibilityCategory {
            updateLayoutConstraints()
        }
    }
}

// MARK: - ViewConfiguration

extension MeetingListItemTableViewCell: ViewConfiguration {
    func buildViewHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(accessoryLabel)
    }
    
    func setUpConstraints() {
        commomConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: K.Constraint.leading),
            titleLabel.bottomAnchor.constraint(greaterThanOrEqualTo: descriptionLabel.topAnchor, constant: K.Constraint.bottom),
            
            descriptionLabel.topAnchor.constraint(greaterThanOrEqualTo: titleLabel.bottomAnchor, constant: K.Constraint.top),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: K.Constraint.leading),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: K.Constraint.trailing),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: K.Constraint.bottom),
            
            accessoryLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: K.Constraint.top),
            accessoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: K.Constraint.trailing)
        ]
        
        regularConstraints = [
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: K.Constraint.top),
            titleLabel.trailingAnchor.constraint(greaterThanOrEqualTo: accessoryLabel.leadingAnchor, constant: K.Constraint.trailing)
        ]

        largeTextConstraints = [
            titleLabel.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: accessoryLabel.lastBaselineAnchor, multiplier: 1),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: K.Constraint.trailing)
        ]
        
        updateLayoutConstraints()
    }
    
    func updateLayoutConstraints() {
        NSLayoutConstraint.activate(commomConstraints)
        if traitCollection.preferredContentSizeCategory.isAccessibilityCategory {
            NSLayoutConstraint.deactivate(regularConstraints)
            NSLayoutConstraint.activate(largeTextConstraints)
        } else {
            NSLayoutConstraint.deactivate(largeTextConstraints)
            NSLayoutConstraint.activate(regularConstraints)
        }
    }
}
