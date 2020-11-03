//
//  ChoiceView.swift
//  OrganforEveryone
//
//  Created by Hana Shen on 2020/10/19.
//

import SwiftUI

struct ChoiceView: View {
    @EnvironmentObject var organModel : OrganModel
    var body: some View {
        Form{
            Section(header: Text("Choose hospital")){
                Picker(selection: $organModel.chosenHospital, label: Text("All").tag(nil as Hospital?)){
                    ForEach(organModel.allHospitals.indices, id:\.self) {index in
                        Text(organModel.allHospitals[index].name)
                        
                    }
                }.pickerStyle(MenuPickerStyle())
            }
            Section(header: Text("Choose organ")){
                Picker(selection: $organModel.chosenHospital, label: Text("All").tag(nil as Hospital?)){
                    ForEach(organModel.allHospitals.indices, id:\.self) {index in
                        Text(organModel.allHospitals[index].name)
                        
                    }
                }.pickerStyle(MenuPickerStyle())
            }
            Section(header: Text("Choose patient")){
                Picker(selection: $organModel.chosenHospital, label: Text("First Last Name")){
                    ForEach(organModel.allHospitals.indices, id:\.self) {index in
                        Text(organModel.allHospitals[index].name)
                        
                    }
                }.pickerStyle(MenuPickerStyle())
            }
            Section() {
                HStack {
                    Spacer()
                    NavigationLink(destination: MatchedView()){
                        Button("Check Matchings"){}
                    }
                    Spacer()
                }
            }
        }.navigationTitle("Get Matched")
        
    }
}

//struct ChoiceView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChoiceView()
//    }
//}

