//
//  ChoosePatient.swift
//  OrganforEveryone
//
//  Created by Hana Shen on 2020/11/20.
//

import SwiftUI

struct ChoosePatient: View {
    @EnvironmentObject var appModel : AppModel
    @State var searchText = ""
    @State var isSearching = false
    var body: some View {
        ScrollView{
            searchBarView(searchText: $searchText, isSearching: $isSearching)
            ForEach((appModel.patients.map{$0.name}).filter({"\($0)".contains(searchText) || searchText.isEmpty} ), id: \.self){patient in
                HStack{
                    Text(patient)
                    Spacer()
                }.padding()
                .onTapGesture(perform: {
                    isSearching = false
                    searchText = patient
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    let index = appModel.patients.firstIndex(where: {$0.name == patient})
                    appModel.chosenPatient = appModel.patients[index!]
                })
                
                Divider()
                    .background(Color(.systemGray4))
                    .padding(.leading)
            }
        }.navigationTitle("Choose Patient")
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                next
            }
        }
    }
    var next : some View{
        NavigationLink(
            destination: ChooseHospitalView(),
            label: {
                Text("Next")
            })
    }
}

struct ChoosePatient_Previews: PreviewProvider {
    static var previews: some View {
        ChoosePatient()
    }
}
