//
//  LabelColors.swift
//  HabitTracker
//
//  Created by Vitor Trimer on 30/09/22.
//

import SwiftUI

func getLabelColor(fromIndex index: Int?) -> Color {
    var color: Color = Color(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1))
    
    if let index = index {
        switch index {
        case 1:
            color = Color(UIColor(red: 199/255, green: 62/255, blue: 62/255, alpha: 1))
        case 2:
            color = Color(UIColor(red: 217/255, green: 211/255, blue: 100/255, alpha: 1))
        case 3:
            color = Color(UIColor(red: 48/255, green: 138/255, blue: 54/255, alpha: 1))
        case 4:
            color = Color(UIColor(red: 40/255, green: 72/255, blue: 176/255, alpha: 1))
        case 5:
            color = Color(UIColor(red: 86/255, green: 35/255, blue: 158/255, alpha: 1))
        case 6:
            color = Color(UIColor(red: 128/255, green: 99/255, blue: 68/255, alpha: 1))
        case 7:
            color = Color(UIColor(red: 110/255, green: 110/255, blue: 110/255, alpha: 1))
        default:
            color = Color(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1))
            break
        }
    }
    
    return color
}
