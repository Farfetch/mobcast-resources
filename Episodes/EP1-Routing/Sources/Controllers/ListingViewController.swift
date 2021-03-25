//
//  ListingViewController.swift
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

final class ListingViewController: UITableViewController {

    unowned let navigator: DetailNavigation

    init(navigator: DetailNavigation) {

        self.navigator = navigator

        super.init(style: .grouped)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {

        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()

        title = "Listing"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        self.navigator.navigateToDetail(id: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UI

extension ListingViewController {

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self)) else {

            return UITableViewCell()
        }

        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = "Item #\(indexPath.row)"

        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 10 }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? { "Items" }
}
