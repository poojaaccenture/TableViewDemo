//
//  String.swift
//  TableviewDemo
//
//  Created by Pooja Gupta on 14/01/20.
//  Copyright © 2020 Organization. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
