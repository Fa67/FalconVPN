//
//  MenuOptions.swift
//  FalconVPN
//
//  Created by Mairambek on 2/26/20.
//  Copyright © 2020 Mairambek Abdrasulov. All rights reserved.
//

import UIKit

enum MenuOption: Int, CustomStringConvertible {
    
    case Pricing
    case PrivacyPolicy
    case Rules
    case Feedback

    
    var description: String {
        switch self {
        case .Pricing: return "  Pricing"
        case .PrivacyPolicy: return " Privacy Policy"
        case .Rules: return "  Rules"
        case .Feedback: return "  Feedback"
        }
    }
}


