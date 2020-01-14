//
//  Enum.swift
//  TableViewDemo
//
//  Created by Pooja Gupta on 13/01/20.
//  Copyright © 2020 Accenture. All rights reserved.
//

import UIKit

enum CellIdentifier {
    
    //Tableview cell
   static let baseTableViewCell = "BaseTableViewCell"
}

enum LabelText {
    case text (_ text: String?)
    case textWithStyle (_ text: TextWithStyle?)
    case attributedText (_ attributedText: NSAttributedString?)
    
    var text: TextWithStyle? {
        if case .text(let text?) = self {
            return TextWithStyle(text: text)
        }
        
        if case .textWithStyle(let textWithStyle?) = self {
            return textWithStyle
        }
        
        return nil
    }
    
    var attributedText: NSAttributedString? {
        guard case .attributedText(let attributedText?) = self else { return nil }
        return attributedText
    }
}
