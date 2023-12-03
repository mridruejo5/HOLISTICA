//
//  ClassCell.swift
//  HOLISTICA1
//
//  Created by Miguel Ridruejo on 18/11/23.
//

import SwiftUI

struct ClassCell: View {
    let aClass:ProgramClasses
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text(aClass.name)
                    .font(.headline)
                Text(aClass.class_status.rawValue)
                    .font(.footnote)
                Text(aClass.description)
                    .font(.footnote)
                    .foregroundStyle(.secondary)

            }
            Spacer()
            Image(systemName: "play.fill")
                .resizable()
                .scaledToFit()
                .frame(height: 30)
                .foregroundStyle(Color.white)
                .padding()
                .padding(.leading, 5)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color.redwood)
                }
                .shadow(radius: 10)
            
        }
    }
}

#Preview {
    ClassCell(aClass: .class1)
}
