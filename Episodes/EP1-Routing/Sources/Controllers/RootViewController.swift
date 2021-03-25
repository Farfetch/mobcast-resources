//
//  RootViewController.swift
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

final class RootViewController: UIViewController {

    private unowned let navigator: ListingNavigation & DetailNavigation

    private let rootView = RootView()

    init(navigator: ListingNavigation & DetailNavigation) {

        self.navigator = navigator

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {

        view = rootView
    }

    override func viewDidLoad() {

        super.viewDidLoad()

        rootView.listingClosure = { [weak self] in

            self?.navigator.navigateToListing()
        }

        rootView.detailClosure = { [weak self] in

            self?.navigator.navigateToDetail(id: 5)
        }

        title = "Root"
    }
}

// MARK: - RootView

final class RootView: UIView {

    var listingClosure: (() -> Void)?

    var detailClosure: (() -> Void)?

    private lazy var listingButton = Self.createButton(title: "Go to Listing") { [weak self] _ in self?.listingClosure?() }

    private lazy var detailButton = Self.createButton(title: "Go to Detail #5") { [weak self] _ in self?.detailClosure?() }

    private lazy var stackView: UIStackView = {

        let stackView = UIStackView(arrangedSubviews: [
            listingButton,
            detailButton
        ])

        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 24

        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        configureSubviews()
    }

    func configureSubviews() {

        addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stackView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }

    private static func createButton(title: String, handler: @escaping UIActionHandler) -> UIButton {

        let action = UIAction(title: title, handler: handler)
        let button = UIButton(type: .system, primaryAction: action)

        return button
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
