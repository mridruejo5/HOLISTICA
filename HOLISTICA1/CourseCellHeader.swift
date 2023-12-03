//
//  CourseCell.swift
//  HOLISTICA1
//
//  Created by Miguel Ridruejo on 2/11/23.
//

import SwiftUI

struct CourseCellHeader: View {
    let course: Course
    
    var body: some View {
        HStack(spacing: 10) {
            if let iconData = course.icon, let uiIconImage = UIImage(data: iconData) {
                Image(uiImage: uiIconImage)
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .frame(width: 80, height: 80)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.redwood, lineWidth: 5)
                    }
                    .background(Color.almond)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .padding(.trailing)
            }
            VStack(alignment: .leading, spacing: 4) {
                Text("\(course.name) Programs")
                    .font(.title)
                    .foregroundColor(.primary)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}



#Preview {
    CourseCellHeader(course: testCourses.first!)
}
