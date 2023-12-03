//
//  BoughtProgramCell.swift
//  HOLISTICA1
//
//  Created by Miguel Ridruejo on 26/11/23.
//

import SwiftUI

struct BoughtProgramCell: View {
    
    let program:CoursePrograms
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(program.name)
                    .font(.headline)
                Text("Status: \(program.programState.rawValue)")
                    .font(.callout)
            }
            .padding()
            Spacer()
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 50, height: 50, alignment: .center)
                .foregroundStyle(Color.clear)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.redwood, lineWidth: 2)
                }
                .background {
                    if let image = program.image, let uimage = UIImage(data: image) {
                        Image(uiImage: uimage)
                            .resizable()
                            .cornerRadius(10)
                            .shadow(radius: 4)
                    }
                }
                .padding(.trailing)
        }
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.redwood, lineWidth: 5)
        }
        .background(Color.sand)
        .cornerRadius(10)
        .shadow(radius: 4)
    }
}


#Preview {
    BoughtProgramCell(program: .program1)
}
