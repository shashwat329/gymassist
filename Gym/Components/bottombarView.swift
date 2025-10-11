//
//  bottombarView.swift
//  patna metro
//
//  Created by shashwat singh on 11/09/25.
//

import SwiftUI

struct bottombarView: View {
        var body: some View {
            VStack(spacing: 12) {
                Text("Or reach out to me here:")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                HStack(spacing: 24) {
                    Link(destination: URL(string: "https://www.instagram.com/mypatnametro")!) {
                        Label("Instagram", systemImage: "camera")
                            .foregroundColor(Color.theme)
                    }

                    Link(destination: URL(string: "https://www.mypatnametro.com")!) {
                        Label("mypatnametro.com", systemImage: "globe")
                            .foregroundColor(Color.theme)
                    }
                }
                .font(.subheadline)
            }
        }
    }


#Preview {
    bottombarView()
}
