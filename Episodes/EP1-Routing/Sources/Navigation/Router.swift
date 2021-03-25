//
//  Router.swift
//  Routing
//
//  Created by Francisco Amado on 11/09/2020.
//
//  Copyright (c) 2020-present, Farfetch.
//  All rights reserved.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

import Foundation
import UIKit

class Router {

    weak var navigationController: UINavigationController?
}

extension Router: ListingNavigation {

    public func navigateToListing() -> UIViewController? {

        let viewController = ListingViewController(navigator: self)

        push(viewController)

        return viewController
    }
}

extension Router: DetailNavigation {

    func navigateToDetail(id: Int) -> UIViewController? {

        let viewController = DetailViewController(itemId: id)

        push(viewController)

        return viewController
    }
}

private extension Router {

    func push(_ viewController: UIViewController, animated: Bool = true) {

        navigationController?.pushViewController(viewController, animated: animated)
    }
}
