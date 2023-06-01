//
//  RadioButton.swift
//  GoTech Assignment
//
//  Created by Petr Blinov on 01.06.2023.
//

import SwiftUI

struct RadioButton: View {
    let text: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: isSelected ? "record.circle" : "circle")
                    .foregroundColor(.secondary)
                
                Text(text)
                    .foregroundColor(.primary)
                    .font(.system(size: 13))
            }
        }
    }
}
