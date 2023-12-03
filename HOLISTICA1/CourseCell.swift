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
            if let icon = course.icon, let uimage = UIImage(data: icon) {
                Image(uiImage: uimage)
                    .resizable()
                    .scaledToFill()
                    .padding()
                    .frame(width: 80, height: 80)
                    .cornerRadius(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.redwood, lineWidth: 5)
                    }
                    .background(Color.almond)
                    .cornerRadius(10)
                    .shadow(radius: 4)
            }
            
            VStack(alignment: .center, spacing: 4) {
                Text("\(course.name) programs")
                    .font(.title2)
                    .bold()
                    .foregroundColor(Color.sand)
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
        .frame(width: 275, height: 250, alignment: .center)
        .padding()
        //.background(Color.sand)
        .background {
            if let image = course.image, let uimage = UIImage(data: image) {
                Image(uiImage: uimage)
                    .resizable()
                    .scaledToFill()
                    .opacity(0.8)
                    .overlay {
                        Rectangle()
                            .opacity(0.3)
                    }
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
