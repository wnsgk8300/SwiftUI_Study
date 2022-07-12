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
    // A property to control the animation
    @State private var isAnimating: Bool = false
    // = @State private var imageOffset: CGSize = CGSize(width: 0, height: 0)
    @State private var imageOffset: CGSize = .zero
    // <-> 이화살표 투명하게 만들기
    @State private var indicatorOpacity: Double = 1.0
    @State private var textTitle: String = "Share."
    // 진동 추가
    let hapticFeedback = UINotificationFeedbackGenerator()
    
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            VStack(spacing: 20) {
                // MARK: - Header
                
                Spacer()
                
                VStack(spacing: 0) {
                    // text value change
                    // SwiftUI considers this View the same reggardless of the value change
                    Text(textTitle)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    // 불투명으로 애니매이셔 전환을 제공해야함
                        .transition(.opacity)
                    // 스유가 text바뀌어도 같은 View로 인식하는 문제 해결을위해 고유id 부여
                        .id(textTitle)
                    
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
                // 삼항연산자 Ternary Operator 애니매이션을 사용할때 많이 사용된다.
                .opacity(isAnimating ? 1 : 0)
                // Slide Down
                .offset(y: isAnimating ? 0 : -40)
                // easeOut: Animation 모형 중 하나
                .animation(.easeOut(duration: 1), value: isAnimating)
                // MARK: - Center
                
                ZStack {
                    CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.2)
                    // 드래그 방향과 반대로 보내기 위해 -1 곱함
                        .offset(x: imageOffset.width * -1)
                        .blur(radius: abs(imageOffset.width / 5))
                        .animation(.easeOut(duration: 1), value: imageOffset)
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1: 0)
                        .animation(.easeOut(duration: 0.5), value: isAnimating)
                        .offset(x: imageOffset.width * 1.2, y: 0)
                    // rotationEffect는 각도와 Anchor두개의 파라미터를 가지며, Anchor 기본값은 Center이다
                        .rotationEffect(.degrees(Double(imageOffset.width / 20)))
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    // abs: 절대값 반환, 양 방향 150에서 드래그 종료
                                    if abs(imageOffset.width) <= 150 {
                                        imageOffset = gesture.translation
                                        // 드래그에 따라 <->화살표 투명도 변경
                                        withAnimation(.linear(duration: 0.25)) {
                                            indicatorOpacity = 0
                                            textTitle = "Give."
                                        }
                                    }
                                }
                                .onEnded { _ in
                                    imageOffset = .zero
                                    
                                    // 드래그 끝나면 다시 <->화사라표가 보이게
                                    withAnimation(.linear(duration: 0.25)) {
                                        indicatorOpacity = 1
                                        textTitle = "Share."
                                    }
                                }
                        ) //: Gesture
                        .animation(.easeOut(duration: 1), value: imageOffset)
                } //: Center
                .overlay(
                Image(systemName: "arrow.left.and.right.circle")
                    .font(.system(size: 44, weight: .ultraLight))
                    .foregroundColor(.white)
                    .offset(y: 20)
                    .opacity(isAnimating ? 1: 0)
                // 2초 후에 1초에 걸쳐 나타남
                    .animation(.easeOut(duration: 1).delay(2), value: isAnimating)
                    .opacity(indicatorOpacity)
                , alignment: .bottom
                )
                
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
                                    // View가 넘어갈 때 애니매이션 추가
                                    withAnimation(Animation.easeOut(duration: 0.4)) {
                                        // 레드버튼 위치가 겟스타트 버튼 반 넘어가면 끝으로 이동시키고 뷰 이동
                                        if buttonOffset > buttonWidth / 2 {
                                            // 진동 추가
                                            hapticFeedback.notificationOccurred(.success)
                                            playSound(sound: "chimeup", type: "mp3")
                                            buttonOffset = buttonWidth - 80
                                            isOnboardingViewActive = false
                                        } else {
                                            hapticFeedback.notificationOccurred(.warning)
                                            buttonOffset = 0
                                        }
                                        buttonOffset = 0
                                    }
                                }
                                          
                        ) // : Gesture
                        
                        Spacer()
                    } // : HStack
                } //: Footer
                .frame(width: buttonWidth, height: 80, alignment: .center)
                .padding()
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 :40)
                .animation(.easeOut(duration: 1), value: isAnimating)
            } //: VStack
        } //: ZStack
        .onAppear(perform: {
            isAnimating = true
        })
        // 다크모드로
        .preferredColorScheme(.dark)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
