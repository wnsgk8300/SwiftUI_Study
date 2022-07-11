//
//  ContentView.swift
//  Restart
//
//  Created by photypeta-junha on 2022/07/07.
//

import SwiftUI

struct ContentView: View {
// AppStorage: SwiftUI의 Property Wrapper, 장치의 영구 저장소에 값 저장
// onboarding - 여기서의 UserDefaults Key
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    
    var body: some View {
        ZStack {
            if isOnboardingViewActive {
                OnboardingView()
            } else {
                HomeView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
