//
//  ViewConfiguration.swift
//  meeting notes
//
//  Created by Matheus Pedrosa on 05/06/21.
//

import Foundation

protocol ViewConfiguration: class {
    func configureView()
    func buildViewHierarchy()
    func setUpConstraints()
    func updateLayoutConstraints()
}

extension ViewConfiguration {
    func configureView() {
        buildViewHierarchy()
        setUpConstraints()
    }
}
