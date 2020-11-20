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
            SearchBar(searchText: $searchText, isSearching: $isSearching)
            ForEach((appModel.hospitals).filter({"\($0)".contains(searchText) || searchText.isEmpty} ), id: \.self){hospital in
                HStack{
                    Text(hospital)
                    Spacer()
                }.padding()
                
                Divider()
                    .background(Color(.systemGray4))
                    .padding(.leading)
            }
        }.navigationTitle("Choose Hospital")
    }
}

struct ChooseHospitalView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseHospitalView()
    }
}

struct SearchBar: View {
    @Binding var searchText : String
    @Binding var isSearching : Bool
    var body: some View {
        HStack{
            HStack{
                TextField("Search hospital", text: $searchText )
                    .padding(.leading)
            }
            .padding()
            .background(Color(.systemGray5))
            .cornerRadius(6)
            .padding(.horizontal)
            .onTapGesture(perform: {
                isSearching = true
            })
            .overlay(
                HStack{
                    Image(systemName: "magnifyingglass")
                    Spacer()
                    if isSearching{
                        Button(action: {searchText = ""}, label: {
                            Image(systemName: "xmark.circle.fill")
                                .padding(.vertical)
                        })
                    }
                    
                }.padding(.horizontal,32)
                .foregroundColor(.gray)
            ).transition(.move(edge: .trailing))
            .animation(.spring())
            if isSearching{
                Button(action:{
                    isSearching = false
                    searchText = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                },label:{
                    Text("Cancel")
                        .padding(.trailing)
                        .padding(.leading, -12)
                })
                .transition(.move(edge: .trailing))
                .animation(.spring())
            }
        }
    }
}
