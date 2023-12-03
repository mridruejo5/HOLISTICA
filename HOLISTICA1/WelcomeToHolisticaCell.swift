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
            HStack {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 75, height: 75,alignment: .leading)
                    .background(Color.gray.opacity(0.4))
                    .clipShape(Circle())
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Welcome to Holistica,")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Text(user.name)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                }
            }
            .frame(maxWidth: .infinity, alignment: .center).padding()
        }
    }
}


#Preview {
    WelcomeToHolisticaCell(user: .user1)
        .environmentObject(LoginVM())
}
