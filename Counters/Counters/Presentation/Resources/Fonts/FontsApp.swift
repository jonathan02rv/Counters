//
//  FontsApp.swift
//  Counters
//
//  Created by Jhonatahan on 11/19/20.
//

import Foundation

enum FontsApp{
    case regular
    case bold
    
    func getFontName()->String{
        switch self {
        case .regular:
            return "SFProDisplay-Regular"
        case .bold:
            return "SFProDisplay-Bold"
        }
    }

}
