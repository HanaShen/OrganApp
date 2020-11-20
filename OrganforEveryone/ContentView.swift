//
//  ContentView.swift
//  OrganforEveryone
//
//  Created by Hana Shen on 2020/10/6.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appModel : AppModel
   // var api : API
    @State var posts: [String] = []
    var body: some View {
        NavigationView{
//            List{
//                ForEach(posts, id: \.self){post in
//                    Text(post)
//                }
//            }
//            .onAppear{
//                API().getPosts{(posts) in
//                    self.posts = posts
//                }
//            }
            ZStack{
                Color.red.opacity(0.6)
                VStack(alignment: .center, spacing: 50){
                    //LogoView()
                    Text("Organ for Everyone")
                        .foregroundColor(Color.white)
                        .font(.system(size: 50, weight: .bold, design: .rounded))
                        
                    NavigationLink(destination:RootView() ){
                        Text("Start")
                            .foregroundColor(Color.white)
                            .font(.system(size: 25, weight: .heavy, design: .rounded))
                            .padding()
                            .background(RoundedRectangle(cornerRadius:20).fill(Color.gray.opacity(0.8)))
                    }
                }
            }.edgesIgnoringSafeArea(.all)
        }.environmentObject(appModel)
    }
}

struct RootView: View{
    @EnvironmentObject var appModel : AppModel
    var body: some View{
        VStack{
            ChooseOrganView()
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
