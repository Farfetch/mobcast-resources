//
//  DetailViewController.swift
//  Routing
//
//  Created by André Patrício on 21/07/2020.
//
//  Copyright (c) 2020-present, Farfetch.
//  All rights reserved.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

import UIKit

final class DetailViewController: UIViewController {

    private let itemId: Int
    private let detailView = DetailView()

    init(itemId: Int) {

        self.itemId = itemId

        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {

        view = detailView
    }

    override func viewDidLoad() {

        super.viewDidLoad()

        detailView.label.text = String(itemId)
        title = "Detail \(itemId)"
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {

        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - DetailView

final class DetailView: UIView {

    let label: UILabel = {
        
        let label = UILabel()
        label.font = .systemFont(ofSize: 150, weight: .bold)

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        configureSubviews()
    }

    private func configureSubviews() {

        addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
