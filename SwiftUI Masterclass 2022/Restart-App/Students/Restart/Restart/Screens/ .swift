//
//  OnboardingView.swift
//  Restart
//
//  Created by photypeta-junha on 2022/07/07.
//

//오른쪽에 미니맵 켜고 cmd누르고 커서 가져다대면 코드 구조에 대한 자세한 정보 얻을 수 있음
import SwiftUI
struct OnboardingView: View {
    // MARK: - Property
    // UserDefaults와 다르게, 기존의 onboarding 키를 찾지 못했을때만 작동함
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffset: CGFloat = 0
    
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            VStack(spacing: 20) {
                // MARK: - Header
                
                Spacer()
                
                VStack(spacing: 0) {
                    Text("Share.")
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    
                    Text("""
                    It's not how much we give but
                    how much leve we put into giving.
                    """)
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 10) // 여기서 opt + cmd + left하면 코드 접힘
                } //: Header
                // MARK: - Center
                
                ZStack {
                    CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.2)
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                } //: Center
                
                Spacer()
                
                // MARK: - Footer
                
                ZStack {
                    // Parts of the custom button
                    
                    // 1. Background (Static)
                    
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)
                    
                    
                    // 2. Call-To-Action (Static)
                    
                    Text("Get Started")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x: 20)
                    
                    // 3. Capsule (Dynamic Width)
                    
                    HStack {
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width: buttonOffset + 80)
                        
                        Spacer()
                    }
                    
                    // 4. Circle (Draggable)
                    
                    HStack {
                        ZStack {
                            Circle()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight: .bold))
                        }
                        .foregroundColor(.white)
                        .offset(x: buttonOffset )
                        .frame(width: 80, height: 80, alignment: .center)
                        .gesture(
                            // drag발생했을때와, 종료됐을때의 두 가지 상황이 있음
                            DragGesture()
                                .onChanged { gesture in
                                    // 레드 버튼 사이즈가 80*80이라서 buttonWidth - 80 해줌
                                    if gesture.translation.width > 0 && buttonOffset <= buttonWidth - 80 {
                                        buttonOffset = gesture.translation.width
                                    }
                                }
                            // 버튼 드래그 종료 후 원위치로 이동
                                .onEnded { _ in
                                    // 레드버튼 위치가 겟스타트 버튼 반 넘어가면 끝으로 이동시키고 뷰 이동
                                    if buttonOffset > buttonWidth / 2 {
                                        buttonOffset = buttonWidth - 80
                                        isOnboardingViewActive = false
                                    } else {
                                        buttonOffset = 0
                                    }
                                    buttonOffset = 0
                                }
                                          
                        ) // : Gesture
                        
                        Spacer()
                    } // : HStack
                } //: Footer
                .frame(width: buttonWidth, height: 80, alignment: .center)
                .padding()
            } //: VStack
        } //: ZStack
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
