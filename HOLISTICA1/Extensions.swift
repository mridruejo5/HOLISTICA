//
//  Extensions.swift
//  HOLISTICA1
//
//  Created by Miguel Ridruejo on 2/11/23.
//

import SwiftUI

extension Notification.Name {
    static let loginSIWAOK = Notification.Name("LOGINSIWAOK")
}

extension Color {
    static let charcoal = Color(.sRGB, red: 54/255, green: 77/255, blue: 95/255)
    static let sand = Color(.sRGB, red: 244/255, green: 238/255, blue: 232/255)
    static let almond = Color(.sRGB, red: 201/255, green: 175/255, blue: 146/255)
    static let redwood = Color(.sRGB, red: 141/255, green: 67/255, blue: 53/255)
    static let cadetGray = Color(.sRGB, red: 132/255, green: 158/255, blue: 169/255)
    static let gunmetal = Color(.sRGB, red: 22/255, green: 36/255, blue: 46/255)
    static let black = Color(.sRGB, red: 29/255, green: 29/255, blue: 27/255)
    
    
}

struct NoArrowNavigationButtonStyle: PrimitiveButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(Rectangle()) // Make the whole area tappable
            .onTapGesture {
                configuration.trigger()
            }
    }
}
