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
            VStack {
                Text(program.name)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                Text("Status: \(program.programState.rawValue)")
                    .font(.callout)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            Spacer()
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 70, height: 50, alignment: .center)
                .foregroundStyle(Color.clear)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.redwood, lineWidth: 2)
                }
                .background {
                    if let imageURL = program.image, let image = URL(string: imageURL) {
                        AsyncImage(url: image) { phase in
                            switch phase {
                            case .empty:
                                Color.clear // Placeholder while loading
                            case .success(let loadedImage):
                                loadedImage
                                    .resizable()
                                    .cornerRadius(10)
                                    .shadow(radius: 4)
                            case .failure:
                                Image(systemName: "photo") // Placeholder for failure
                                    .resizable()
                                    .cornerRadius(10)
                                    .shadow(radius: 4)
                            @unknown default:
                                EmptyView()
                            }
                        }
                    } else {
                        Image(systemName: "photo") // Placeholder for invalid URL
                            .resizable()
                            .cornerRadius(10)
                            .shadow(radius: 4)
                    }
                }
                .padding(.trailing)

        }
        .background {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(Color.sand)
        }
        .background {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.redwood, lineWidth: 5)
                .shadow(radius: 5)
        }
    }
}


#Preview {
    BoughtProgramCell(program: .program1)
}
