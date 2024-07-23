//
//  LocationMapAnnotationView.swift
//  Mappy
//
//  Created by Erik Valigurský on 23/07/2024.
//

import SwiftUI

struct LocationMapAnnotationView: View {
    
//    let accentColor = Color("AccentColor")
    
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "pin.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .font(.headline)
                .foregroundStyle(.accent)
                .padding(.bottom, 40)
        }
    }
}

#Preview {
    LocationMapAnnotationView()
}
