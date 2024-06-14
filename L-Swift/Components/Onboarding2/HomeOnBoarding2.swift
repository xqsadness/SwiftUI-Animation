//
//  HomeOnBoarding2.swift
//  L-Swift
//
//  Created by xqsadness on 11/10/2023.
//

import SwiftUI

struct HomeOnBoarding2: View {
    // View properties
    @State private var activeIntro: PageIntro = pageIntros[0]
    @State private var emailID: String = ""
    @State private var passowrd: String = ""
    @State private var keyboardHeight: CGFloat = 0
    
    var body: some View {
        GeometryReader{
            let size = $0.size
            
            IntroView(intro: $activeIntro, size: size){
                /// user login./signup view
                VStack(spacing: 10){
                    //custom text field
                    CustomTextField(text: $emailID, hint: "Email Address", leadignIcon: Image(systemName: "envelope"))
                    CustomTextField(text: $passowrd, hint: "Password", leadignIcon: Image(systemName: "lock"), isPassword: true)
                    
                    Spacer(minLength: 10)
                    
                    Button{
                        
                    }label: {
                        Text("Continue")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.vertical, 15)
                            .hAlign(.center)
                            .background(
                                Capsule()
                                    .fill(.black)
                            )
                    }
                }
                .padding(.top, 25)
            }
        }
        .padding(15)
        ///manual keyboard push
        .offset(y: -keyboardHeight)
        ///Disabling native. keyboard push
        .ignoresSafeArea(.keyboard, edges: .all)
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { output in
            if let info = output.userInfo, let height = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height{
                keyboardHeight = height
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
            keyboardHeight = 0
        }
        .animation(.spring(response: 0.5, dampingFraction: 0.8, blendDuration: 0), value: keyboardHeight)
    }
}

struct HomeOnBoarding2_Previews: PreviewProvider {
    static var previews: some View {
        HomeOnBoarding2()
    }
}

// intro view
struct IntroView<ActionView: View>: View{
    @Binding var intro: PageIntro
    var size: CGSize
    var actionView: ActionView
    
    init(intro: Binding<PageIntro>, size: CGSize, @ViewBuilder actionView: @escaping () -> ActionView) {
        self._intro = intro
        self.size = size
        self.actionView = actionView()
    }
    ///Animation prop
    @State private var showView: Bool = false
    @State private var hideWholeView: Bool = false
    var body : some View{
        VStack{
            GeometryReader{
                let size = $0.size
                
                Image(intro.introAssetImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size.width, height: size.height)
            }
            ///moving up
            .offset(y: showView ? 0 : -size.height / 2)
            .opacity(showView ? 1 : 0)
            
            ///title and action
            VStack(alignment: .leading, spacing: 10){
                Spacer(minLength: 0)
                
                Text(intro.title)
                    .font(.system(size: 40))
                    .fontWeight(.black)
                
                Text(intro.subTitle)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.top, 15)
                
                if !intro.displayAction{
                    Group{
                        Spacer(minLength: 25)
                        
                        CustomIndicatorView(totalPages: pageIntros.count, currentPages: pageIntros.firstIndex(of: intro) ?? 0)
                        
                        Button{
                            changeIntro()
                        }label: {
                            Text("NEXT")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(width: size.width * 0.4)
                                .padding(.vertical, 15)
                                .background(
                                    Capsule()
                                        .fill(.black)
                                )
                        }
                        .hAlign(.center)
                    }
                }else{
                    actionView
                        .offset(y: showView ? 0 : size.height / 2)
                        .opacity(showView ? 1 : 0)
                }
            }
            .hAlign(.leading)
            ///moving down
            .offset(y: showView ? 0 : size.height / 2)
            .opacity(showView ? 1 : 0)
        }
        .offset(y: hideWholeView ? size.height / 2 : 0)
        .opacity(hideWholeView ? 0 : 1)
        
        ///back button
        .overlay(alignment: .topLeading) {
            /// hiding it for very first page , since there is no previous page present
            if intro != pageIntros.first{
                Button{
                    changeIntro(true)
                }label: {
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .contentShape(Rectangle())
                }
                .padding(10)
                ///Animating back button
                ///Comes from top when active
                .offset(y: showView ? 0 : -200)
                ///hides by going back to top when in active
                .offset(y: hideWholeView ? -200 : 0)
            }
        }
        .onAppear{
            withAnimation(.spring(response: 0.8, dampingFraction: 0.8, blendDuration: 0).delay(0.1)) {
                showView = true
            }
        }
    }
    
    func changeIntro(_ isprevious: Bool = false){
        withAnimation(.spring(response: 0.8, dampingFraction: 0.8, blendDuration: 0)) {
            hideWholeView = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            //updating page
            if let index = pageIntros.firstIndex(of: intro), (isprevious ? index != 0 : index != pageIntros.count - 1){
                intro = isprevious ? pageIntros[index - 1] : pageIntros[index + 1]
            }else{
                intro = isprevious ? pageIntros[0] : pageIntros[pageIntros.count - 1]
            }
            //re-animation as split page
            hideWholeView = false
            showView = false
            
            withAnimation(.spring(response: 0.8, dampingFraction: 0.8, blendDuration: 0)) {
                showView = true
            }
        }
    }
    
    var filterPages: [PageIntro]{
        return pageIntros.filter { !$0.displayAction }
    }
}
