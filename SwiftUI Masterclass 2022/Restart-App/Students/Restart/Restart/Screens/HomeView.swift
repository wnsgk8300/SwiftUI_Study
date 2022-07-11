//
//  HomeView.swift
//  Restart
//
//  Created by photypeta-junha on 2022/07/07.
//

import SwiftUI

struct HomeView: View {
    // MARK: - Property
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = false
    var body: some View {
        VStack(spacing: 20) {
            // MARK: - Header
            
            Spacer()
            
            ZStack {
                CircleGroupView(ShapeColor: .gray, ShapeOpacity: 0.1)
                
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                .padding()
            }

            // MARK: - Center
            
            Text("The time taht leads to mastery is dependent on the intensity of out focus.")
                .font(.title3)
                .fontWeight(.light)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
            
            
            
            // MARK: - Footer
            
            Spacer()
            
            Button(action: {
                isOnboardingViewActive = true
            }) {
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                Text("Restart")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
                
            } //: Button
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            
        } //: VStack
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
