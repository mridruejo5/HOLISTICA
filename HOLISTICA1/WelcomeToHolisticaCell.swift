//
//  WelcomeToHolisticaCell.swift
//  HOLISTICA1
//
//  Created by Miguel Ridruejo on 10/11/23.
//

import SwiftUI

struct WelcomeToHolisticaCell: View {
    
    let user: UserInfo?

    var body: some View {
        if let user = user {
            VStack(alignment: .leading, spacing: 8) {
                Text("Welcome to Holistica,")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Text(user.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .center)
                
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.vertical)
        }
    }
}


#Preview {
    WelcomeToHolisticaCell(user: .user1)
        .environmentObject(LoginVM())
}
