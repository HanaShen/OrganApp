//
//  ChooseOrganView.swift
//  OrganforEveryone
//
//  Created by Hana Shen on 2020/11/20.
//

import SwiftUI

struct ChooseOrganView: View {
    @EnvironmentObject var appModel : AppModel
    @State private var didTap = false
    var threeColumnGrid = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        ScrollView{
            LazyVGrid(columns:threeColumnGrid, spacing: 20){
                ForEach(appModel.organs.map{$0.name}, id:\.self){organ in
                    //NavigationLink(destination: detailMOView(book: books[index])){
                    //Image(books[index].image)
                    Button(action:{
                        let index = appModel.organs.firstIndex(where: {$0.name == organ})
                        appModel.chosenOrgan = appModel.organs[index!]
                        
                    }){
                        VStack(spacing: 2){
                            Text(organ)
                                .bold()
                                .frame(width: 75, height: 100)
                                .background(appModel.chosenOrgan.name == organ ? Color.gray.opacity(0.4) : Color.white)
                                .cornerRadius(10)
                            Image(organ)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 75, height: 100)
                        }
                    }
                }
            }
        }.navigationTitle("Choose Organ")
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                next
            }
        }
    }
    var next : some View{
        NavigationLink(
            destination: ChoosePatient(),
            label: {
                Text("Next")
            })
    }
}

struct ChooseOrganView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseOrganView()
    }
}
