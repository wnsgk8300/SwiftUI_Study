//
//  CircleGroupView.swift
//  Restart
//
//  Created by photypeta-junha on 2022/07/08.
//

import SwiftUI

struct CircleGroupView: View {
    
    @State var ShapeColor: Color
    @State var ShapeOpacity: Double
    
    var body: some View {
        // MARK: - Property
         
        // MARK: - Body
        ZStack {
            Circle()
                .stroke(ShapeColor.opacity(ShapeOpacity), lineWidth: 40)
                .frame(width: 260, height: 260, alignment: .center)
            Circle()
                .stroke(ShapeColor.opacity(ShapeOpacity), lineWidth: 80)
                .frame(width: 260, height: 260, alignment: .center)
        } //: ZStack
    }
}

struct CircleGroupView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.2)
        }
    }
}
