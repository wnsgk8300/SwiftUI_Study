//
//  ContentView.swift
//  Pinch
//
//  Created by photypeta-junha on 2022/07/12.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Property
    @State private var isAnimating: Bool = false
    // 이미지에 더블탭 제스쳐
    @State private var imageScale: CGFloat = 1
    
    // MARK: - Function
    
    // MARK: - Content
    
    var body: some View {
        NavigationView {
            ZStack {
                // MARK: - Page Image
                Image("magazine-front-cover")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                // 앱 런치시 이미지 셰도잉 효과
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
                // = .animation(.linear(duration: 1), value: isAnimating)
                    .opacity(isAnimating ? 1 : 0)
                    .scaleEffect(imageScale)
                // MARK: - 1. Tap Gesture
                // 더블 탭으로 확대 축소함
                    .onTapGesture(count: 2) {
                        if imageScale == 1 {
                            withAnimation(.spring()) {
                                imageScale = 5
                            }
                        } else {
                                withAnimation(.spring()) {
                                    imageScale = 1
                                }
                            }
                    }
            } //: ZStack
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                withAnimation(.linear(duration: 1)) {
                    // do not enter th With Animation here
                    isAnimating = true
                }
            })
        } //: Navigation
        .navigationViewStyle(.stack)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
            .previewDevice("iPhone 13")
    }
}
