//
//  Color+RGB.swift
//  GoTech Assignment
//
//  Created by Petr Blinov on 01.06.2023.
//

import SwiftUI

extension Color {    
    init(r: Double, g: Double, b: Double) {
        self.init(red: r / 255, green: g / 255, blue: b / 255)
    }
}

