//
//  ViewConfiguration.swift
//  FashionApp
//
//  Created by Anderson Oliveira on 02/04/23.
//

import Foundation

protocol ViewConfiguration {
    func setupViews()
    func configViews()
    func buildViews()
    func setupConstraints()
}

extension ViewConfiguration {
    func setupViews() {
        configViews()
        buildViews()
        setupConstraints()
    }
}

