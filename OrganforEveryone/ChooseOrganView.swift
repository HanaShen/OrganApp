//
//  ChooseOrganView.swift
//  OrganforEveryone
//
//  Created by Hana Shen on 2020/11/20.
//

import SwiftUI

struct ChooseOrganView: View {
    @EnvironmentObject var appModel : AppModel
    var threeColumnGrid = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        ScrollView{
            LazyVGrid(columns:threeColumnGrid, spacing: 20){
                ForEach(appModel.organs.map{$0.name}, id:\.self){organ in
                    //NavigationLink(destination: detailMOView(book: books[index])){
                    //Image(books[index].image)
                    Text(organ)
                        //.resizable()
                        .frame(width: 100, height: 180)
                        .cornerRadius(10)
                }
            }
        }.navigationTitle("Choose Organ")
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
