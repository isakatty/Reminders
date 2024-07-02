//
//  Constant.swift
//  Reminders
//
//  Created by Jisoo Ham on 7/2/24.
//

import UIKit

enum Constant {
    enum Font {
        static let regular13 = UIFont.systemFont(ofSize: 13)
        static let regular14 = UIFont.systemFont(ofSize: 14)
        static let regular15 = UIFont.systemFont(ofSize: 15)
        static let regular16 = UIFont.systemFont(ofSize: 16)
        static let regular17 = UIFont.systemFont(ofSize: 17)
    }
    
    enum Color {
        static let white = UIColor.white
        static let lightGray = UIColor.lightGray
        static let darkGray = UIColor.darkGray
        static let black = UIColor.black
    }
    
    enum Spacing {
        case four
        case eight
        case twelve
        case sixteen
        
        var toCGFloat: CGFloat {
            switch self {
            case .four:
                4
            case .eight:
                8
            case .twelve:
                12
            case .sixteen:
                16
            }
        }
    }
}
