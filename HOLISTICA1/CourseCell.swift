//
//  CourseCell2.swift
//  HOLISTICA1
//
//  Created by Miguel Ridruejo on 10/11/23.
//

import SwiftUI

struct CourseCell: View {
    let course: Course
    
    var body: some View {
        VStack(spacing: 10) {
            VStack(alignment: .center, spacing: 4) {
                Text("\(course.name) programs")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color.white)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    .padding(.top)
                
                Text(course.catchphrase)
                    .font(.callout)
                    .foregroundStyle(Color.white)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                
            }
        }
        .frame(width: 320, height: 250, alignment: .center)
        .padding()
        .background {
            if let imageURLString = course.image, let imageURL = URL(string: imageURLString) {
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .empty:
                        Image(systemName: "photo") // Placeholder for failure
                            .resizable()
                            .scaledToFill()
                            .opacity(0.4)
                    case .success(let loadedImage):
                        loadedImage
                            .resizable()
                            .scaledToFill()
                            .opacity(0.8)
                            .overlay {
                                Rectangle()
                                    .opacity(0.4)
                            }
                    case .failure:
                        Color.cadetGray // Placeholder while loading
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                Color.cadetGray // Placeholder for invalid URL
            }
        }

        .cornerRadius(10)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.redwood, lineWidth: 10)
        }
        .shadow(radius: 4)
    }
}


#Preview {
    CourseCell(course: testCourses.first!)
}
