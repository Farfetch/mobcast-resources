//
//  ListingNavigation.swift
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

public protocol ListingNavigation: class {

    @discardableResult
    func navigateToListing() -> UIViewController?
}
