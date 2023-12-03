//
//  ProgramCell.swift
//  HOLISTICA1
//
//  Created by Miguel Ridruejo on 11/11/23.
//

import SwiftUI

struct ProgramCell: View {
    let program: CoursePrograms
    
    var body: some View {
        VStack(alignment: .center) {
            
            /*
            if let image = program.image, let uimage = UIImage(data: image) {
                Image(uiImage: uimage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 350, height: 225)
                    .cornerRadius(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gunmetal, lineWidth: 5)
                    }
                    .background(Color.charcoal)
            }*/
            Image("EliteProgram")
                .resizable()
                .scaledToFit()
                .overlay {
                    Rectangle()
                        .stroke(Color.gunmetal, lineWidth: 5)
                }
            VStack {
                Text("\(program.name)")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(program.description)
                    .font(.subheadline)
                    .foregroundStyle(Color.white)
                    .foregroundColor(.secondary)
            }
            .padding(20)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
        }
        .background(Color.cadetGray)
        .clipShape(.rect(cornerRadius: 10))
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gunmetal, lineWidth: 5)
        }
        .shadow(radius: 4)
    }
}

#Preview {
    ProgramCell(program: testPrograms.first!)
}
