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
            if let imageURL = program.image, let image = URL(string: imageURL) {
                AsyncImage(url: image) { phase in
                    switch phase {
                    case .empty:
                        ProgressView() // Placeholder while loading
                    case .success(let loadedImage):
                        loadedImage
                            .resizable()
                            .scaledToFill()
                            .frame(width: 350, height: 225)
                            .cornerRadius(10)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gunmetal, lineWidth: 5)
                            }
                            .background(Color.charcoal)
                    case .failure:
                        Image(systemName: "photo") // Placeholder for failure
                            .resizable()
                            .scaledToFill()
                            .frame(width: 350, height: 225)
                            .cornerRadius(10)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gunmetal, lineWidth: 5)
                            }
                            .background(Color.charcoal)
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                Image(systemName: "photo") // Placeholder for invalid URL
                    .resizable()
                    .scaledToFit()
                    //.frame(width: 350, height: 225)
                    .cornerRadius(10)
                    .background(Color.cadetGray)
            }
            
            VStack {
                Text("\(program.name)")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.primary)
                    .padding(.bottom)
                
                /*
                Text("Level: \(program.difficulty.rawValue)")
                    .font(.callout)
                    .foregroundColor(.white)
                    .padding(.bottom)
                 */
                
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
        .clipShape(RoundedRectangle(cornerRadius: 10))
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
