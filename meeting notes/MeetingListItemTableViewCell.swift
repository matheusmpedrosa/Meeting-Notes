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
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    fileprivate lazy var descriptionLabel: UILabel = {
        var label: UILabel = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return label
    }()
    
    fileprivate lazy var accessoryLabel: UILabel = {
        var label: UILabel = UILabel(frame: .zero)
        label.text = K.Title.accessoryLabelTitle
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
    
    func setUpCell(title: String, description: String, accessoryLabelIsHidden: Bool) {
        titleLabel.text = title
        descriptionLabel.text = description
        accessoryLabel.isHidden = accessoryLabelIsHidden
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
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(greaterThanOrEqualTo: accessoryLabel.leadingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(greaterThanOrEqualTo: descriptionLabel.topAnchor, constant: -16),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            accessoryLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            accessoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ]
        
        updateLayoutConstraints()
    }
    
    func updateLayoutConstraints() {
        DispatchQueue.main.async {
            NSLayoutConstraint.activate(self.commomConstraints)
            
        }
    }
}
