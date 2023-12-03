//
//  MyProgramsEmptyCell.swift
//  HOLISTICA1
//
//  Created by Miguel Ridruejo on 3/12/23.
//

import SwiftUI

struct MyProgramsEmptyCell: View {
    
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: 10)
            .frame(height: 150)
            .background(Color.gray)
            .opacity(0.05)
            .overlay {
                Text("Suscribe to a program to view it here")
                    .font(.subheadline)
                    .foregroundStyle(Color.secondary)
                    .padding(15)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}


#Preview {
    MyProgramsEmptyCell()
}
