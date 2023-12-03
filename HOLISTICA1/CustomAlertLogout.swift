//
//  CustomAlertLogout.swift
//  HOLISTICA1
//
//  Created by Miguel Ridruejo on 19/11/23.
//

import SwiftUI

struct CustomAlertLogout<Content:View>: View {
    let title:String
    let message:String

    @Binding var showAlert:Bool

    @ViewBuilder var actions:() -> Content
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.black.opacity(0.5))
                .ignoresSafeArea()
                .opacity(showAlert ? 1.0 : 0.0)
                .onTapGesture {
                    showAlert.toggle()
                }
            
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color.init(white: 0.9))
                .frame(height: 125)
                .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
                .padding(.horizontal)
                .overlay {
                    VStack {
                        Text(title)
                            .bold()
                        Text(message)
                            .font(.caption)
                            .multilineTextAlignment(.center)
                        HStack {
                            actions()
                        }
                        .buttonStyle(.bordered)
                    }
                    .padding(.horizontal, 30)
                }
                .padding(.horizontal)
                .opacity(showAlert ? 1.0 : 0.0)
                .offset(y: showAlert ? 0.0 : 500)
        }
    }
}

#Preview {
    CustomAlertLogout(title: "Are you sure you wish to log out?",
                      message: "Confirm you wish to log out.",
                      showAlert: .constant(true)) {
          Button {
              
          } label: {
              Text("Log out")
          }
      }
}

