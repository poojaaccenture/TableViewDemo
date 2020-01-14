//
//  BaseCellViewModel.swift
//  TableviewDemo
//
//  Created by Pooja Gupta on 13/01/20.
//  Copyright © 2020 Organization. All rights reserved.
//

import UIKit

class BaseCellViewModel {
    let title: LabelText?
    let description: LabelText?
    let imageUrl: String?
    
    init(title: LabelText?, description: LabelText?, imageUrl: String?) {
        self.title = title
        self.description = description
        self.imageUrl = imageUrl
    }
}
