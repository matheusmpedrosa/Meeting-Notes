//
//  LoadingView.swift
//  meeting notes
//
//  Created by Matheus Pedrosa on 07/06/21.
//

import UIKit

class LoadingView: UIView {

    // MARK: - Properties
    
    fileprivate lazy var loadingView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate lazy var activityIndicatorView: UIActivityIndicatorView = {
        var view = UIActivityIndicatorView(frame: .zero)
        view.hidesWhenStopped = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    fileprivate var commomConstraints: [NSLayoutConstraint] = []
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func startLoading() {
        activityIndicatorView.startAnimating()
    }
    
    func stopLoading() {
        activityIndicatorView.stopAnimating()
    }

}

// MARK: - ViewConfiguration

extension LoadingView: ViewConfiguration {
    func buildViewHierarchy() {
        addSubview(loadingView)
        loadingView.addSubview(activityIndicatorView)
    }
    
    func setUpConstraints() {
        commomConstraints = [
            loadingView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo:  bottomAnchor),
            
            activityIndicatorView.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor)
        ]
        
        updateLayoutConstraints()
    }
    
    func updateLayoutConstraints() {
        NSLayoutConstraint.activate(commomConstraints)
    }
}
