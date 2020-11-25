//
//  ChooseHospitalView.swift
//  OrganforEveryone
//
//  Created by Hana Shen on 2020/11/20.
//

import SwiftUI

struct ChooseHospitalView: View {
    @EnvironmentObject var appModel : AppModel
    @State var searchText = ""
    @State var isSearching = false
    var body: some View {
        ScrollView{
            searchBarView(searchText: $searchText, isSearching: $isSearching)
            ForEach((appModel.hospitals.map{$0.name}).filter({"\($0)".contains(searchText) || searchText.isEmpty}), id: \.self){hospital in
                if (hospital != "name"){
                HStack{
                    Text(hospital)
                    Spacer()
                    
                }.padding()
                .onTapGesture(perform: {
                    isSearching = false
                    searchText = hospital
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    let index = appModel.hospitals.firstIndex(where: {$0.name == hospital})
                    appModel.chosenHospital = appModel.hospitals[index!]
                })
                }
                Divider()
                    .background(Color(.systemGray4))
                    .padding(.leading)
            }
        }.navigationTitle("Choose Hospital")
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                next
            }
        }
    }
    //.filter({"\($0)".contains(searchText) || searchText.isEmpty}
    var next : some View{
        NavigationLink(
            destination: ConfirmPageView(),
            label: {
                Text("Next")
            })
    }
}

struct ChooseHospitalView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseHospitalView()
    }
}

