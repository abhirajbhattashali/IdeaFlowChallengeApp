
//
//  SplashView.swift
//  KnowMe
//
//  Created by Abhiraj on 11/03/23.
//

import SwiftUI

struct SplashView: View {
    @State var isActive:Bool = false
    @State private var image = UIImage()
    @State private var showSheet = false
    var body: some View {
        ZStack {
        
            VStack{
                if self.isActive{
                    ZStack{
                        Color.white.edgesIgnoringSafeArea(.all)
                        MainScreenView()
                    }
                }
                else{
                    ZStack {
                        Color.white.edgesIgnoringSafeArea(.all)
                        VStack(alignment: .center){
                            Image("design")
                                .renderingMode(.original)
                                .resizable()
                            .frame(width: 300,height: 350,alignment: .center)
                            Text("IdeaFlow")
                                .font(.title)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .shadow(color: .black, radius:5)
                        }
                    }
                
                       
                }
                

            }
            
            .padding(10)

            .onAppear{
                DispatchQueue.main.asyncAfter(deadline:.now() + 4){
                    withAnimation{
                        self.isActive = true
                    }
                }
        }
        }
            
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
