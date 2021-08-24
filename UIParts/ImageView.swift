//
//  ImageView.swift
//  UIParts
//
//  Created by Ryo Hanma on 2021/08/24.
//

import SwiftUI

struct ImageView: View {
    @State var isModalActive = false
    
    var body: some View {
        if !isModalActive {
            Image("periodic table")
                .resizable()
                .scaledToFit()
                .onTapGesture {
                    self.isModalActive.toggle()
                }
        } else {
            ModalImageView(isModalActive: $isModalActive).edgesIgnoringSafeArea(.all)
                    
        }
    }

}

struct ModalImageView: View {
    @Binding var isModalActive: Bool
    @State var scaleValue: CGFloat = 1.0
    
    var body: some View {
        VStack {
            Button("×"){
                isModalActive.toggle()
            }
            .frame(maxWidth: .infinity, alignment: .topTrailing)
            .foregroundColor(.gray)
            .padding(10)
            Image("periodic table")
                .resizable()
                .scaledToFit()
                .scaleEffect(scaleValue)
                .gesture(MagnificationGesture()
                            .onChanged { value in
                                self.scaleValue = value
                            })
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView()
    }
}
